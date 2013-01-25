From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/4 v11] arm: use device tree to get smp_twd clock
Date: Fri, 25 Jan 2013 23:15:39 +0100
Message-ID: <2022065.fFzVbP4vta@vostro.rjw.lan>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com> <3041510.xugDHtFsGr@vostro.rjw.lan> <20130125214000.GA23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130125214000.GA23505@n2100.arm.linux.org.uk>
Sender: cpufreq-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-pm@vger.kernel.org

On Friday, January 25, 2013 09:40:00 PM Russell King - ARM Linux wrote:
> On Fri, Jan 25, 2013 at 10:03:05PM +0100, Rafael J. Wysocki wrote:
> > On Friday, January 25, 2013 01:46:42 PM Mark Langsdorf wrote:
> > > From: Rob Herring <rob.herring@calxeda.com>
> > > 
> > > Move clk setup to twd_local_timer_common_register and rely on
> > > twd_timer_rate being 0 to force calibration if there is no clock.
> > > Remove common_setup_called as it is no longer needed.
> > > 
> > > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > > Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> > 
> > Russell, is this fine with you?
> 
> Looks fine to me, though I had to check twd_calibrate_rate() to make
> sure it wouldn't run if the twd_timer_rate was non-zero.
> 
> If you want an acked-by:
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

I will, thanks a lot!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
