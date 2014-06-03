From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: governor: Be friendly towards latency-sensitive
 bursty workloads
Date: Tue, 03 Jun 2014 15:34:45 +0530
Message-ID: <538D9DBD.2030605@linux.vnet.ibm.com>
References: <20140526205337.1100.55275.stgit@srivatsabhat.in.ibm.com> <CAKohpokdnHag=79cXuwgNjX-k+JJU9GE3KUBhixcj3PZ6y78GQ@mail.gmail.com> <538D9631.9090500@linux.vnet.ibm.com> <CAKohpomynD9m-Cq4zsVSp3Xbw5Tx2cSe_Fcp5y0U8uAKSpQ1Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:52316 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaFCKGT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jun 2014 06:06:19 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 3 Jun 2014 15:36:17 +0530
In-Reply-To: <CAKohpomynD9m-Cq4zsVSp3Xbw5Tx2cSe_Fcp5y0U8uAKSpQ1Tw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 06/03/2014 03:09 PM, Viresh Kumar wrote:
> On 3 June 2014 15:02, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> index e1c6433..3e8588f 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -36,14 +36,29 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
>>         struct od_dbs_tuners *od_tuners = dbs_data->tuners;
>>         struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>>         struct cpufreq_policy *policy;
>> +       unsigned int sampling_rate;
>>         unsigned int max_load = 0;
>>         unsigned int ignore_nice;
>>         unsigned int j;
>>
>> -       if (dbs_data->cdata->governor == GOV_ONDEMAND)
>> +       if (dbs_data->cdata->governor == GOV_ONDEMAND) {
>> +               struct od_cpu_dbs_info_s *od_dbs_info;
>> +
>> +               /*
>> +                * Sometimes, the ondemand governor uses an additional
>> +                * multiplier to give long delays. So apply this multiplier to
>> +                * the 'sampling_rate', so as to keep the wake-up-from-idle
>> +                * detection logic a bit conservative.
>> +                */
>> +               sampling_rate = od_tuners->sampling_rate;
>> +               od_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
> 
> Probably do both above right after definition of od_dbs_info or merge
> above with it. and just keep below after the comment ?
> 
>> +               sampling_rate *= od_dbs_info->rate_mult;
> 

Well, the method I used keeps the organization such that the code following
the comment does precisely what the comment says (i.e, get the sampling_rate,
fetch the multiplier, and then multiply). So I feel it makes it easier to
understand.

Regards,
Srivatsa S. Bhat

