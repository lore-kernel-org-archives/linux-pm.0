From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Tue, 8 Jan 2019 15:54:22 -0800
Message-ID: <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
References: <20190103143227.9138-1-jlee@suse.com> <4499700.LRS4F2YjjC@tauon.chronox.de> <20190108050358.llsox32hggn2jioe@gondor.apana.org.au> <1565399.7ulKdI1fm5@tauon.chronox.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565399.7ulKdI1fm5@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org


> On Jan 7, 2019, at 11:09 PM, Stephan Mueller <smueller@chronox.de> wrote:
>=20
> Am Dienstag, 8. Januar 2019, 06:03:58 CET schrieb Herbert Xu:
>=20
> Hi Herbert,
>=20
>> Are we going to have multiple implementations for the same KDF?
>> If not then the crypto API is not a good fit.  To consolidate
>> multiple implementations of the same KDF, simply provide helpers
>> for them.
>=20
> It is unlikely to have multiple implementations of a KDF. However, KDFs re=
late=20
> to hashes like block chaining modes to raw block ciphers. Thus a KDF can b=
e=20
> applied with different hashes.
>=20
> My idea was to add template support to RNGs (because KDFs are effectively a=
=20
> type of RNG since they produce an arbitrary output from a fixed input). Th=
e=20
> KDFs would be a template wrapping hashes. For example, the CTR-KDF from=20=

> SP800-108 could be instantiated like kdf-ctr(sha256).
>=20
>=20

I think that, if the crypto API is going to grow a KDF facility, it should b=
e done right. Have a key type or flag or whatever that says =E2=80=9Cthis ke=
y may *only* be used to derive keys using such-and-such algorithm=E2=80=9D, a=
nd have a helper to derive a key.  That helper should take some useful param=
eters and mix them in:

- What type of key is being derived?  ECDSA signing key?  HMAC key?  AES key=
?

- Can user code access the derived key?

- What is the key=E2=80=99s purpose?  =E2=80=9CEncrypt and authenticate a hi=
bernation image=E2=80=9D would be a purpose.

- Number of bytes.

All of these parameters should be mixed in to the key derivation.

Also, an AE key, even for AES+HMAC, should be just one derived key.  If you n=
eed 512 bits, ask for a 512-bit key, not two 256-bit keys.=
