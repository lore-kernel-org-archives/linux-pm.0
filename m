From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq-cpu0: Use a sane boot frequency when
 booting with a mismatched bootloader configuration
Date: Mon, 18 Nov 2013 23:57:56 +0800
Message-ID: <20131118155753.GU11014@S2101-09.ap.freescale.net>
References: <1384568535-26611-1-git-send-email-nm@ti.com>
 <20131116134445.GI11014@S2101-09.ap.freescale.net>
 <CAKohponU-WFnG8Gx6ba=k3eJmWV_0eWtpsy9kDP8yA2KrdoKtg@mail.gmail.com>
 <528A27F8.3070402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <528A27F8.3070402@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlos Hernandez <ceh@ti.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 18, 2013 at 08:45:12AM -0600, Nishanth Menon wrote:
<snip>
> I do not agree about this stance - device tree describes hardware
> capabilities to kernel -> I agree with that statement. Kernel should
> not care if that is provided by bootloader/firmware/fused into
> flash/ROM etc.

Yea, ideally kernel should just believe that the device tree is always
the correct one.  But the following text in your commit log suggests
that might not be always the case.

| a) older or default bootloader in development platform without latest
| updates
| b) SoC documentation update that may have occurred in kernel
| c) kernel definitions are out of date Vs bootloader which is updated
| etc..
| 
| In these cases, we should assume from a kernel perspective, the only
| safe frequency that the system can be on is the ones available in the
| OPP table. This may not handle case (c), but, that is a different
| kernel bug of it's own.

It says that the device tree might be wrong as well.  That's why I
think the best/safest thing that kernel can do when seeing a mismatch
is to throw out an error message and fail out.

Shawn

> 
> If we agree with that statement, the moment kernel sees device
> operating in a configuration that is not hardware capability, it is
> our job to switch to the right configuration if it is possible for us
> to do so (which in this case, we can). to give a comparison - if i2c
> bus was configured for 3.4MHz and device tree describes the bus to
> operate at 100KHz, do we ignore device tree recommended configuration?
> No. we would switch to 100KHz. as far as kernel is concerned, it can
> detect invalid configuration and switch back to a valid configuration
> based on hardware description provided by device tree.
> 
> 
> 
> -- 
> Regards,
> Nishanth Menon

