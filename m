From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel_idle and turbostat patches for Linux-4.3
Date: Sun, 27 Sep 2015 15:55:36 +0200
Message-ID: <1728562.eVm5FbEZtc@vostro.rjw.lan>
References: <1443243915-6696-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52369 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755703AbbI0N1T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2015 09:27:19 -0400
In-Reply-To: <1443243915-6696-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, September 26, 2015 01:05:11 AM Len Brown wrote:
> Hi Rafael,

Hi Len,

> The following patches are available on my "intel_idle"
> and "turbostat" branches, as usual, plus here for review.

There's no intel_idle branch in your tree, but there is a cpuidle one
and I found the patch below in it, so I pulled from there.

> [PATCH 1/4] intel_idle: Skylake Client Support - updated
> 
> 	Initial SKL intel_idle support went into 4.3-rc1.
> 	That patch works, but this patch makes it more optimal,
> 	under some conditions.
> 
> [PATCH 2/4] tools/power turbostat: IVB Xeon: fix --debug regression
> 
> 	This is a regression fix for a 4.1-rc1 patch
> 	It was rude for turbostat to start failing on IVB-Xeon boxes.
> 
> [PATCH 3/4] tools/power turbostat: KNL workaround for %Busy and
> 
> 	This works around a newly documented hardware quirk.
> 
> [PATCH 4/4] tools/power turbostat: SKL: Adjust for TSC difference
> 
> 	This works around an accuracy error that initially
> 	looked insignificant, but on some configurations it will
> 	be big enough to be noticed and confuse users, so here
> 	we address it fully.

Pulled, thanks!

Will push to Linus for 4.3-rc4.

Thanks,
Rafael

