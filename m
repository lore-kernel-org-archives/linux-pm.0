From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: thermal: uevent/netlink with step_wise?
Date: Wed, 1 Apr 2015 14:17:18 -0700
Message-ID: <20150401211718.GA32500@ld-irv-0074>
References: <20150331224348.GZ32500@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34209 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbDAVR2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 17:17:28 -0400
Received: by pactp5 with SMTP id tp5so63246487pac.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2015 14:17:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150331224348.GZ32500@ld-irv-0074>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "R.Durgadoss" <durgadoss.r@intel.com>, Len Brown <len.brown@intel.com>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>

On Tue, Mar 31, 2015 at 03:43:48PM -0700, Brian Norris wrote:
> Particularly, I'm looking right now at using the uevent/netlink
> notification mechanism. It seems that this is only active when we use
> the 'user_space' governor, meaning I can't get any user-space
> notifications when using the in-kernel governor. Am I missing something,
> or is this a known limitation? Is there any reason we can't enable both?
> For the user-space side, I'd mostly be interested in being a consumer;
> e.g., display warnings in high-temperature scenarios; although I might
> also use it to trigger some user-space cooling mechanisms.

I'm noticing two additional interesting details.

1. There's a separate netlink event mechanism that has never been used.
See generate_netlink_event(), from this commit:

commit 4cb18728709683c91a5f6f8d5f337bfb498b089a
Author: R.Durgadoss <durgadoss.r@intel.com>
Date:   Wed Oct 27 03:33:29 2010 +0530

    thermal: Add event notification to thermal framework

2. The Samsung Exynos thermal driver reports uevent info directly, no
matter which governor is in use. See exynos_report_trigger(). Is it
acceptable to augment drivers in this way, or wouldn't it make more
sense to improve the core framework to support this type of
notification?

Brian
