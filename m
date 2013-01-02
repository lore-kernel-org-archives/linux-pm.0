From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] Fix problem with cpufreq_ondemand or cpufreq_conservative
Date: Wed, 2 Jan 2013 09:42:37 +0530
Message-ID: <CAKohponf3dCYvEaZAUU4_2zRP+z2nPfskiQmykW4T_TxPG3J+A@mail.gmail.com>
References: <50DE378D.4090008@lwfinger.net>
	<CAOh2x==ER3j7P1U+VQEtv00LWWa8JJHu=22--+gTUPFdhiC_cQ@mail.gmail.com>
	<50E3B32A.8070807@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:60154 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab3ABEMi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jan 2013 23:12:38 -0500
Received: by mail-ob0-f171.google.com with SMTP id dn14so12438592obc.16
        for <linux-pm@vger.kernel.org>; Tue, 01 Jan 2013 20:12:37 -0800 (PST)
In-Reply-To: <50E3B32A.8070807@lwfinger.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2 January 2013 09:40, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>> Index: wireless-testing-new/drivers/cpufreq/cpufreq_governor.c
>>
>>
>> How are you creating these patches? wireless-testing-new (linux directory
>> names)
>> aren't supposed to be present here.

You Missed this one?

> I was not adding myself - my name is not Alexander Clouter. When we were
> creating a new module, I got the author from the module that
> cpufreq_governor was originally a part. Perhaps I got the name wrong.

Err.. I read it wrong... sorry :)
