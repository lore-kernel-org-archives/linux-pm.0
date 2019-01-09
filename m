From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Wed, 09 Jan 2019 07:34:48 -0800
Message-ID: <1547048088.2879.6.camel@HansenPartnership.com>
References: <20190103143227.9138-1-jlee@suse.com>
         <309406107.k3W2fMQUza@tauon.chronox.de>
         <1547017108.2789.24.camel@HansenPartnership.com>
         <1894062.aDvIuj92vB@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1894062.aDvIuj92vB@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Andy Lutomirski <luto@amacapital.net>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2019-01-09 at 08:05 +0100, Stephan Mueller wrote:
> Am Mittwoch, 9. Januar 2019, 07:58:28 CET schrieb James Bottomley:
> 
> Hi James,
> 
> > On Wed, 2019-01-09 at 07:45 +0100, Stephan Mueller wrote:
> > > Am Mittwoch, 9. Januar 2019, 01:44:31 CET schrieb James
> > > Bottomley:
> > > 
> > > Hi James,
> > > 
> > > > Actually, it would be enormously helpful if we could reuse
> > > > these pieces for the TPM as well.
> > > 
> > > Could you please help me understand whether the KDFs in TPM are
> > > directly usable as a standalone cipher primitive or does it go
> > > together with additional  key generation operations?
> > 
> > They're used as generators ... which means they deterministically
> > produce keys from what the TPM calls seeds so we can get crypto
> > agility of TPM 2.0 ... well KDFa does.  KDFe is simply what NIST
> > recommends you do when using EC for a shared key agreement ... and
> > really we shouldn't be using ECDH in the kernel without it.
> > 
> 
> Thanks for clarifying. That would mean that indeed we would have
> hardware-provided KDF implementations that may be usable with the
> kernel crypto API.

Just on this point, the TPM doesn't actually provide any KDFa or e API,
so it can't be used for hardware acceleration (and even if it did, the
TPM is a pretty slow engine, so software would be faster anyway).  We
need these algorithms in software because the TPM uses key agreements
derived from shared secrets to produce session encryption keys to
ensure confidentiality and integrity (HMAC key), so we establish the
shared secret then have to derive our key in software and the TPM
derives the same key internally and we use the shared derived key to
symmetrically encrypt and/or HMAC secret communications.

James
