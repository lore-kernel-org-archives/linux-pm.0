From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: kirkwood: Reinstate cpufreq driver for ARCH_KIRKWOOD
Date: Fri, 18 Jul 2014 03:08:57 +0200
Message-ID: <5801914.DoQzr9v8uz@vostro.rjw.lan>
References: <1404987355.23201.65.camel@samson1.armitage.org.uk> <20140710135859.GL21833@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140710135859.GL21833@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Quentin Armitage <quentin@armitage.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 10, 2014 03:58:59 PM Andrew Lunn wrote:
> On Thu, Jul 10, 2014 at 11:15:55AM +0100, Quentin Armitage wrote:
> > Commit ff1f0018cf66080d8e6f59791e552615648a033a ("drivers: Enable
> > building of Kirkwood drivers for mach-mvebu") added Kirkwood into
> > mach-mvebu, adding MACH_KIRKWOOD to ARCH_KIRKWOOD in the KConfig files.
> > 
> > The change for ARM_KIRKWOOD_CPUFREQ replaced ARCH_KIRKWOOD with
> > MACH_KIRKWOOD, whereas all the other changes were ARCH_KIRKWOOD ||
> > MACH_KIRKWOOD.
> > 
> > As a consequence of this change, the cpufreq driver is no longer enabled
> > for ARCH_KIRKWOOD. This patch reinstates ARM_KIRKWOOD_CPUFREQ for
> > ARCH_KIRKWOOD.
> > 
> > Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
> > ---
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index ebac671..24778f0 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -118,7 +118,7 @@ config ARM_INTEGRATOR
> >           If in doubt, say Y.
> > 
> >  config ARM_KIRKWOOD_CPUFREQ
> > -       def_bool MACH_KIRKWOOD
> > +       def_bool ARCH_KIRKWOOD || MACH_KIRKWOOD
> >         help
> >           This adds the CPUFreq driver for Marvell Kirkwood
> >           SoCs.
> 
> Acked-by: Andrew Lunn <andrew@lunn.ch>

Applied, thanks!
