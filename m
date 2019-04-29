From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v4 1/2] PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
Date: Mon, 29 Apr 2019 14:39:07 +0000
Message-ID: <AM0PR04MB6434B2BBECCA6B2644CDF044EE390@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1556313614.git.leonard.crestez@nxp.com>
 <68ccb5a90d1d2a596e7ed94ba3245171f013c781.1556313614.git.leonard.crestez@nxp.com>
 <CAPDyKFpCCapBfNbsR1Q+nyg8aenVJWxj9qmTCCCfmONZR3t1sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Arulpandiyan Vadivel <Arulpandiyan_Vadivel@mentor.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On 4/29/2019 12:11 PM, Ulf Hansson wrote:
> On Fri, 26 Apr 2019 at 23:38, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>>
>> This is for power domains which can only be powered off for suspend but
>> not as part of runtime PM.
>>
>> @@ -126,10 +126,11 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>>   #define genpd_status_on(genpd)         (genpd->status == GPD_STATE_ACTIVE)
>>   #define genpd_is_irq_safe(genpd)       (genpd->flags & GENPD_FLAG_IRQ_SAFE)
>>   #define genpd_is_always_on(genpd)      (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>>   #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>>   #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>> +#define genpd_is_no_runtime_off(genpd) (genpd->flags & GENPD_FLAG_NO_RUNTIME_OFF) >
> May I suggest to switch the name to, GENPD_FLAG_RUNTIME_ON.
> 
> Other than that, this looks good to me!

Then it's easy to confuse genpd_status_on with genpd_is_runtime_on. How 
about genpd_is_rpm_always_on?

--
Regards,
Leonard
