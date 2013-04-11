From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [v2,05/14] thermal: mvebu: Convert to devm_ioremap_resource()
Date: Thu, 11 Apr 2013 14:55:06 -0400
Message-ID: <5167070A.1070809@ti.com>
References: <1363991114-4225-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <5166E66B.6080406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5166E66B.6080406@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Ezequiel,

On 11-04-2013 12:35, Eduardo Valentin wrote:
> Rui,
>
> On 22-03-2013 18:25, Ezequiel Garcia wrote:
>> Convert devm_request_and_ioremap() to the newly introduced
>> devm_ioremap_resource() which provides more consistent error handling.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>
>
> This patch looks correct to me too.
>
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
>


I know you have discarded the idea of merging the driver into a single 
driver, but can you please resend this patch on top of 
drivers/thermal/kirkwood_thermal.c file. This change still applies.

>> ---
>> drivers/thermal/mvebu_thermal.c |    8 +++-----
>>   1 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/mvebu_thermal.c
>> b/drivers/thermal/mvebu_thermal.c
>> index 1f502ed..2aeaf75 100644
>> --- a/drivers/thermal/mvebu_thermal.c
>> +++ b/drivers/thermal/mvebu_thermal.c
>> @@ -86,11 +86,9 @@ static int mvebu_thermal_probe(struct
>> platform_device *pdev)
>>       if (!priv)
>>           return -ENOMEM;
>>
>> -    priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
>> -    if (!priv->sensor) {
>> -        dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
>> -        return -EADDRNOTAVAIL;
>> -    }
>> +    priv->sensor = devm_ioremap_resource(&pdev->dev, res);
>> +    if (IS_ERR(priv->sensor))
>> +        return PTR_ERR(priv->sensor);
>>
>>       thermal = thermal_zone_device_register("mvebu_thermal", 0, 0,
>>                              priv, &ops, NULL, 0, 0);
>>
>
>
>
