import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Transcribe by DEMO LABS",
  description: "Forward your audios and read them",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <head>
        <link
          rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap"
        />
      </head>
      <body>{children}</body>
    </html>
  );
}
