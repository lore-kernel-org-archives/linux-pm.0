From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [RFC v4 1/8] PM / Domains: structure changes for multiple states
Date: Wed, 22 Apr 2015 15:23:01 +0200
Message-ID: <5537A0B5.5000507@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>	<1429695935-15815-2-git-send-email-ahaslam@baylibre.com> <CAMuHMdXs_Wytg7xwyQP=+L8enzoT2JBg78YTFe59Zp5K8vbq_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35462 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473AbbDVNXF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 09:23:05 -0400
Received: by widdi4 with SMTP id di4so177594023wid.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 06:23:04 -0700 (PDT)
In-Reply-To: <CAMuHMdXs_Wytg7xwyQP=+L8enzoT2JBg78YTFe59Zp5K8vbq_A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

>>
>> if the genpd is initially off, the user should set the
>> .init_state field when registering the genpd,
>> so that genpd knows which callbacks to call to set the
>> domain to on.
>
> The initial state may depend on various factors (hardware default,
> boot loader, previously loaded kernel, ...). This is even true with the
> current binary states.
>

This would mean that the inital state of the genpd cannot be
hardcoded right?

maybe there should be the option to add  platform callback
to get the initial state from platform specific code or default
to the hardcoded one? this callback could do whatever it needs to return 
the on/off status and if off, the index of the current state.


>> index 45937f8..f60a175 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>
>> @@ -154,23 +155,24 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>>
>>   static int genpd_power_on(struct generic_pm_domain *genpd)
>>   {
>> +       int target_state = genpd->target_state;
>>          ktime_t time_start;
>>          s64 elapsed_ns;
>>          int ret;
>>
>> -       if (!genpd->power_on)
>> +       if (!genpd->states[target_state].power_on)
>>                  return 0;
>>
>
> While your series now looks compilable for all patch steps, it's not
> bisectable: the right hook won't be called until the platform is
> converted to support multiple states.
>
> I think you can fix this by e.g. using -1 for the target_state on non-converted
> platforms, and doing:
>
>          if (target_state < 0) {
>                  if (!genpd->power_on)
>                          return 0;
>          } else {
>                  if (!genpd->states[target_state].power_on)
>                          return 0;
>          }
>
> and
>
>          ret = target_state < 0 ? genpd->power_on(genpd)
>                                 : genpd->states[target_state].power_on(genpd);
>
> The checks for a negative target_state can be removed only after
> all platforms have been converted.
>

Ok, on the next series i will make sure the old callbacks are used until 
they are converted.

>> +       struct genpd_power_state states[GENPD_MAX_NSTATES];
>
> I think states should be a pointer to an array, not an array of 10 entries, to
> avoid wasting memory on systems with a small number of states.

Ok, I had it as pointer on array on the first series, i changed it
to make the code simpler, but i can go back to pointer to array
to save memory.

>
> E.g. on r8a73a4, we have 24 PM Domains.
> That would waste 24 * 9 * 32 = 6912 bytes of memory.
>
> What about keeping the .power_o{ff,n}() callbacks in struct generic_pm_domain,
> but adding a state index parameter to the callbacks?
> That would save even more memory on systems where all callbacks are identical.

makes sense.

Thanks,
Axel

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
