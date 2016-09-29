From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Thu, 29 Sep 2016 22:52 +0200
Message-ID: <3974136.cL3VK0LFyr@vostro.rjw.lan>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net> <16590757.26uEfRfeet@vostro.rjw.lan> <1475164576.5547.10.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475164576.5547.10.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 29, 2016 08:56:16 AM Srinivas Pandruvada wrote:
> On Thu, 2016-09-29 at 14:19 +0200, Rafael J. Wysocki wrote:
> 
> [...]
> 
> > > My laptop was inadvertently put to sleep while I was gone. I forgot
> > > to leave a 
> > > note for my wife and she quieted the noisy cpu fan. :)
> > It looks like in 4.8-rc we made a change that caused the "high" trip
> > point to
> > be acted on.
> This high trip point we don't expose in thermal subsystem (the thermal
>  zone dump didn't show this anywhere as a trip). This is exposed by
> core-dts driver only. This is the point BIOS is supposed to act, I
> guess that's why you are seeing 50% clock modulation. 

Right.  That's SMM kicking in.

The real problem is that we get stuck at 400 MHz.

Thanks,
Rafael
