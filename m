From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Tue, 08 Jan 2019 16:44:31 -0800
Message-ID: <1546994671.6077.10.camel@HansenPartnership.com>
References: <20190103143227.9138-1-jlee@suse.com>
         <4499700.LRS4F2YjjC@tauon.chronox.de>
         <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
         <1565399.7ulKdI1fm5@tauon.chronox.de>
         <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, Stephan Mueller <smueller@chronox.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2019-01-08 at 15:54 -0800, Andy Lutomirski wrote:
> > On Jan 7, 2019, at 11:09 PM, Stephan Mueller <smueller@chronox.de>
> > wrote:
> > 
> > Am Dienstag, 8. Januar 2019, 06:03:58 CET schrieb Herbert Xu:
> > 
> > Hi Herbert,
> > 
> > > Are we going to have multiple implementations for the same KDF?
> > > If not then the crypto API is not a good fit.  To consolidate
> > > multiple implementations of the same KDF, simply provide helpers
> > > for them.
> > 
> > It is unlikely to have multiple implementations of a KDF. However,
> > KDFs relate to hashes like block chaining modes to raw block
> > ciphers. Thus a KDF can be applied with different hashes.
> > 
> > My idea was to add template support to RNGs (because KDFs are
> > effectively a type of RNG since they produce an arbitrary output
> > from a fixed input). The KDFs would be a template wrapping hashes.
> > For example, the CTR-KDF from SP800-108 could be instantiated like
> > kdf-ctr(sha256).
> > 
> > 
> 
> I think that, if the crypto API is going to grow a KDF facility, it
> should be done right. Have a key type or flag or whatever that says
> “this key may *only* be used to derive keys using such-and-such
> algorithm”, and have a helper to derive a key.  That helper should
> take some useful parameters and mix them in:
> 
> - What type of key is being derived?  ECDSA signing key?  HMAC
> key?  AES key?
> 
> - Can user code access the derived key?
> 
> - What is the key’s purpose?  “Encrypt and authenticate a hibernation
> image” would be a purpose.
> 
> - Number of bytes.
> 
> All of these parameters should be mixed in to the key derivation.
> 
> Also, an AE key, even for AES+HMAC, should be just one derived
> key.  If you need 512 bits, ask for a 512-bit key, not two 256-bit
> keys.

Actually, it would be enormously helpful if we could reuse these pieces
for the TPM as well.  It has two KDFs: KDFa, which is the CTR-KDF from
SP800-108 and KDFe which is the SP800-56A KDF for elliptic curve one
pass Diffie Hellman, so if we're going to do the former, I'd really
like the latter as well.

The way the TPM parametrises input to both KDFs is

(hashAlg, key, label, contextU, contextV, bits)

Where

hashAlg  = the hash algorithm used as the PRF
key      = the input parameter of variable bit size or
           the x co-ordinate of the shared point
label    = An ASCII string representing the use
contextU = public input U
contextV = public input V
bits     = number of output bits

Is that a good enough parametrisation (not the only way you distinguish
uses is with the label, which is not recoverable)?  ContextU and
ContextV are simply concatenated to form the full Context of SP800-108, 
but we tend to need two separate inputs (for KDFe they're the public x
co-ordinates of the points of the two inputs to ECDH for instance; in
KDFa they're usually the local and remote nonces).

The labels for TPM usage are things like "INTEGRITY" for HMAC keys or
"CFB" when generating an aes128-cfb session key. For KDFe, the tpm
seems to like the label "SECRET".  Although the TPM specifies fixed
short strings for the label, nothing prevents them being longer like
the purpose you state above (essentially we could mix purpose, use and
key type into the label and the contexts).

>From the point of view of accelerators, the only thing you really need
to know is the hash algorthim (PRF), because everything else above is
an input to the function, so I suppose it makes sense to name them as
kdf-X(PRF)  where X would be ctr or ecdh and PRF would be a hash.

James
