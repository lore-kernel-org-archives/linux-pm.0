From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 4/7] cpuidle: calxeda: add support to use PSCI calls
Date: Mon, 29 Jul 2013 09:39:36 -0500
Message-ID: <51F67EA8.8010603@gmail.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com> <1375048598-15637-5-git-send-email-robherring2@gmail.com> <51F678DB.3030308@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:61935 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765Ab3G2Ojl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 10:39:41 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so4652477obc.29
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2013 07:39:40 -0700 (PDT)
In-Reply-To: <51F678DB.3030308@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 07/29/2013 09:14 AM, Daniel Lezcano wrote:
> On 07/28/2013 11:56 PM, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This updates the Calxeda cpuidle driver to use PSCI calls to powergate
>> cores. This is needed to enable cpuidle for the ECX-2000.
>>
>> This could possibly become a generic PSCI driver, but there are no other
>> PSCI users in the kernel other than mach-virt.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks.

> 
> Rob,
> 
> Shall I take the patch in my tree ?

No, there are interdependencies with the rest of the series, so I plan
to send to arm-soc.

Rob

