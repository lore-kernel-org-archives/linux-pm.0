From: =?UTF-8?Q?Oskari_Lemmel=c3=a4?= <oskari@lemmela.net>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Date: Sat, 8 Dec 2018 20:10:19 +0200
Message-ID: <25d04cec-e52e-f36a-4a96-f04810d662f8@lemmela.net>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net> <20181207164011.GI26661@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181207164011.GI26661@dell>
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
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Lee,

On 12/7/18 6:40 PM, Lee Jones wrote:
> On Tue, 20 Nov 2018, Oskari Lemmela wrote:
>
>> Parts of the AXP803 are compatible with their counterparts on the AXP813.
>> These include the GPIO, ADC, AC and battery power supplies.
>>
>> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
>> ---
>>   drivers/mfd/axp20x.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index dfc3cff1d08b..e415b967d38c 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -728,11 +728,26 @@ static const struct mfd_cell axp288_cells[] = {
>>   
>>   static const struct mfd_cell axp803_cells[] = {
>>   	{
>> +		.name		= "axp20x-gpio",
>> +		.of_compatible	= "x-powers,axp813-gpio",
>> +	}, {
>>   		.name			= "axp221-pek",
>>   		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>>   		.resources		= axp803_pek_resources,
>>   	},
>>   	{	.name			= "axp20x-regulator" },
>> +	{
>> +		.name		= "axp813-adc",
>> +		.of_compatible	= "x-powers,axp813-adc",
>> +	}, {
>> +		.name		= "axp20x-battery-power-supply",
>> +		.of_compatible	= "x-powers,axp813-battery-power-supply",
>> +	}, {
>> +		.name		= "axp20x-ac-power-supply",
>> +		.of_compatible	= "x-powers,axp813-ac-power-supply",
>> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>> +		.resources	= axp20x_ac_power_supply_resources,
>> +	},
>>   };
> My OCD-dar is going crazy.
>
> Why haven't you used the same alignment as is already there?
>
> If it starts to run over 80-chars then bring the others back.
>
> Also why is there a single liner shoved in the middle of the
> multi-line entries?  Please move the singles to the top or the
> bottom.
>
I sent patch set v8 which contains ChenYu's re-align patch and
this patch rebased top of it.

Re-align patch will make number of whitespaces consistent in axp20x.c

Thanks,
Oskari
