From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/2] cpuidle optimizations (on top of linux-next)
Date: Mon, 18 Jan 2016 13:45:42 +0000
Message-ID: <569CEC86.5080002@arm.com>
References: <1621492.NI2xz9vt7M@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34705 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbcARNpp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Jan 2016 08:45:45 -0500
In-Reply-To: <1621492.NI2xz9vt7M@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>



On 15/01/16 23:53, Rafael J. Wysocki wrote:
> Hi,
>
> When I was looking at the cpuidle code after the Sudeeps's problem report,
> it occured to me that we had some pointless overhead there, so two
> changes to reduce it follow.
>
> [1/2] Make the fallback to to default_idle_call() in call_cpuidle()
>        unnecessary and drop it.
> [2/2] Make menu_select() avoid checking states that don't need to
>        (or even shouldn't) be checked when making the selection.
>

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
