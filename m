From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/2] soc: mediatek: add a fixed wait for SRAM stable
Date: Mon, 30 Apr 2018 11:10:28 +0200
Message-ID: <b45efd5d-755c-6d5c-b226-763801e811ea@gmail.com>
References: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
 <0ef8e87ba7156e626d1a1a48388f222ce917099b.1524472331.git.sean.wang@mediatek.com>
 <51840588-96e4-2520-f3d7-a61e74da6814@gmail.com>
 <1524476340.12322.14.camel@mtkswgap22>
 <0ec15c8a-ca90-26c3-1ea6-00bf0d48b62a@gmail.com>
 <1525072080.12322.212.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1525072080.12322.212.camel@mtkswgap22>
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
To: Sean Wang <sean.wang@mediatek.com>
Cc: ulf.hansson@linaro.org, Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org, khilman@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 04/30/2018 09:08 AM, Sean Wang wrote:
> On Fri, 2018-04-27 at 11:46 +0200, Matthias Brugger wrote:
>> Hi Sean,
>>
>> On 04/23/2018 11:39 AM, Sean Wang wrote:
>>> On Mon, 2018-04-23 at 11:31 +0200, Matthias Brugger wrote:
>>>>
>>>> On 04/23/2018 10:36 AM, sean.wang@mediatek.com wrote:
>>>>> From: Sean Wang <sean.wang@mediatek.com>
>>>>>
>>>>> MT7622_POWER_DOMAIN_WB doesn't send an ACK when its managed SRAM becomes
>>>>> stable, which is not like the behavior the other power domains should
>>>>> have. Therefore, it's necessary for such a power domain to have a fixed
>>>>> and well-predefined duration to wait until its managed SRAM can be allowed
>>>>> to access by all functions running on the top.
>>>>>
>>>>> v1 -> v2:
>>>>>  - use MTK_SCPD_FWAIT_SRAM flag as an indication requiring force waiting.
>>>>>
>>>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>>>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>>>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
>>>>> ---
>>>>>  drivers/soc/mediatek/mtk-scpsys.c | 24 ++++++++++++++++++------
>>>>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
>>>>> index b1b45e4..d4f1a63 100644
>>>>> --- a/drivers/soc/mediatek/mtk-scpsys.c
>>>>> +++ b/drivers/soc/mediatek/mtk-scpsys.c
>>>>> @@ -32,6 +32,7 @@
>>>>>  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
>>>>>  
>>>>>  #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
>>>>> +#define MTK_SCPD_FWAIT_SRAM		BIT(1)
>>>>>  #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>>>>>  
>>>>>  #define SPM_VDE_PWR_CON			0x0210
>>>>> @@ -237,11 +238,22 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>>>>>  	val &= ~scpd->data->sram_pdn_bits;
>>>>>  	writel(val, ctl_addr);
>>>>>  
>>>>> -	/* wait until SRAM_PDN_ACK all 0 */
>>>>> -	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
>>>>> -				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>>>>> -	if (ret < 0)
>>>>> -		goto err_pwr_ack;
>>>>> +	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
>>>>> +	if (!MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
>>
>> After having another look on the patch, could you change the order of the if:
>> So that we check for the existence of the MTK_SCPD_FWAIT_SRAM and sleep and in
>> the else branch we to the readl_poll_timeout.
>>
>> I think in the future this will make the code easier to understand as you can
>> easily oversee the '!' negation in the if.
>>
>> Regards,
>> Matthias
>>
> 
> Initial thought on the patch is that I would like to save a branch
> instruction for a most possibly executed block. Or would it be better to
> add a compiler to branch prediction information? something like that  
> 
>         /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
>         if (unlikely(MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM))) {
>                 /*
>                  * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
>                  * MT7622_POWER_DOMAIN_WB and thus just a trivial setup
> is
>                  * applied here.
>                  */
>                 usleep_range(12000, 12100);
> ...
>  

Is this a performance critical path? I thought if you turn on the power domain
for some peripherals, it does not matter if you need a few CPU cycles more or less.

Regards,
Matthias
