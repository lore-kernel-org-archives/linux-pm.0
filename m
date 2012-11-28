From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ERROR: "devfreq_monitor_resume" undefined!
Date: Wed, 28 Nov 2012 01:36:47 +0100
Message-ID: <2278739.ton8Zzmpxv@vostro.rjw.lan>
References: <50b55470.8yQB+TYqddithSLm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34775 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2K1AcD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 27 Nov 2012 19:32:03 -0500
In-Reply-To: <50b55470.8yQB+TYqddithSLm%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-pm@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>

On Wednesday, November 28, 2012 08:01:52 AM kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> head:   0917293958d5d33213a23125ce5d9c7a852469d6
> commit: 883d588e556347c4b3221ac492a8acd8a75e730a PM / devfreq: remove compiler error when a governor is module
> date:   2 days ago
> config: make ARCH=m68k allmodconfig
> 
> All error/warnings:
> 
> ERROR: "devfreq_monitor_resume" undefined!
> ERROR: "devfreq_monitor_suspend" undefined!
> ERROR: "devfreq_interval_update" undefined!
> ERROR: "devfreq_monitor_stop" undefined!
> ERROR: "devfreq_monitor_start" undefined!

So I dropped the devfreq branch from my linux-next branch again and quite
frankly I'm not going to include it into my first pull request during the v3.8
merge window.

Currently, all the material I got from you is on my pm-devfreq branch.  Please
fix the build problems on top of that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
