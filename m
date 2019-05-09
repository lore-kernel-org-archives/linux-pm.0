From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v3 1/4] cpufreq: Add imx-cpufreq-dt driver
Date: Thu, 9 May 2019 09:03:57 +0000
Message-ID: <AM0PR04MB64349B11B2A914F705B6D302EE330@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1557236799.git.leonard.crestez@nxp.com>
 <607242a278a4532d0b4285e0fb56abfd5767fdd1.1557236799.git.leonard.crestez@nxp.com>
 <20190508035402.7pbikzpkzxxesmlw@vireshk-i7>
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jacky Bai <ping.bai@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 5/8/2019 6:54 AM, Viresh Kumar wrote:
> On 07-05-19, 13:52, Leonard Crestez wrote:

>> +config ARM_IMX_CPUFREQ_DT
>> +	tristate "Freescale i.MX8M cpufreq support"
>> +	depends on ARCH_MXC && CPUFREQ_DT
>> +	default m if ARCH_MXC && CPUFREQ_DT
> 
> As I said in the previous version, the if block above is redundant and
> not required.

Sorry, I misread and thought you were referring to () rather than what's 
inside.

Is "default m" otherwise OK? It's a reasonable implication of ARCH_MXC

--
Regards,
Leonard
