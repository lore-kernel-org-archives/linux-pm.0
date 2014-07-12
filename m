From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: sa1110: set memory type for h3600
Date: Sat, 12 Jul 2014 20:16:19 +0530
Message-ID: <CAKohpomTodNYO+FBAYvBGK3TPeteb4Ko0cdM94v066P4cmk7ow@mail.gmail.com>
References: <1405158213-14679-1-git-send-email-linus.walleij@linaro.org>
	<CAKohpon090a+cv6ZzTz7ziZkFxw__xJ4F7PGYKWMMJEE=OHizQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:42672 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbaGLOqT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Jul 2014 10:46:19 -0400
Received: by mail-oa0-f50.google.com with SMTP id g18so2489863oah.37
        for <linux-pm@vger.kernel.org>; Sat, 12 Jul 2014 07:46:19 -0700 (PDT)
In-Reply-To: <CAKohpon090a+cv6ZzTz7ziZkFxw__xJ4F7PGYKWMMJEE=OHizQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Fixing Rafael's id

On 12 July 2014 20:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 12 July 2014 15:13, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The Compaq iPAQ h3600 also has the K4S281632b-1H memory type.
>> Verified by prying apart a broken board.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/cpufreq/sa1110-cpufreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
>> index 546376719d8f..b5befc211172 100644
>> --- a/drivers/cpufreq/sa1110-cpufreq.c
>> +++ b/drivers/cpufreq/sa1110-cpufreq.c
>> @@ -349,7 +349,7 @@ static int __init sa1110_clk_init(void)
>>                         name = "K4S641632D";
>>                 if (machine_is_h3100())
>>                         name = "KM416S4030CT";
>> -               if (machine_is_jornada720())
>> +               if (machine_is_jornada720() || machine_is_h3600())
>>                         name = "K4S281632B-1H";
>>                 if (machine_is_nanoengine())
>>                         name = "MT48LC8M16A2TG-75";
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
