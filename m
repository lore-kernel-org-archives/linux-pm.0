From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: Re: [PATCH 6/6] PM / devfreq: Set the min_freq and max_freq of
 devfreq device
Date: Mon, 23 Nov 2015 17:53:33 +0900
Message-ID: <CAGTfZH2N-yspxAKCR_sOPz0nSNixADzSFwEe0rhkwHOPFKYyPQ@mail.gmail.com>
References: <1427563269.125721448263260488.JavaMail.weblogic@epmlwas06a>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33225 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbKWIxe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 03:53:34 -0500
In-Reply-To: <1427563269.125721448263260488.JavaMail.weblogic@epmlwas06a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Nov 23, 2015 at 4:21 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> []
>> >
>> > The value 0 is used for min/max_freq to declare
>> > that min/max_freq is deactivated. Therefore, it is not
>> > required to do so; they are not intended to show the hardware
>> > configuration as well.
>>
>> This case consider the devfreq device using OPP because devfreq_set_freq_table()
>> get the number of OPP entry in OPP list before setting the min_freq/max_freq.
>> If the devfreq device don't use the OPP entry, devfreq_set_freq_table()
>> will return without any operation.
>>
>> IMHO, when devfreq device uses the OPP table including the frequency,
>> min_freq/max_freq should show the correct value as CPUFREQ framework.
>>
>
> The side effect of this patch shows up when opp_disable() and opp_enable()
> are used.

Ah. You're right.
I was not considering the the case of using opp_disable() and opp_enable().
I'll consider it again including the usage case of opp_diable/opp_enable.

Regards,
Chanwoo Choi
