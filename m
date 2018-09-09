From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: enter_state: Don't needlessly calculate diff time
Date: Sun, 9 Sep 2018 21:40:25 +0200
Message-ID: <CAJZ5v0jwQBWu_Vw=Wmao3BDgCnutsLTq68Niyb46Y9wZ6DZb+A@mail.gmail.com>
References: <20180907185448.30987-1-kw@fieahl.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907185448.30987-1-kw@fieahl.im>
Sender: linux-kernel-owner@vger.kernel.org
To: kw@fieahl.im
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 7, 2018 at 8:55 PM Fieah Lim <kw@fieahl.im> wrote:
>
> ktime_us_delta() is not that cheap on some platform,
> and I think this is also the right thing to do.
> While at it, fix some coding style as well.
>
> Signed-off-by: Fieah Lim <kw@fieahl.im>

Fix your changelog at least to say that you optimize the code without
changing its functionality.

> ---
>  drivers/cpuidle/cpuidle.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 6df894d65d9e..5f6b2c9b6555 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         if (!cpuidle_state_is_coupled(drv, index))
>                 local_irq_enable();
>
> -       diff = ktime_us_delta(time_end, time_start);
> -       if (diff > INT_MAX)
> -               diff = INT_MAX;
> -
> -       dev->last_residency = (int) diff;
> +       dev->last_residency = 0;
>
>         if (entered_state >= 0) {
> -               /* Update cpuidle counters */
> -               /* This can be moved to within driver enter routine
> +               /* Update cpuidle counters
> +                * This can be moved to within driver enter routine,
>                  * but that results in multiple copies of same code.
>                  */
> +               diff = ktime_us_delta(time_end, time_start);
> +               if (diff > INT_MAX)
> +                       diff = INT_MAX;
> +
> +               dev->last_residency = (int)diff;
>                 dev->states_usage[entered_state].time += dev->last_residency;
>                 dev->states_usage[entered_state].usage++;
> -       } else {
> -               dev->last_residency = 0;
>         }
>
>         return entered_state;
> --
> 2.18.0
>
