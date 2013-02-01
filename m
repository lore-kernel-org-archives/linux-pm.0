From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: governors: Get rid of dbs_data->enable field
Date: Fri, 1 Feb 2013 12:14:02 +0530
Message-ID: <CAKohpomDZ-W7vps1CEh42K5f6fPHjB6PaeN4_MusSyHXnue52g@mail.gmail.com>
References: <09a94ff044ff6a6f7a5d953c3b1f3102c1dc50cf.1359653181.git.viresh.kumar@linaro.org>
	<20130131184449.GA20164@balto.lan>
	<CAKohponyY1goyV_5U3f3ZFVuMqp2XsrAevNCvZ9Juoyg53LjnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:55557 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab3BAGoE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 01:44:04 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so3838212oag.8
        for <linux-pm@vger.kernel.org>; Thu, 31 Jan 2013 22:44:02 -0800 (PST)
In-Reply-To: <CAKohponyY1goyV_5U3f3ZFVuMqp2XsrAevNCvZ9Juoyg53LjnA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com

On 1 February 2013 09:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 1 February 2013 00:14, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:

>> As a sidenote, I noticed just now that since:
>>
>> bc92bea cpufreq: Notify governors when cpus are hot-[un]plugged
>>
>> governor's sampling_rate gets reset to default every time you hotplug a
>> CPU (the one you read/write on
>> /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate).
>>
>> If you need further tests, I'll be back on Monday.
>
> I will have a look.

Fixed with:

https://lkml.org/lkml/2013/2/1/6
