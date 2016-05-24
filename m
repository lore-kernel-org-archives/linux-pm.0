From: "Peter Feuerer" <peter@piie.net>
Subject: Re: [PATCH v2 4/5] thermal: bang-bang governor: act on lower trip
 boundary
Date: Tue, 24 May 2016 17:34:58 +0000
Message-ID: <a942e788aa285dcf88db38c6d03a36ce@mail.piie.net>
References: <20160524130610.GC8979@e104805>
 <1462268013-14992-1-git-send-email-wxt@rock-chips.com>
 <1462268013-14992-5-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160524130610.GC8979@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

24. Mai 2016 15:06 Uhr, "Javi Merino" <javi.merino@arm.com> schrieb:
> Ccing Peter Feuerer, author of the bang bang governor.
> 
> On Tue, May 03, 2016 at 05:33:32PM +0800, Caesar Wang wrote:
> 
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>> 
>> With interrupt driven thermal zones we pass the lower and upper
>> temperature on which shall be acted, so in the governor we have to act on
>> the exact lower temperature to be consistent. Otherwise an interrupt maybe
>> generated on the exact lower temperature, but the bang bang governor does
>> not react since The polling driven zones have to be one step cooler before
>> the governor reacts.
>> 
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: linux-pm@vger.kernel.org

Acked-by: Peter Feuerer <peter@piie.net>


>> 
>> ---
>> 
>> Changes in v2:
>> - Update the commit for patch[v2 4/5].
>> 
>> drivers/thermal/gov_bang_bang.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
>> index 70836c5..9d1dfea 100644
>> --- a/drivers/thermal/gov_bang_bang.c
>> +++ b/drivers/thermal/gov_bang_bang.c
>> @@ -59,7 +59,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>> if (instance->target == 0 && tz->temperature >= trip_temp)
>> instance->target = 1;
>> else if (instance->target == 1 &&
>> - tz->temperature < trip_temp - trip_hyst)
>> + tz->temperature <= trip_temp - trip_hyst)
>> instance->target = 0;
>> 
>> dev_dbg(&instance->cdev->device, "target=%d\n",
>> --
>> 1.9.1
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
