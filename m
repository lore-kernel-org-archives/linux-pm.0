From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 0/5 v2][RFC] Encryption and authentication for hibernate
 snapshot image
Date: Fri, 11 Jan 2019 22:29:59 +0800
Message-ID: <20190111142959.GZ3599@linux-l9pv.suse>
References: <20190103143227.9138-1-jlee@suse.com>
 <CALCETrWHjn_WN1WRc2pbFPB+H-ZL_1y=8dhhHoVqA53Q7Pj5vA@mail.gmail.com>
 <20190109163958.GG9503@linux-l9pv.suse>
 <2049173.FbhQ43HnNr@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2049173.FbhQ43HnNr@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: Andy Lutomirski <luto@kernel.org>, Pavel Machek <pavel@ucw.cz>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 09, 2019 at 05:47:53PM +0100, Stephan Mueller wrote:
> Am Mittwoch, 9. Januar 2019, 17:39:58 CET schrieb joeyli:
> 
> Hi joeyli,
> 
> > 
> > I am doing encrypt-then-MAC.
> 
> Note, this is what the authenc() AEAD cipher does.
>

OK.. Thanks for your reminding. I will look at it.

Joey Lee 
