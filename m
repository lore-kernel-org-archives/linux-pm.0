From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] powernow-k6: support 350MHz cpu
Date: Thu, 10 Jul 2014 08:26:20 +0530
Message-ID: <CAKohponMW+QCqWqGXJWSu9ByKBj7p8oP2Ps8Gwaoh6b7NvBpVA@mail.gmail.com>
References: <alpine.LRH.2.02.1407091717460.6236@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:54386 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaGJC4V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 22:56:21 -0400
Received: by mail-oa0-f50.google.com with SMTP id g18so2072399oah.37
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2014 19:56:20 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1407091717460.6236@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 10 July 2014 02:49, Mikulas Patocka <mpatocka@redhat.com> wrote:
> There exists 350MHz K6-2E+ cpu, so add it to the usual frequency table.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>
> ---
>  drivers/cpufreq/powernow-k6.c |    1 +
>  1 file changed, 1 insertion(+)
>
> Index: linux-3.16-rc4/drivers/cpufreq/powernow-k6.c
> ===================================================================
> --- linux-3.16-rc4.orig/drivers/cpufreq/powernow-k6.c   2014-07-09 15:15:29.000000000 +0200
> +++ linux-3.16-rc4/drivers/cpufreq/powernow-k6.c        2014-07-09 15:15:44.000000000 +0200
> @@ -55,6 +55,7 @@ static const struct {
>         unsigned freq;
>         unsigned mult;
>  } usual_frequency_table[] = {
> +       { 350000, 35 }, // 100   * 3.5
>         { 400000, 40 }, // 100   * 4
>         { 450000, 45 }, // 100   * 4.5
>         { 475000, 50 }, //  95   * 5

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
