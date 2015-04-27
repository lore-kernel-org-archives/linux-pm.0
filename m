From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [RFC v5 5/8] ARM: r8a7779: pm: Convert to multiple states
Date: Mon, 27 Apr 2015 11:32:59 +0200
Message-ID: <553E024B.3090807@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>	<1429896924-21540-6-git-send-email-ahaslam@baylibre.com> <CAMuHMdWKGu1hJ=EE2_rw-2j-NLxg-uUe1sOfWW=ALR+ojVD3xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36742 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbbD0JdD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 05:33:03 -0400
Received: by wgen6 with SMTP id n6so109178031wge.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2015 02:33:01 -0700 (PDT)
In-Reply-To: <CAMuHMdWKGu1hJ=EE2_rw-2j-NLxg-uUe1sOfWW=ALR+ojVD3xQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

On 26/04/2015 10:43, Geert Uytterhoeven wrote:
> On Fri, Apr 24, 2015 at 7:35 PM,  <ahaslam@baylibre.com> wrote:
>> --- a/arch/arm/mach-shmobile/pm-r8a7779.c
>> +++ b/arch/arm/mach-shmobile/pm-r8a7779.c
>> @@ -79,6 +79,12 @@ static bool pd_active_wakeup(struct device *dev)
>>          return true;
>>   }
>>
>> +struct genpd_power_state r8a7779_genpd_states[] = {
>> +       {
>> +               .name = "OFF",
>> +       }
>> +};
>> +
>>   static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
>>   {
>>          struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
>> @@ -88,6 +94,8 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
>>          genpd->dev_ops.active_wakeup = pd_active_wakeup;
>>          genpd->power_off = pd_power_down;
>>          genpd->power_on = pd_power_up;
>> +       genpd->states = r8a7779_genpd_states;
>> +       genpd->state_count = ARRAY_SIZE(r8a7779_genpd_states);
>
> The states are set _after_ pm_genpd_init(), so this won't work.
>
> BTW, no idea why all these genpd fields are set after that call. Perhaps
> originally they had to override defaults set by pm_genpd_init()?

good catch!

im not sure why they are set after either. i guess they should be moved. 
non of those fields seem to be set by the init today.

Anyways, the issue with the states array will be fixed once they are 
passed as paramers to the init, on the next spin.


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
