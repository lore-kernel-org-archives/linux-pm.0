From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 1/3] cpuidle/menu: stop seeking deeper idle if current
 state is too deep
Date: Thu, 05 Jan 2017 10:43:59 -0500
Message-ID: <1483631039.25514.1.camel@redhat.com>
References: <1483630187-29622-1-git-send-email-alex.shi@linaro.org>
         <1483630187-29622-2-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968105AbdAEPoC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Jan 2017 10:44:02 -0500
In-Reply-To: <1483630187-29622-2-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, open list <linux-kernel@vger.kernel.org>
Cc: linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>

On Thu, 2017-01-05 at 23:29 +0800, Alex Shi wrote:
> The obsolete commit 71abbbf85 want to introduce a dynamic cstates,
> but it was removed for long time. Just left the nonsense deeper
> cstate
> checking.
> 
> Since all target_residency and exit_latency are going longer in
> deeper
> idle state, no needs to waste some cpu cycle on useless seeking.

Makes me wonder if it would be worth documenting the
requirement that c-states be listed in increasing
order?

Acked-by: Rik van Riel <riel@redhat.com>
