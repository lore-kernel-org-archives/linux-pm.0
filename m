From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: fix current freq check on policy update
Date: Mon, 17 Feb 2014 13:38:25 +0530
Message-ID: <5301C379.9020909@linux.vnet.ibm.com>
References: <20140214072623.3dd67851@mjolnir.ossman.eu> <52FE01A2.9030905@linux.vnet.ibm.com> <20140214153423.340e404e@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:50062 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaBQIN5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 03:13:57 -0500
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 17 Feb 2014 13:43:54 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 43F0A3940058
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2014 13:43:51 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s1H8DkGl52035720
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2014 13:43:47 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s1H8DnRX031532
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2014 13:43:50 +0530
In-Reply-To: <20140214153423.340e404e@mjolnir.ossman.eu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pierre Ossman <pierre-list@ossman.eu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>

On 02/14/2014 08:04 PM, Pierre Ossman wrote:
> On Fri, 14 Feb 2014 17:14:34 +0530
> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> 
>>
>> So with that, I don't see how the KHz value can turn out to be zero!
>>
> 
> Very interesting. But I can tell you that it is indeed happening. With
> my earlier patch (that checked the return value), I did have this in my
> dmesg:
> 
> [  188.044175] cpufreq: updating policy for CPU 1
> [  188.044177] cpufreq: Driver did not initialize current freq
> [  188.044177] cpufreq: setting new policy for CPU 0: 1000000 - 2800000 kHz
> 
> I can sprinkle some more pr_debug:s in there if you want to trace it
> further?
>

Hmm, that would be good. However, I did find something odd while browsing
through the powernow-k8 code.

It maintains a per-cpu data-structure called powernow_data, but it is
initialized only for the policy->cpu.

In powernowk8_cpu_init():

	per_cpu(powernow_data, pol->cpu) = data;

Everywhere in the code, this per-cpu data-structure is accessed always with
pol->cpu as the argument, *except* in powernowk8_get():

1210 static unsigned int powernowk8_get(unsigned int cpu)
1211 {
1212         struct powernow_k8_data *data = per_cpu(powernow_data, cpu);
1213         unsigned int khz = 0;
1214         int err;
1215 
1216         if (!data)
1217                 return 0;
1218 
1219         smp_call_function_single(cpu, query_values_on_cpu, &err, true);
1220         if (err)
1221                 goto out;
1222 
1223         khz = find_khz_freq_from_fid(data->currfid);
1224 

So, obviously it finds data to be uninitialized if cpu != pol->cpu, and hence
it would return 0 due to the "if (!data)" check. In other words, the init
routine initializes the per-cpu memory only for the pol->cpu, whereas the
->get() routine tries to access it for some other cpu, and fails.

So I think the following patch should fix your problem. Basically, this
initializes the per-cpu data-structures of all the CPUs to the correct memory,
and not just for the pol->cpu.


diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index e10b646..bd7bc39 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1076,7 +1076,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 {
 	struct powernow_k8_data *data;
 	struct init_on_cpu init_on_cpu;
-	int rc;
+	int rc, cpu;
 
 	smp_call_function_single(pol->cpu, check_supported_cpu, &rc, 1);
 	if (rc)
@@ -1140,7 +1140,9 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 	pr_debug("cpu_init done, current fid 0x%x, vid 0x%x\n",
 		 data->currfid, data->currvid);
 
-	per_cpu(powernow_data, pol->cpu) = data;
+	/* Point all the CPUs in this policy to the same data */
+	for_each_cpu(cpu, pol->cpus)
+		per_cpu(powernow_data, cpu) = data;
 
 	return 0;
 


Regards,
Srivatsa S. Bhat

