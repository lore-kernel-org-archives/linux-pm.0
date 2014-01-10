From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 2/2] intel_idle: close avn_cstates array with correct
 marker
Date: Fri, 10 Jan 2014 09:59:30 +0800
Message-ID: <52CF5402.70106@linux.intel.com>
References: <1389252628-1033-1-git-send-email-jiang.liu@linux.intel.com> <1389252628-1033-2-git-send-email-jiang.liu@linux.intel.com> <5913087.iUSSiA9xVP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52608 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbaAJB7d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jan 2014 20:59:33 -0500
In-Reply-To: <5913087.iUSSiA9xVP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org



On 2014/1/9 21:31, Rafael J. Wysocki wrote:
> On Thursday, January 09, 2014 03:30:27 PM Jiang Liu wrote:
>> Close avn_cstates array with correct marker to avoid overflow
>> in function intel_idle_cpu_init().
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> Cc: <stable@vger.kernel.org> # 3.13
> 
> Why did you mark it for 3.13-stable?  3.13 hasn't been released yet, so this
> can be pushed for 3.13 still.
> 
> Is the problem present in 3.13-rc?  If so, has it been introduced by any
> recent commits or was it there before?  In which case, do we need this patch
> in stable as well?
> 
> Rafael
Hi Rafael,
	This issue is introduced in 3.13-rc2, and I feel it's too late
to catch up with 3.13 window, so mark it for 3.13 speculatively.
	After more thoughts, I feel this patch should be divided into
two patches.
	One is to temporarily remove the __initdata marker. The other
is to correctly mark end of avn_cstates array. The second bug should
be introduced when merging "22e580d intel_idle: Fixed C6 state on
Avoton/Rangeley processors" with "eba682a intel_idle: shrink states tables".
	Should I split it into two?
Thanks!
Gerry

> 
> 
>> ---
>>  drivers/idle/intel_idle.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index 6f456f0..797ed29 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -329,7 +329,7 @@ static struct cpuidle_state atom_cstates[] = {
>>  	{
>>  		.enter = NULL }
>>  };
>> -static struct cpuidle_state avn_cstates[] __initdata = {
>> +static struct cpuidle_state avn_cstates[] = {
>>  	{
>>  		.name = "C1-AVN",
>>  		.desc = "MWAIT 0x00",
>> @@ -344,6 +344,8 @@ static struct cpuidle_state avn_cstates[] __initdata = {
>>  		.exit_latency = 15,
>>  		.target_residency = 45,
>>  		.enter = &intel_idle },
>> +	{
>> +		.enter = NULL }
>>  };
>>  
>>  /**
>>
> 
