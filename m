From: Adrian Bunk <bunk@stusta.de>
Subject: Re: SOFTWARE_SUSPEND: dependency on non-existing FVR symbol
Date: Thu, 12 Jan 2006 21:43:29 +0100
Message-ID: <20060112204329.GU29663@stusta.de>
References: <20060110043627.GD3911@stusta.de> <20060106202948.GB2736@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161251AbWALUnb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060106202948.GB2736@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2006 at 08:29:48PM +0000, Pavel Machek wrote:
> On Tue 10-01-06 05:36:27, Adrian Bunk wrote:
> > The following issue in kernel/power/Kconfig was noted by
> > Jean-Luc Leger <reiga@dspnet.fr.eu.org>:
> > 
> > config SOFTWARE_SUSPEND
> >         bool "Software Suspend"
> >         depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
> > 
> > 
> > The problem is that there is no FVR symbol in the kernel.
> > 
> > Is this a misspelling of FRV or something different?
> 
> FRV, IIRC, but apparently noone ever tested that.

Should my patch remove or rename it to FRV?

> 								Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
