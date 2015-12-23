From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq/scpi: fix handling return value of
 topology_physical_package_id
Date: Wed, 23 Dec 2015 10:48:24 +0000
Message-ID: <567A7BF8.1030107@arm.com>
References: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:SYSTEM CONTROL & POWER INTERFACE (SCPI) Message..." <linux-arm-kernel@lists.infradead.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 23/12/15 10:37, Andrzej Hajda wrote:
> The function can return negative values, so its result should
> be assigned to signed variable.
>
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
>
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
>

There has a patch posted by Dan Carpenter [1] which I reposted[2],
but it again slipped through the cracks. I will poke Rafael again on that.

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380292.html
[2] https://lkml.org/lkml/2015/12/15/219

-- 
Regards,
Sudeep
