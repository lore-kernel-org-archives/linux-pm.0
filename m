From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] cpufreq: arm-big-little: Make driver dependent on
	CONFIG_BIG_LITTLE
Date: Mon, 6 Jan 2014 01:11:37 +0000
Message-ID: <20140106011137.GE27432@n2100.arm.linux.org.uk>
References: <a76f7b6a290d9174a24e15b13df21f53e3f5655f.1388736624.git.viresh.kumar@linaro.org> <39696841.2xGCnmPGdl@vostro.rjw.lan> <20140106005856.GD27432@n2100.arm.linux.org.uk> <126282099.XSjqFqKQFW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:56871 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752144AbaAFBLn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2014 20:11:43 -0500
Content-Disposition: inline
In-Reply-To: <126282099.XSjqFqKQFW@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 06, 2014 at 02:23:39AM +0100, Rafael J. Wysocki wrote:
> On Monday, January 06, 2014 12:58:56 AM Russell King - ARM Linux wrote:
> > On Mon, Jan 06, 2014 at 02:08:21AM +0100, Rafael J. Wysocki wrote:
> > > On Friday, January 03, 2014 03:51:39 PM Viresh Kumar wrote:
> > > > arm_big_little cpufreq driver is only used for ARM bigLITTLE platforms and hence
> > > > must be dependent on CONFIG_BIG_LITTLE.
> > > > 
> > > > This was highlighted by Russell earlier when he reported this issue:
> > > > 
> > > > drivers/built-in.o: In function `bL_cpufreq_set_rate':
> > > > powercap_sys.c:(.text+0x5ed9a0): undefined reference to `bL_switch_request_cb'
> > > > 
> > > > Reported-by: Russell King <linux@arm.linux.org.uk>
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > 
> > > Queued up for 3.14, thanks!
> > 
> > This is actually a build fix, not a new feature, so IMHO it should go
> > in for 3.13.  Linus has said he's going to do -rc8 anyway next weekend
> > so -final is at the earliest two weeks away.
> 
> Well, it can go into 3.13 too.
> 
> Thanks!

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
