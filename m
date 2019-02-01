From: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
Date: Fri, 1 Feb 2019 09:42:41 +0800
Message-ID: <fc49e8b2-cc32-3074-9aa7-04bbc561dfe6@nvidia.com>
References: <20190131022749.19046-1-josephl@nvidia.com>
 <20190131103823.GA19907@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190131103823.GA19907@e107155-lin>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-tegra@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 1/31/19 6:38 PM, Sudeep Holla wrote:
> On Thu, Jan 31, 2019 at 10:27:49AM +0800, Joseph Lo wrote:
>> Currently, the DT of the idle states will be parsed first whether it's
>> compatible or not. This could cause a warning message that comes from if
>> the CPU doesn't support identical idle states. E.g. Tegra186 can run
>> with 2 Cortex-A57 and 2 Denver cores with different idle states on
>> different types of these cores.
>>
>> We fix it to check the compatible string before the parsing procedures.
>> So it can make sure it only goes through the idle states that the CPU
>> supported.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   drivers/cpuidle/dt_idle_states.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
>> index 53342b7f1010..4a528908abb3 100644
>> --- a/drivers/cpuidle/dt_idle_states.c
>> +++ b/drivers/cpuidle/dt_idle_states.c
>> @@ -180,6 +180,11 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>>   		if (!state_node)
>>   			break;
>>
>> +		if (!of_device_is_compatible(state_node, matches->compatible)) {
>> +			err = -EINVAL;
>> +			break;
>> +		}
>> +
> 
> Does it make sense to use of_match_node to get the matching device id and
> just pass that to init_state_node instead of the complete array to find the
> match.

Yes, that would be even better.

Thanks,
Joseph
