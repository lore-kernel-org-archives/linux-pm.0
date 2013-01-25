From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4 v11] arm: use device tree to get smp_twd clock
Date: Fri, 25 Jan 2013 21:40:00 +0000
Message-ID: <20130125214000.GA23505@n2100.arm.linux.org.uk>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com> <1359143205-20279-1-git-send-email-mark.langsdorf@calxeda.com> <1359143205-20279-2-git-send-email-mark.langsdorf@calxeda.com> <3041510.xugDHtFsGr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3041510.xugDHtFsGr@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 25, 2013 at 10:03:05PM +0100, Rafael J. Wysocki wrote:
> On Friday, January 25, 2013 01:46:42 PM Mark Langsdorf wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Move clk setup to twd_local_timer_common_register and rely on
> > twd_timer_rate being 0 to force calibration if there is no clock.
> > Remove common_setup_called as it is no longer needed.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> 
> Russell, is this fine with you?

Looks fine to me, though I had to check twd_calibrate_rate() to make
sure it wouldn't run if the twd_timer_rate was non-zero.

If you want an acked-by:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
