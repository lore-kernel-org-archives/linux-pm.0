From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 1/3] cpufreq: Add imx-cpufreq-dt driver
Date: Fri, 3 May 2019 09:44:48 +0000
Message-ID: <AM0PR04MB64345196835732B019F1D885EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <df3a41d8bf57b8dd8f8c17599eeca98d6e43962c.1556836868.git.leonard.crestez@nxp.com>
 <20190503065227.afqgmylbjwhg2mc3@vireshk-i7>
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
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jacky Bai <ping.bai@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 03.05.2019 09:52, Viresh Kumar wrote:
> On 02-05-19, 22:44, Leonard Crestez wrote:
>> Right now in upstream imx8m cpufreq support just lists a common subset
>> of OPPs because the higher ones should only be attempted after checking
>> speed grading in fuses.
>>
>> Add a small driver which checks speed grading from nvmem cells before
>> registering cpufreq-dt.
>>
>> This allows unlocking all frequencies for imx8mm and imx8mq.
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> @@ -90,10 +90,20 @@ config ARM_IMX6Q_CPUFREQ
>>   	help
>>   	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
>>   
>>   	  If in doubt, say N.
>>   
>> +config ARM_IMX_CPUFREQ_DT
>> +	tristate "Freescale i.MX8M cpufreq support"
>> +	depends on ARCH_MXC && CPUFREQ_DT
>> +	default m if (ARCH_MXC && CPUFREQ_DT)
>> +	help
>> +	  This adds cpufreq driver support for newer Freescale i.MX series
> 
> "newer" is a relative thing, it won't be newer an year or two later. Just drop
> it.

I meant "newer than i.MX6". Various attempts at adding explicit cpufreq 
drivers for newer SOCs were rejected in favor of cpufreq-dt.

I'll change to mention i.MX8M explicitly and update if 7 is added.

>> +static struct platform_driver imx_cpufreq_dt_driver = {
>> +	.probe = imx_cpufreq_dt_probe,
>> +	.remove = imx_cpufreq_dt_remove,
>> +	.driver = {
>> +		.name = "imx-cpufreq-dt",
>> +	},
>> +};
>> +module_platform_driver(imx_cpufreq_dt_driver);
> 
> Why add another virtual device-driver pair here? The only reason why we have
> been adding it was to get deferred probe to work which doesn't look like the
> case for this driver. Why not do everything from the init() routine ?

The imx-cpufreq-dt platform_driver reads from fuses (nvmem/imx-ocotp) 
which can be theoretically be built as a module and also has clock 
requirements. No sure we should rely that the call to read from nvmem 
never returns EPROBE_DEFER.

I'm not sure which "init()" you mean, the registration code is inside 
soc driver and at that point the fuse driver might not be available.

--
Regards,
Leonard
