From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 2/2] ARM: cpuidle: Refactor rollback operations if init
 fails
Date: Wed, 11 Oct 2017 11:49:16 +0200
Message-ID: <2c39f935-9fd1-fb96-d6db-c9dd92e2d833@linaro.org>
References: <1507614476-16054-1-git-send-email-leo.yan@linaro.org>
 <1507614476-16054-2-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507614476-16054-2-git-send-email-leo.yan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/10/2017 07:47, Leo Yan wrote:
> If init fails, we need execute two levels rollback operations: the first
> level is for the failed CPU rollback operations, the second level is to
> iterate all succeeded CPUs to cancel their registration; currently the
> code uses one function to finish these two levels rollback operations.
> 
> This commit is to refactor rollback operations, so it adds a new
> function arm_idle_init_cpu() to encapsulate one specified CPU driver
> registration and rollback the first level operations; and use function
> arm_idle_init() to iterate all CPUs and finish the second level's
> rollback operations.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
