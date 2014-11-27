From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/7] cpufreq: Introduce ->usable() callback for cpufreq drivers
Date: Thu, 27 Nov 2014 05:58:00 +0530
Message-ID: <CAKohpokbT_8k=Gde34Jj-mQQta0jaySHSQghvRicHa7201eQ7w@mail.gmail.com>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
	<95b84bb8af3d4d9667a79db520cfa37d9444d75b.1416980448.git.viresh.kumar@linaro.org>
	<5490890.8GRTWn2e7b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33185 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaK0A2B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:28:01 -0500
Received: by mail-oi0-f48.google.com with SMTP id u20so2752043oif.7
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 16:28:00 -0800 (PST)
In-Reply-To: <5490890.8GRTWn2e7b@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>

On 27 November 2014 at 05:55, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> +     void            (*usable)(struct cpufreq_policy *policy);
>
> What about
>
>         void            (*ready)(struct cpufreq_policy *policy);

That was the second option doing rounds in my thoughts :)
As two people like it now (You and Me), lets move to that :)

--
viresh
