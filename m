From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [RFC v5 1/8] PM / Domains: structure changes for multiple states
Date: Mon, 27 Apr 2015 10:26:51 +0200
Message-ID: <553DF2CB.3070306@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>	<1429896924-21540-2-git-send-email-ahaslam@baylibre.com> <CAMuHMdWx=g+NLOcJyCAzhFjM-woMEzZQq1Tn4d+ctpGmzyzDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36448 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbD0I1B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 04:27:01 -0400
Received: by wgen6 with SMTP id n6so107421781wge.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2015 01:26:59 -0700 (PDT)
In-Reply-To: <CAMuHMdWx=g+NLOcJyCAzhFjM-woMEzZQq1Tn4d+ctpGmzyzDxA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

Thanks for the review!

On 26/04/2015 10:42, Geert Uytterhoeven wrote:

>>                  return;
>>
>> +       if (genpd->state_count > 0) {
>> +               /* Copy the state data to allocated memory */
>> +               genpd->states = genpd_alloc_states_data(genpd);
>> +               if (!genpd->states)
>> +                       return;
>> +       }
>> +
>
> So the above replaces genpd->states (which is usually pointing to a an
> array of static data) by an allocated copy?
> Nice trick, but I'm wondering whether it may bite us one day?
> This also means the static data can't be const.
>
> Both could be solved by e.g. passing the states array to pm_genpd_init().

i thought i should avoid adding an argument to init. But you are right, 
i guess its better that way. ill do it on the on the next spin.

BTW, im thinking i should add a default OFF state in case the 
state_count is 0, that way, platforms could not worry about states
at all in case they dont define latencies.


Thanks again,
Axel.

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
