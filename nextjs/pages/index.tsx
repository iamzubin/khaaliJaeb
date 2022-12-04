import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>khaaliJaeb</title>
        <meta name="description" content="Matching employees and employers, credibly and privately" />
        <link rel="icon" href="/logo.png" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          khaaliJaen
        </h1>
        <h3>
          empty pockets, full pockets
        </h3>
      </main>
      <footer className={styles.footer}>
      </footer>
    </div>
  )
}
