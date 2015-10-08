From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Thu, 8 Oct 2015 17:51:01 +0200
Message-ID: <20151008155100.GI11776@xo-6d-61-c0.localdomain>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151001175849.GH4469@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > What's the advantage of pushing this to userspace?  By the time we
> > provide enough discoverability to enable userspace to configure itself
> > it seems like we'd have enough information to do the job anyway.
> 
> you're going to be dealing with a setup where each vendor does one thing
> differently. Some will have it all in the SoC part of a single IP (dwc3 can be
> configured that way), some will push it out to companion IC, some might even use
> some mostly discrete setup and so on...
> 
> We're gonna be dealing with a decision that involves information from multiple
> subsystems (USB, regulator, hwmon, power supply to name a few).
> 
> We tried doing it all in the kernel back in N800, N810 and N900/N9 days and it's
> just plain difficult. To make matters worse, N900 had two USB PHYs, one for
> actual runtime use and another just for detecting the charger type on the other
> end.

N900 does charging from kernel these days.

Not being able to boot generic distribution would be regression there...

										Pavel
