From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 1/3] cpuidle: coupled: disable interrupts after entering
 safe state
Date: Fri, 23 Aug 2013 17:22:29 -0700
Message-ID: <CAMbhsRQzmyftujGhD+b7WwdXWP9b+=R0D7SavgKSjWKuFNLejQ@mail.gmail.com>
References: <1377287112-12018-1-git-send-email-ccross@android.com>
	<5217EB9A.5050206@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:60559 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab3HXAWa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 20:22:30 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so1545010oag.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2013 17:22:30 -0700 (PDT)
In-Reply-To: <5217EB9A.5050206@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Neil Zhang <zhangwm@marvell.com>, Joseph Lo <josephl@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>, stable@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Aug 23, 2013 at 4:09 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/23/2013 01:45 PM, Colin Cross wrote:
>> Calling cpuidle_enter_state is expected to return with interrupts
>> enabled, but interrupts must be disabled before starting the
>> ready loop synchronization stage.  Call local_irq_disable after
>> each call to cpuidle_enter_state for the safe state.
>
> Tested-by: Stephen Warren <swarren@nvidia.com>
>
> Note: I tested the current Tegra cpuidle code that's in next-20130819.
> IIRC, Joseph reported the issue when trying to enable some additional
> feature in Tegra30 cpuidle. I didn't actually try to enable whatever
> that was; I just briefly tested for regressions in the existing code
> configuration.

Is that for the series or just this patch?
