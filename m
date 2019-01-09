From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Wed, 09 Jan 2019 07:27:28 +0100
Message-ID: <3239276.QO2kezntxR@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <1565399.7ulKdI1fm5@tauon.chronox.de> <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 9. Januar 2019, 00:54:22 CET schrieb Andy Lutomirski:

Hi Andy,
>=20
> I think that, if the crypto API is going to grow a KDF facility, it should
> be done right. Have a key type or flag or whatever that says =E2=80=9Cthi=
s key may
> *only* be used to derive keys using such-and-such algorithm=E2=80=9D, and=
 have a
> helper to derive a key.  That helper should take some useful parameters a=
nd
> mix them in:
>=20
> - What type of key is being derived?  ECDSA signing key?  HMAC key?  AES
> key?
>=20
> - Can user code access the derived key?
>=20
> - What is the key=E2=80=99s purpose?  =E2=80=9CEncrypt and authenticate a=
 hibernation image=E2=80=9D
> would be a purpose.
>=20
> - Number of bytes.
>=20
> All of these parameters should be mixed in to the key derivation.
>=20
> Also, an AE key, even for AES+HMAC, should be just one derived key.  If y=
ou
> need 512 bits, ask for a 512-bit key, not two 256-bit keys.

I concur with your requirements. However, is the kernel crypto API the righ=
t=20
place to enforce such policies? To me, the kernel crypto API is a tinker-to=
y=20
set of ciphers.

The real policy enforcer would or should be the keyring facility. Thus, may=
 I=20
propose to:

=2D implement the cryptographic primitive of the KDF in the kernel crypto A=
PI

=2D implement the policy system how to use the KDF in the keyring facility

Ciao
Stephan
