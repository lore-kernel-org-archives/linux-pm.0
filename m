From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/7] ARM/ARM64: cpuidle: Let back-end init ops take the
 driver as input
Date: Thu, 28 Feb 2019 16:30:55 +0100
Message-ID: <37c1fd29-a888-4ae5-ae7b-3d4c00812941@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-5-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228135919.3747-5-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> To allow arch back-end init ops to operate on the cpuidle driver for the
> corresponding CPU, let's pass along a pointer to the struct cpuidle_driver*
> and forward it the relevant layers of callbacks for ARM/ARM64.
> 
> Following changes for the PSCI firmware driver starts making use of this.
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
