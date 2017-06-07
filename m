From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Extend generic power domain debugfs.
Date: Wed, 7 Jun 2017 15:15:39 -0400
Message-ID: <593850DB.1080709@linaro.org>
References: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
 <1495756293-29534-3-git-send-email-thara.gopinath@linaro.org>
 <CAMuHMdUg0Hoza6xNCjjrPkbqFWa13hWPnAYJ8yOsWUqOTm8zAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36753 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbdFGTP6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 15:15:58 -0400
Received: by mail-qt0-f174.google.com with SMTP id u19so17535347qta.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 12:15:53 -0700 (PDT)
In-Reply-To: <CAMuHMdUg0Hoza6xNCjjrPkbqFWa13hWPnAYJ8yOsWUqOTm8zAg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>

Hi Geert,

On 05/29/2017 11:12 AM, Geert Uytterhoeven wrote:
> Hi Thara,
> 
> On Fri, May 26, 2017 at 1:51 AM, Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
>> This patch extends the existing generic power domain debugfs.
>> Changes involve the following
>> - Remove the current flat format of displaying generic power domain
>>   summary.
>> - Introduce a unique debugfs entry for each generic power domain with the
>>   following attributes
>>         - current_state - Displays current state of the domain.
>>         - devices - Displays the devices associated with this domain.
>>         - slaves - Displays the sub power domains.
>>         - on_time - Displays the time the domain was in on state in ms.
>>         - idle_time - Displays the time the domain was in any of the idle
>>                         states in ms.
>>         - idle_states - Displays the various idle states and the time
>>                         spent in each idle state in ms.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> While I don't doubt the merits of having all this additional information in
> separate debugfs files, I think it would be a good idea to keep the existing
> summary.

Since you have a need for the summary, I will keep it intact and post a
new version of the patches.

> 
> Cfr. the clock subsystem, which provides both a summary, and clock-specific
> information in individual files.
> 
> BTW, if people disagree, I'll have to write a script to extract all information
> and combine it into a single file ;-) I tend to compare these summaries across
> boots...
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Regards
Thara
