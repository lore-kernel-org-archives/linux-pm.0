From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Tue, 16 Dec 2014 09:07:28 +0530
Message-ID: <CAKohpokfG3wH=p=mzz4Owa7yqrirM_Djfc-xZFaAOKZwq1GfZg@mail.gmail.com>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
	<7573578.UE8ufgjWuX@vostro.rjw.lan>
	<CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
	<002f01d0186b$2700b730$75022590$%brar@samsung.com>
	<20141215134636.GI11285@n2100.arm.linux.org.uk>
	<003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:43908 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaLPDh3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 22:37:29 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so21261378obc.10
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 19:37:29 -0800 (PST)
In-Reply-To: <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yadwinder Singh Brar <yadi.brar@samsung.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

On 15 December 2014 at 20:24, Yadwinder Singh Brar
<yadi.brar@samsung.com> wrote:
>> Unfortunately, you do need some kind of synchronisation here.  If it's
>> not important when cpufreq_register_notifier() gets called, maybe this
>> can work:
>>
>>       bool register;
>>
>>       mutex_lock(&cooling_cpufreq_lock);
>>       register = cpufreq_dev_count++ == 0;
>>       list_add(&cpufreq_dev->node, &cpufreq_dev_list);
>>       mutex_unlock(&cooling_cpufreq_lock);
>>
>>       if (register)
>
> register may be 0 in scenario you stated above in second point.
> So this approach will not work.

I didn't understood what you meant here. register will be zero only
for one of the threads.
