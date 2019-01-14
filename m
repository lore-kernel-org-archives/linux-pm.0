From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Subject: Re: [PATCH 2/6] crypto: kdf - SP800-108 Key Derivation Function
Date: Mon, 14 Jan 2019 10:31:53 +0100
Message-ID: <1573163.Xcg6e5WDL9@positron.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <1830918.5I3Y3k8tQf@positron.chronox.de> <20190112052758.GD639@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190112052758.GD639@sol.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Samstag, 12. Januar 2019, 06:27:59 CET schrieb Eric Biggers:

Hi Eric,

[...]
> > 
> > +obj-$(CONFIG_CRYPTO_KDF) += kdf.o
> 
> This naming is too generic.  CONFIG_CRYPTO_KDF and kdf.c imply that this is
> related to all KDFs.  But actually it is an implementation of a few specific
> KDFs.  Can you give it a clearer name, like KDF_SP800?
> 
I am going to use kdf_sp800108 or CRYPTO_CONFIG_KDF_SP800108. The reason is 
that there are many SP800 documents.

Thanks

Ciao
Stephan
