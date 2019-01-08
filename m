From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Tue, 8 Jan 2019 13:03:58 +0800
Message-ID: <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
References: <20190103143227.9138-1-jlee@suse.com>
 <4539995.kc8yiMsNgQ@tauon.chronox.de>
 <20190107153327.GB4210@linux-l9pv.suse>
 <4499700.LRS4F2YjjC@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4499700.LRS4F2YjjC@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 07, 2019 at 04:52:00PM +0100, Stephan Mueller wrote:
>
> Would it make sense to polish these mentioned KDF patches and add them to the 
> kernel crypto API? The sprawl of key derivation logic here and there which 
> seemingly does not comply to any standard and thus possibly have issues should 
> be prevented and cleaned up.

Are we going to have multiple implementations for the same KDF?
If not then the crypto API is not a good fit.  To consolidate
multiple implementations of the same KDF, simply provide helpers
for them.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
