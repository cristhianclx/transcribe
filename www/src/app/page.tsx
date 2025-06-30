"use client";

import { useState, useEffect } from 'react';
import styled from 'styled-components';
import Image from 'next/image';
import { Loader } from './loader';

const Container = styled.div`
  font-family: 'Montserrat', sans-serif;
  background-color: #f5f8f6;
  padding: 0;
  margin: 0;
  text-align: center;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
`;

const Header = styled.header`
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 100px;
  margin-bottom: 50px;
`;

const LogoImage = styled(Image)`
  width: 80px;
  height: 80px;
  margin-right: 15px;
  display: block;
`;

const LogoText = styled.h1`
  font-size: 4rem;
  color: #000;
  font-weight: 700;
  margin: 0;
  line-height: 1;
`;

const HeroTitle = styled.h1`
  font-size: 2rem;
  margin-bottom: 20px;
  color: #000;
  font-weight: 400;
  line-height: 1.3;
`;

const HighlightedText = styled.span`
  position: relative;
  display: inline-block;
  color: #000;

  &:after {
    content: '';
    position: absolute;
    left: 0;
    bottom: -2px;
    width: 100%;
    height: 4px;
    background-color: #4caf50;
  }
`;

const HeroButton = styled.a`
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background-color: #4caf50;
  color: white;
  padding: 15px 30px;
  border-radius: 50px;
  text-decoration: none;
  font-weight: bold;
  font-size: 1.1rem;
  margin-top: 30px;
  margin-bottom: 80px;
  transition: background-color 0.3s;

  &:hover {
    background-color: #43a047;
  }
`;

const Footer = styled.footer`
  background-color: #1a1a1a;
  padding: 50px 20px;
  color: white;
  text-align: center;
  width: 100%;
`;

const FooterContent = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  width: 100%;
`;

const FooterText = styled.div`
  text-align: left;
  margin-bottom: 30px;
  font-size: 1rem;

  h2 {
    font-weight: 700;
    margin-bottom: 10px;
    font-size: 1.6rem;
  }
  p {
    font-size: 1rem;
  }
`;

const FooterLogo = styled.div`
  display: flex;
  align-items: center;
`;

const FooterLogoText = styled.div`
  margin-left: 10px;
  text-align: left;
`;

const FooterLogoImage = styled(Image)`
  width: 40px;
  height: 40px;
`;

const FooterButton = styled.a`
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background-color: #007bff;
  color: white;
  padding: 12px 24px;
  border-radius: 10px;
  text-decoration: none;
  font-weight: bold;
  font-size: 1rem;
  margin-top: 20px;
  transition: background-color 0.3s;

  &:hover {
    background-color: #0056b3;
  }
`;

const FooterBottomText = styled.div`
  font-size: 0.8rem;
  color: #888;
  text-align: left;
  margin-top: 20px;
`;

export default function Home() {
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    setIsLoading(false);
  }, []);

  if (isLoading) {
    return <Loader />;
  }

  return (
    <Container>
      <div>
        <Header>
          <LogoImage src="/logo.png" alt="Transcribe" width={80} height={80} />
          <LogoText>Transcribe</LogoText>
        </Header>
        <HeroTitle>
          Convert WhatsApp <br /><HighlightedText>voice notes</HighlightedText> to <HighlightedText>text</HighlightedText>
        </HeroTitle>
        <HeroButton href="https://wa.me/14849862115">
          Empezar aquí
        </HeroButton>
      </div>
      <Footer>
        <FooterContent>
          <FooterText>
            <h2>DEMO LABS</h2>
            <p>
              DEMO LABS is a company specialized in helping startups and emerging businesses succeed in a competitive marketplace. We develop B2B services and solutions for companies around the world.
            </p>
            <FooterButton href="https://www.demo.pe">
              Our website
            </FooterButton>
          </FooterText>
        </FooterContent>
        <FooterBottomText>
          © 2025 DEMO LABS
        </FooterBottomText>
      </Footer>
    </Container>
  );
}
