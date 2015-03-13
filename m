From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/6] ARM64: cpuidle: Replace cpu_suspend by the common
 ARM/ARM64 function
Date: Fri, 13 Mar 2015 18:21:03 +0000
Message-ID: <20150313182102.GS30671@e104818-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425385777-14766-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lina.iyer@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 03, 2015 at 01:29:34PM +0100, Daniel Lezcano wrote:
> Call the common ARM/ARM64 'arm_cpuidle_suspend' instead of cpu_suspend function
> which is specific to ARM64.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-arm64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> index 39a2c62..0cea244 100644
> --- a/drivers/cpuidle/cpuidle-arm64.c
> +++ b/drivers/cpuidle/cpuidle-arm64.c
> @@ -49,7 +49,7 @@ static int arm64_enter_idle_state(struct cpuidle_device *dev,
>  		 * call the CPU ops suspend protocol with idle index as a
>  		 * parameter.
>  		 */
> -		ret = cpu_suspend(idx);
> +		arm_cpuidle_suspend(idx);

Nitpick: why don't we just rename the arm one cpuidle_suspend()?

-- 
Catalin
