From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 13/13] cpufreq: make sure frequency transitions are serialized
Date: Mon, 24 Jun 2013 15:33:41 +0200
Message-ID: <2165396.dF1lQyPRVT@vostro.rjw.lan>
References: <cover.1371630975.git.viresh.kumar@linaro.org> <11846442.bozySFIXTh@vostro.rjw.lan> <CAKohponQQphBGv9jUCF9_r2NQs7T=wkaWp_d5oO3RT=mY_zqcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponQQphBGv9jUCF9_r2NQs7T=wkaWp_d5oO3RT=mY_zqcg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, dave.martin@arm.com
List-Id: linux-pm@vger.kernel.org

On Monday, June 24, 2013 06:46:39 PM Viresh Kumar wrote:
> On 24 June 2013 18:53, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > You can do
> >
> >         if (WARN(transition_ongoing, "<text>"))
> >                 return;
> >
> > and below analogously.
> 
> Ahh.. stupid code.. Check if this fixup is fine (attached too)

Looks OK, but since transition_ongoing is either 0 or 1 now, as far as I can
say, it would be better to make it a bool and use = true/false instead of
++/-- I suppose.

Thanks,
Rafael


> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6624694..6ca7eac 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -267,10 +267,9 @@ void __cpufreq_notify_transition(struct
> cpufreq_policy *policy,
>         switch (state) {
> 
>         case CPUFREQ_PRECHANGE:
> -               if (transition_ongoing) {
> -                       WARN(1, "In middle of another frequency transition\n");
> +               if (WARN(transition_ongoing,
> +                               "In middle of another frequency transition\n"))
>                         return;
> -               }
> 
>                 transition_ongoing++;
> 
> @@ -293,10 +292,9 @@ void __cpufreq_notify_transition(struct
> cpufreq_policy *policy,
>                 break;
> 
>         case CPUFREQ_POSTCHANGE:
> -               if (!transition_ongoing) {
> -                       WARN(1, "No frequency transition in progress\n");
> +               if (WARN(!transition_ongoing,
> +                               "No frequency transition in progress\n"))
>                         return;
> -               }
> 
>                 transition_ongoing--;
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
