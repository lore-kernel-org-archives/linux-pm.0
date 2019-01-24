From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: use BIT() for idle state flags and remove CPUIDLE_DRIVER_FLAGS_MASK
Date: Thu, 24 Jan 2019 11:39:22 +0100
Message-ID: <11142952.kgryYQbe4O@aspire.rjw.lan>
References: <20190115172210.19793-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115172210.19793-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 15, 2019 6:22:10 PM CET Yangtao Li wrote:
> Use BIT() macro to do a small tidy-up. The CPUIDLE_DRIVER_FLAGS_MASK
>  is not being used, so remove it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  include/linux/cpuidle.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 4dff74f48d4b..3b39472324a3 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -69,11 +69,9 @@ struct cpuidle_state {
>  
>  /* Idle State Flags */
>  #define CPUIDLE_FLAG_NONE       (0x00)
> -#define CPUIDLE_FLAG_POLLING	(0x01) /* polling state */
> -#define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
> -#define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
> -
> -#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
> +#define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
> +#define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
> +#define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> 

Applied, even though I'm not a big fan of conversions from open-coded
values (as long as they are correct) to BIT(), unless you are going to
add a new flag and want to use BIT() for that, because that doesn't really
matter and only makes the lives of 'git blame' users harder.

However, in this particular case, the removal of the unused symbol is
legitimate IMO.
