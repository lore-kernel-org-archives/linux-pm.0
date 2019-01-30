From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH v2 0/6] General Key Derivation Function Support
Date: Wed, 30 Jan 2019 15:39:10 +0100
Message-ID: <12103603.N4N57GesWC@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <5418064.ltLFQScYi2@tauon.chronox.de> <20190130100854.iey2mbmz6777pn2n@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130100854.iey2mbmz6777pn2n@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 30. Januar 2019, 11:08:54 CET schrieb Herbert Xu:

Hi Herbert,

> I'm still not convinced why this needs to go into the crypto API
> instead of being hosted in a helper which should achieve pretty
> much the same result.

How do you propose to handle the FIPS 140-2 related requirements of enforcing 
the integrity test result and the known-answer self tests?

Thanks
Stephan
