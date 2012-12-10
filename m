From: Julius Werner <jwerner@chromium.org>
Subject: Re: [RFC] cpuidle - remove the power_specified field in the driver
Date: Mon, 10 Dec 2012 11:09:58 -0800
Message-ID: <CAODwPW96ZTXUZjz4B_GET_6UAd4oTednRmrFLe-Jt=EF9n4O1g@mail.gmail.com>
References: <50831CA3.2020602@linaro.org>
	<1352752016-3136-1-git-send-email-daniel.lezcano@linaro.org>
	<50A89F08.7020307@gmail.com>
	<50A8A7BB.2070809@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46054 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab2LJTKA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Dec 2012 14:10:00 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so1688948wib.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Dec 2012 11:09:59 -0800 (PST)
In-Reply-To: <50A8A7BB.2070809@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Trinabh Gupta <g.trinabh@gmail.com>, Lists Linaro-dev <linaro-dev@lists.linaro.org>, len.brown@intel.com, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sameer Nanda <snanda@chromium.org>

Hi,

What is the current status of this? Daniel, do you think you have got
enough feedback to submit a definitive patch for this? Rafael, would
you approve of such a change?

The bug with dynamically added C-states that is tied to this still
hurts the battery life for some users across all distros every day, so
I think it would be valuable to get a consistent solution into the
mainline soon before everyone has to roll their own.

On 11/12/2012 09:26 PM, Daniel Lezcano wrote:
> This patch follows the discussion about reinitializing the power usage
> when a C-state is added/removed.
>
>  https://lkml.org/lkml/2012/10/16/518
>
> We realized the power usage field is never filled and when it is
> filled for tegra, the power_specified flag is not set making all these
> values to be resetted when the driver is initialized with the set_power_state
> function.
>
> Julius and I feel this is over-engineered and the power_specified
> flag could be simply removed and continue assuming the states are
> backward sorted.
>
> The menu governor select function is simplified as the power is ordered.
> Actually the condition is always true with the current code.
>
> The cpuidle_play_dead function is also simplified by doing a reverse lookup
> on the array.
>
> The set_power_states function is removed as it does no make sense anymore.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c        |   17 ++++-------------
>  drivers/cpuidle/driver.c         |   25 -------------------------
>  drivers/cpuidle/governors/menu.c |    8 ++------
>  include/linux/cpuidle.h          |    2 +-
>  4 files changed, 7 insertions(+), 45 deletions(-)
>
