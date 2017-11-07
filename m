From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v2] cpupowerutils: bench - Fix cpu online check
Date: Tue, 7 Nov 2017 11:36:01 -0700
Message-ID: <bf523e87-da2b-9ace-3e73-86d41b6080ea@osg.samsung.com>
References: <20171107094755.49440-1-huntbag@linux.vnet.ibm.com>
 <3a6fd547-b367-6e35-7fb5-5ab8d1139b5b@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a6fd547-b367-6e35-7fb5-5ab8d1139b5b@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek <huntbag@linux.vnet.ibm.com>, Shuah Khan <shuah@kernel.org>, Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

On 11/07/2017 02:50 AM, Abhishek wrote:
> Hi,
> 
> Can you please have a look at this also?
> 
> Thanks and Regards,
> Abhishek Goel
> System Engineer
> IBM India Pvt. Ltd.
> 

Same comment on top posting.

> On 11/07/2017 03:17 PM, Abhishek Goel wrote:
>> cpupower_is_cpu_online was incorrectly checking for 0. This patch fixes
>> this by checking for 1 when the cpu is online.
>>
>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>> ---
>> v2: Commit message rephrased.
>> ---
>>   tools/power/cpupower/bench/system.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
>> index c25a74a..2bb3eef 100644
>> --- a/tools/power/cpupower/bench/system.c
>> +++ b/tools/power/cpupower/bench/system.c
>> @@ -61,7 +61,7 @@ int set_cpufreq_governor(char *governor, unsigned int cpu)
>>
>>       dprintf("set %s as cpufreq governor\n", governor);
>>
>> -    if (cpupower_is_cpu_online(cpu) != 0) {
>> +    if (cpupower_is_cpu_online(cpu) != 1) {
>>           perror("cpufreq_cpu_exists");
>>           fprintf(stderr, "error: cpu %u does not exist\n", cpu);
>>           return -1;
> 

Ths patch looks good to me. I still need it in my Inbox. Please send it
to me directly.

thanks,
-- Shuah
