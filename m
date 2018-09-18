From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 3/4][v2] x86, hibernate: Extract the common code of 64/32
 bit system
Date: Tue, 18 Sep 2018 21:36:44 +0800
Message-ID: <20180918133643.GA3120@chenyu-desktop>
References: <cover.1536685746.git.yu.c.chen@intel.com>
 <7266f9b93000c57edd41fcf2cee0dd4d6252a8ef.1536685746.git.yu.c.chen@intel.com>
 <3135968.eiNgRHp3gn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3135968.eiNgRHp3gn@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Zhimin Gu <kookoo.gu@intel.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Fri, Sep 14, 2018 at 11:21:17AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 11, 2018 7:20:46 PM CEST Chen Yu wrote:
> > From: Zhimin Gu <kookoo.gu@intel.com>
> > 
> > Reduce the hibernation code duplication between x86-32 and x86-64
> > by extracting the common code into hibernate.c.
> > 
> > No functional change.
> > 
> > +#include "hibernate.c"
> 
> I don't particularly like this.
> 
> Why excatly do you need to include the C file here?
>
OK, I've removed this in a new version.
> Also, the way this change is made makes it quite hard to review, as the
> new code is not exactly the same as the code being removed, so it is
> hard to say whether or not there really are no functional changes
> as claimed.
I've splitted the patch into several sub-patches and reorganized the
code to make it more readable on a new version.
> 
> This is sensitive code, mind you, and really hard to debug if anything goes
> wrong.  Please be super-careful about changing it.
> 
Ok, will test on several platforms and send out the modification.
Best,
Yu
> Thanks,
> Rafael
> 
