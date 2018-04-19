From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if
 supported
Date: Thu, 19 Apr 2018 09:21:31 -0700
Message-ID: <0a0e6a96-fe06-38fa-1551-272021116367@gmail.com>
References: <20180418155643.36464-1-code@mmayer.net>
 <20180418155643.36464-3-code@mmayer.net>
 <0f011724-85fe-d411-b99d-dfd33e206052@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f011724-85fe-d411-b99d-dfd33e206052@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Markus Mayer <code@mmayer.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jim Quinlan <jim2101024@gmail.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Markus Mayer <mmayer@broadcom.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



On 04/19/2018 03:35 AM, Sudeep Holla wrote:
> 
> 
> On 18/04/18 16:56, Markus Mayer wrote:
>> From: Jim Quinlan <jim2101024@gmail.com>
>>
>> If the SCMI cpufreq driver is supported, we bail, so that the new
>> approach can be used.
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> index b07559b9ed99..b4861a730162 100644
>> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> @@ -164,6 +164,8 @@
>>  #define BRCM_AVS_CPU_INTR	"brcm,avs-cpu-l2-intr"
>>  #define BRCM_AVS_HOST_INTR	"sw_intr"
>>  
>> +#define ARM_SCMI_COMPAT		"arm,scmi"
>> +
>>  struct pmap {
>>  	unsigned int mode;
>>  	unsigned int p1;
>> @@ -511,6 +513,20 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
>>  	struct device *dev;
>>  	int host_irq, ret;
>>  
> 
> Will this platform have both SCMI and BRCM_AVS_CPU_DATA nodes enabled ?
> If so, is it not better to just keep only the preferred node enabled
> instead ?

The kernel image has both drivers enabled, the Device Tree blob we pass
contains both nodes, and should flip the status properties based on what
is available. We had some internal discussion about that specific
change, and we ended up having the patch being submitted to seek
external advice, I guess we have an answer now this is not desired.
-- 
Florian
