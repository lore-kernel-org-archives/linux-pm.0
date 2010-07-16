From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] cpuidle: extend cpuidle and menu governor to
 handle dynamic states
Date: Fri, 16 Jul 2010 10:28:08 -0700
Message-ID: <4C4096A8.8060306__34898.2647331015$1279301558$gmane$org@linux.intel.com>
References: <1279225825-31069-1-git-send-email-aili@codeaurora.org>
	<4C3FDAF1.7030107@linux.intel.com>
	<000001cb250b$e2813e60$a783bb20$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <000001cb250b$e2813e60$a783bb20$@org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ai Li <aili@codeaurora.org>
Cc: len.brown@intel.com, dwalker@codeaurora.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, akpm@linux-foundation.org, linux-pm@lists.linux-foundation.org, shemminger@vyatta.com
List-Id: linux-pm@vger.kernel.org

On 7/16/2010 10:25 AM, Ai Li wrote:
>>> +	if (dev->prepare)
>>> +		dev->prepare(dev, data->predicted_us);
>>>
>>>        
>> I don't like the idea of passing predicted_us here.
>> the states and their updates should be independent of how long we
>> think we'll be idle;
>>      
> The power_usage value, total or average, would depend on how long the
> predicted idle period is.  On our SoCs, a cpuidle state has three
> stages: entry stage, low power stage, and exit stage.  Entry and exit
> stages consume more power than the low power stage but have fixed
> durations, irrespective how long the idle period is.  As the
> predicted idle period changes, the entry and exit duration stay the
> same but the low power duration changes, resulting in different total
> or average power for the idle period.
>    

the power value in the structure should represent ONLY the power level 
during the low power stage.
And this should be independent of total duration.

all other power is taken into account in terms of break even point/etc...


> One of the concerns I have is backwards compatibility.  As far as I
> know, none of the current cpuidle drivers use the power_usage field.
> If we always do compare_power, those drivers would break until
> someone with technical device knowledge update the drivers to specify
> power...  I could derive fake power_usage numbers by default, using
> the cstate index position.  That seems kind of hacky but it would
> remove the need for the compare_power flag and retain the current
> behavior when cpuidle drivers do not provide their own power numbers.
>    

I'm fine with this approach actually; if someone does not fill it in, we 
fake data that makes it
valid... better than getting complex code.
