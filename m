From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [Patch v3] 0/7] Remove mach-kirkwood
Date: Mon, 1 Sep 2014 16:03:20 +0200
Message-ID: <20140901140320.GE11312@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
 <1997148.5Fa3W8ZmXx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1997148.5Fa3W8ZmXx@vostro.rjw.lan>
Sender: linux-leds-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 01, 2014 at 03:56:43PM +0200, Rafael J. Wysocki wrote:
> On Saturday, August 30, 2014 06:46:05 PM Andrew Lunn wrote:
> > This is mostly a resend of these patches, removing mach-kirkwood.  Not
> > all maintainers picked up there patches, which has resulted in some
> > dead kernel configuration in v3.17-rcX.
> > 
> > The patch set has been rebased on v3.17-rc2, and it is intended that
> > Jason Cooper will submit them for inclusion in an RC. Subsystem
> > maintainers do not need to do anything.
> > 
> > The last patch "cpufreq: Remove ARCH_KIRKWOOD dependency" is new,
> > since what it is removing was added during v3.16-rcX. It follows the
> > pattern of all the other patches.
> > 
> > Andrew Lunn (7):
> >   cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
> >   ata: Remove ARCH_KIRKWOOD dependency
> >   thermal: Remove ARCH_KIRKWOOD dependency
> >   leds: Remove ARCH_KIRKWOOD dependency
> >   rtc: Remove ARCH_KIRKWOOD dependency
> >   watchdog: Remove ARCH_KIRKWOOD dependency
> >   cpufreq: Remove ARCH_KIRKWOOD dependency
> 
> I have no problems with these changes, but what exactly am I supposed to do?

Jason will submit the whole series. So an Acked-by: would be nice.

      Andrew
