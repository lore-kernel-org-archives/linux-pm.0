From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Wed, 3 May 2017 17:58:53 +0300
Message-ID: <1493823533.11226.28.camel@nxp.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
         <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
         <CAOMZO5CKUsEr1yf5RrsPLipNtLC_6sK0dPjT2M-eN-uo8hEbrQ@mail.gmail.com>
         <1493141004.3557.8.camel@nxp.com>
         <f3bbd20c-2132-1121-1044-ba00dba302d6@denx.de>
         <20170503135715.GG18578@dragon>
         <76e22a7e-590f-00ee-04f8-87604303eaad@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <76e22a7e-590f-00ee-04f8-87604303eaad@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christoph Fritz <chf.fritz@googlemail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-05-03 at 16:26 +0200, Marek Vasut wrote:

> On 05/03/2017 03:57 PM, Shawn Guo wrote:
> > 
> > On Tue, Apr 25, 2017 at 07:28:06PM +0200, Marek Vasut wrote:
> > > 
> > > On 04/25/2017 07:23 PM, Leonard Crestez wrote:
> > > > 
> > > > Anyway, that version also sets the supply for reg_arm and reg_soc. It
> > > > is not necessary for fixing the crash I'm seeing but is good because it
> > > > will result in the minimum voltage on VDD_ARM_SOC_IN rather than a fix
> > > > 1375mv. I tested Marek's patch and it works fine on my rev B board
> > > > (which otherwise fails to boot upstream).
> > > Oh that's nice , thanks ! I don't have SDB and I hacked it up after a
> > > brief discussion with Fabio without even compile-testing it, thus RFC.
> > > Glad to hear it works and thanks for testing it ! Can you add a formal
> > > Tested-by please ?
> > Hi Marek,
> Hi Shawn,
> 
> > Thanks for your patch.  But I prefer Leonard's version because: 1) it
> > has a better commit log; 2) it sticks to one-patch-does-one-thing
> > policy.

> 2) It actually fixes a problem with the voltage rails such that the DVFS
>    works without leaving the system in unstable or dead state. You do
>    need the second part of my patch if you drop the OPP hackery, without
>    it the power framework cannot correctly configure the core voltages,
>    so the patch from Leonard makes things worse.

No, I think there is a misunderstanding here. The second part of your
patch will cause cpufreq poking at LDOs to indirectly adjust the input
from the PMIC to the minimum required (this is LDO target +
min_dropout_uv). Without it by default VDD_ARM_SOC_IN will remain fixed
as 1375mV from boot.

That default value should be high enough for all cpufreq settings.
Setting the LDO parent will cause this voltage to be dynamically
reduced when possible (at low frequencies). This is not required for
proper operation, it is just an optimization to do more of the
regulation in the PMIC instead. It should work just fine without the
second part.

That OPP override exists for "LDO bypass" mode, a feature not present
in upstream. In that mode the internal regulators are set to bypass
mode and voltage is controlled directly from the PMIC. Since VDD_ARM
and VDD_SOC have different minimum requirements but are joined on the
board the OPP voltages are adjusted to max(VDD_ARM, VDD_SOC). If LDOs
are enabled there is no good reason to do this.

I don't care which patch goes in but the effect of the patch should be
clarified.

-- 
Regards,
Leonard
