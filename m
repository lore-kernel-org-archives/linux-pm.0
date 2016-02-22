From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 1/2] irq: Track the interrupt timings
Date: Mon, 22 Feb 2016 18:24:12 +0100
Message-ID: <56CB443C.40103@linaro.org>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
 <56CB1FB3.2000007@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38269 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbcBVRYP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 12:24:15 -0500
Received: by mail-wm0-f53.google.com with SMTP id a4so173198726wme.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 09:24:15 -0800 (PST)
In-Reply-To: <56CB1FB3.2000007@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, tglx@linutronix.de
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On 02/22/2016 03:48 PM, Shreyas B Prabhu wrote:

[ ... ]

>> +
>> +	free_timings(desc);
>> +	free_masks(desc);
>> +	free_percpu(desc->kstat_irqs);
>> +	kfree(desc);
>>   }
>
> I think this is a rebase error. If I am not wrong, instead of this yo=
u
> need to add free_timings(desc) to delayed_free_desc.

Ah, yes. Good catch.

Thanks for spotting it.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

