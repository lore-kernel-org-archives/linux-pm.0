From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH v4 3/3] PM / clock_ops: add and enable clocks always
 if !CONFIG_PM_RUNTIME
Date: Fri, 7 Nov 2014 14:43:41 +0200
Message-ID: <545CBE7D.4050704@ti.com>
References: <1415281862-23764-1-git-send-email-grygorii.strashko@ti.com>
 <1415281862-23764-4-git-send-email-grygorii.strashko@ti.com>
 <20141106180956.GE34214@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141106180956.GE34214@dtor-ws>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, khilman@linaro.org, Caesar Wang <caesar.wang@rock-chips.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Philipp Zabel <p.zabel@pengutronix.de>, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 11/06/2014 08:09 PM, Dmitry Torokhov wrote:
> On Thu, Nov 06, 2014 at 03:51:02PM +0200, Grygorii Strashko wrote:
>> Device's clocks need to be enabled always at probing time
>> if !CONFIG_PM_RUNTIME - in that way, device will become accesible
>> and, later, its clocks can be disabled/enabled during system
>> suspend/resume by using pm_clk_suspend/pm_clk_resume APIs.
>>
>> But now, the clocks management code doesn't enable clocks when
>> clocks are being registered per-device by using pm_clk_add/_clk().
>> So, update pm_clk_acquire(), which is called from pm_clk_add/_clk(),
>> to enable clock always if !CONFIG_PM_RUNTIME.
>>
>> Also, Platform PM domains drivers will not have to add code like below
>> each time they need to handle the case when !CONFIG_PM_RUNTIME [1 - 3]:
>>
>>         if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {
>>                 ret = pm_clk_resume(dev);
>>                 if (ret) {
>>                         dev_err(dev, "pm_clk_resume failed %d\n", ret);
>>                         goto clk_err;
>>                 };
>>         }
>>
>> [1] https://lkml.org/lkml/2014/10/3/306
>> [2] https://lkml.org/lkml/2014/10/16/305
>> [3] https://lkml.org/lkml/2014/10/20/249
>>
>> CC: Santosh Shilimkar <ssantosh@kernel.org>
>> CC: Kevin Hilman <khilman@linaro.org>
>> CC: Ulf Hansson <ulf.hansson@linaro.org>
>> CC: Geert Uytterhoeven <geert@linux-m68k.org>
>> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> CC: Philipp Zabel <p.zabel@pengutronix.de>
>> CC: Caesar Wang <caesar.wang@rock-chips.com>
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> Hi,
>>
>> I marked it as RFC, because:
>>    Generic clock manipulation PM callbacks can be used for any device
>>    for which list of clocks need to be maintained - and it doesn't mean
>>    that this framework need to be always connected to GPD/Runtime PM or
>>    used during suspend resume. Also, for DT-use case - it doesn't perform
>>    any actions (except clk_prepare) on clocks by itself and only
>>    by request from framework's consumer.
>>
>>   For example, it can be reused by Power domain/controller drivers like:
>>   - Rockchip RK3288 PM Domain (https://lkml.org/lkml/2014/11/6/30)
>>   - IMX.6 PU power domain (http://www.spinics.net/lists/arm-kernel/msg360709.html)
>>
>>   to maintain list of clocks for GPD itself and these clocks should not
>>   be enabled by default, because they are used to power on/off Power domain
>>   in a specific way:
>>       - enable all clocks assigned to PD
>>       - power on/off PD
>>       - disable all clocks assigned to PD.
>>   After this patch it will be impossible to reuse Generic clock manipulation PM
>>   callbacks in cases described above.
>
> I'd rather keep it separate and concentrate on making pm_clk* code
> working with the power management core. Individual drivers can easily
> keep list of their clocks for whatever additional purpose they need
> without involving pm_clk* API.
>

In general, I'm ok with this patch for Keystone 2 proposes,
just added some notes about introduced limitations. And  all
current users of pm_clk* APIs will not regress with this patch, because
they will go through different code path if !CONFIG_PM_RUNTIME.

Regards,
-grygorii
