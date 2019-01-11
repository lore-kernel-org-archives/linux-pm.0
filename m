From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Fri, 11 Jan 2019 16:02:26 +0200
Message-ID: <20190111140226.GA6448@linux.intel.com>
References: <20190103143227.9138-1-jlee@suse.com>
 <4499700.LRS4F2YjjC@tauon.chronox.de>
 <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
 <1565399.7ulKdI1fm5@tauon.chronox.de>
 <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
 <1546994671.6077.10.camel@HansenPartnership.com>
 <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Stephan Mueller <smueller@chronox.de>, Herbert Xu <herbert@gondor.apana.org.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 08, 2019 at 05:43:53PM -0800, Andy Lutomirski wrote:
> (Also, do we have a sensible story of how the TPM interacts with
> hibernation at all?  Presumably we should at least try to replay the
> PCR operations that have occurred so that we can massage the PCRs into
> the same state post-hibernation.  Also, do we have any way for the
> kernel to sign something with the TPM along with an attestation that
> the signature was requested *by the kernel*?  Something like a
> sub-hierarchy of keys that the kernel explicitly prevents userspace
> from accessing?)

Kernel can keep it is own key hierarchy in memory as TPM2 chips allow
to offload data in encrypted form and load it to TPM when it needs to
use it.

The in-kernel resource manager that I initiated couple years ago
provides this type of functionality.

/Jarkko
