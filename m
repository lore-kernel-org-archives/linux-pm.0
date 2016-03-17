From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_idle.max_cstate=1 required on baytrail to prevent crashes
Date: Thu, 17 Mar 2016 15:18:59 +0100
Message-ID: <3870417.33uAD9HvER@vostro.rjw.lan>
References: <56EA5735.1060109@feix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51562 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030852AbcCQOQ7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 10:16:59 -0400
In-Reply-To: <56EA5735.1060109@feix.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Feix <michal@feix.cz>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>

On Thursday, March 17, 2016 08:05:25 AM Michal Feix wrote:
> Hello everyone,

Hi,

> for the past few months, I'm fighting random hard lock-ups on my
> Baytrail machine with different linux kernels. Freezes are quite
> frequent, between few minutes to few hours of uptime. According to other
> reporters, this was pinpointed as an intel_idle problem on Baytrail. The
> bug report originally started as i915 regression at
> https://bugs.freedesktop.org/show_bug.cgi?id=88012 and was moved to
> kernel Bugzilla few months ago -
> https://bugzilla.kernel.org/show_bug.cgi?id=109051
> 
> This bug seems to be a serious showstopper for Baytrail users and was
> already confirmed by many, but there is no obvious progress on this bug
> report for last few months. Meny reporters have confirmed
> intel_idle.max_cstate=1 or intel_idle.max_cstate=2 as a half-working
> workaround, which makes the interval between freezes on Baytrail longer.
> 
> Could someone here please confirm if this is in or out of anyone's
> current focus? I strongly believe this is not a minority issue and maybe
> this just slipped through meny other important bug reports.

No, it hasn't, but it turns out difficult to root-cause.

Tell me one thing: does disabling intel_idle entirely on the affected systems
make the problem go away?

That is, does intel_idle.max_cstate=0 in the kernel command line help?

Or does idle=nomwait in the kernel command line help?

Thanks,
Rafael

