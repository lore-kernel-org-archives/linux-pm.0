From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Date: Fri, 21 Mar 2014 17:15:03 +0530
Message-ID: <532C263F.4090504@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com> <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com> <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:44460 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075AbaCULpY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 07:45:24 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 17:15:21 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 07884394004E
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 17:15:19 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2LBjMN666781424
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 17:15:22 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2LBjGOm019705
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 17:15:17 +0530
In-Reply-To: <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>

On 03/21/2014 02:11 PM, Viresh Kumar wrote:
> On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
>> From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> 
> Hi Vaidy,
> 
>> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>> index 4b029c0..4ba1632 100644
>> --- a/drivers/cpufreq/Kconfig
>> +++ b/drivers/cpufreq/Kconfig
>> @@ -48,6 +48,7 @@ config CPU_FREQ_STAT_DETAILS
>>  choice
[...]
>> +static struct cpufreq_driver powernv_cpufreq_driver = {
>> +       .verify         = powernv_cpufreq_verify,
>> +       .target         = powernv_cpufreq_target,
> 
> I think you have Srivatsa there who has seen lots of cpufreq code and
> could have helped you a lot :)
>

:-)

I have followed the locking and synchronization aspects of cpufreq
closely, but unfortunately, I haven't been able to keep up with some of
the other details that well :-( Besides, its hard to keep up with the
rate of your changes, you are way too fast! ;-)

Regards,
Srivatsa S. Bhat

