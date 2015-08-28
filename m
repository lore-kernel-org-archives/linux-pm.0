From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/3] cpuidle/coupled: Remove cpuidle_device::safe_state_index
Date: Fri, 28 Aug 2015 16:01:50 +0200
Message-ID: <3985012.PJS8r93OSh@vostro.rjw.lan>
References: <1438667337-16903-1-git-send-email-xlpang@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56432 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752036AbbH1NeQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 09:34:16 -0400
In-Reply-To: <1438667337-16903-1-git-send-email-xlpang@126.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xunlei Pang <xlpang@126.com>
Cc: linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Xunlei Pang <pang.xunlei@linaro.org>

On Tuesday, August 04, 2015 01:48:55 PM Xunlei Pang wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
> 
> cpuidle_device::safe_state_index need to be initialized before
> use, it should be the same as cpuidle_driver::safe_state_index.
> 
> We tackled this issue by removing the safe_state_index from the
> cpuidle_device structure and use the one in the cpuidle_driver
> structure instead.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>

I've queued up this one and the [2/3] for 4.3, but the [3/3] needs some
rework in my view.  I'll reply to it separately.

Thanks,
Rafael

