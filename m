From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [PATCH 4/4] clk: qoriq: Add clockgen support for lx2160a
Date: Tue, 26 Feb 2019 10:09:18 +0000
Message-ID: <VI1PR04MB4800DE15F522A6B4782323D5F37B0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
 <1551126463-5341-5-git-send-email-vabhav.sharma@nxp.com>
 <07441256501ad8bd45b187cf6e25338b028bc9ac.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <07441256501ad8bd45b187cf6e25338b028bc9ac.camel@buserror.net>
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
To: Scott Wood <oss@buserror.net>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, will.deacon@arm.com
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Andy Tang <andy.tang@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Scott Wood <oss@buserror.net>
> Sent: Tuesday, February 26, 2019 3:15 PM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>; sudeep.holla@arm.com;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> sboyd@kernel.org; rjw@rjwysocki.net; viresh.kumar@linaro.org; linux-
> clk@vger.kernel.org; linux-pm@vger.kernel.org; linux-kernel-
> owner@vger.kernel.org; catalin.marinas@arm.com; will.deacon@arm.com;
> gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com; Leo Li
> <leoyang.li@nxp.com>; shawnguo@kernel.org
> Cc: linux@armlinux.org.uk; adrian.hunter@intel.com;
> ulf.hansson@linaro.org; Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com>; Andy Tang <andy.tang@nxp.com>
> Subject: Re: [PATCH 4/4] clk: qoriq: Add clockgen support for lx2160a
> 
> On Tue, 2019-02-26 at 08:34 +0000, Vabhav Sharma wrote:
> > @@ -1435,6 +1446,7 @@ CLK_OF_DECLARE(qoriq_clockgen_t1023,
> "fsl,t1023-
> > clockgen", clockgen_init);  CLK_OF_DECLARE(qoriq_clockgen_t1040,
> > "fsl,t1040-clockgen", clockgen_init);
> > CLK_OF_DECLARE(qoriq_clockgen_t2080, "fsl,t2080-clockgen",
> > clockgen_init);  CLK_OF_DECLARE(qoriq_clockgen_t4240,
> > "fsl,t4240-clockgen", clockgen_init);
> > +CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen",
> > clockgen_init);
> 
> The chips were previously in alphabetical order...
Ok
> 
> -Scott
> 
