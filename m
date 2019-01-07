From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Date: Mon, 07 Jan 2019 16:52:00 +0100
Message-ID: <4499700.LRS4F2YjjC@tauon.chronox.de>
References: <20190103143227.9138-1-jlee@suse.com> <4539995.kc8yiMsNgQ@tauon.chronox.de> <20190107153327.GB4210@linux-l9pv.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107153327.GB4210@linux-l9pv.suse>
Sender: linux-kernel-owner@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 7. Januar 2019, 16:33:27 CET schrieb joeyli:

Hi Herbert,

> 
> > use an official KDF type like SP800-108 or HKDF?
> > 
> > You find the counter-KDF according to SP800-108 in security/keys/dh.c
> > (search for functions *kdf*).
> > 
> > Or we may start pulling in KDF support into the kernel crypto API via the
> > patches along the line of [1].
> > 
> > [1] http://www.chronox.de/kdf.html
> 
> Thanks for your suggestion. I didn't touch any key derivation standard
> before. I will study it.
> 
> But I still want to use my original function currently. Because the same
> logic is also used in trusted key. I will happy to move to SP800-108 or
> HKDF when it's available in kernel.

Would it make sense to polish these mentioned KDF patches and add them to the 
kernel crypto API? The sprawl of key derivation logic here and there which 
seemingly does not comply to any standard and thus possibly have issues should 
be prevented and cleaned up.

Ciao
Stephan
