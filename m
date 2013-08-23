From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/3] cpuidle: coupled: disable interrupts after entering
 safe state
Date: Fri, 23 Aug 2013 17:09:14 -0600
Message-ID: <5217EB9A.5050206@wwwdotorg.org>
References: <1377287112-12018-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60519 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab3HWXPR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 19:15:17 -0400
In-Reply-To: <1377287112-12018-1-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Neil Zhang <zhangwm@marvell.com>, Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org, stable@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 08/23/2013 01:45 PM, Colin Cross wrote:
> Calling cpuidle_enter_state is expected to return with interrupts
> enabled, but interrupts must be disabled before starting the
> ready loop synchronization stage.  Call local_irq_disable after
> each call to cpuidle_enter_state for the safe state.

Tested-by: Stephen Warren <swarren@nvidia.com>

Note: I tested the current Tegra cpuidle code that's in next-20130819.
IIRC, Joseph reported the issue when trying to enable some additional
feature in Tegra30 cpuidle. I didn't actually try to enable whatever
that was; I just briefly tested for regressions in the existing code
configuration.
