From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Thu, 4 May 2017 12:42:23 +0300
Message-ID: <1493890943.11226.42.camel@nxp.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
         <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
         <CAOMZO5CKUsEr1yf5RrsPLipNtLC_6sK0dPjT2M-eN-uo8hEbrQ@mail.gmail.com>
         <1493141004.3557.8.camel@nxp.com>
         <f3bbd20c-2132-1121-1044-ba00dba302d6@denx.de>
         <20170503135715.GG18578@dragon>
         <76e22a7e-590f-00ee-04f8-87604303eaad@denx.de>
         <1493823533.11226.28.camel@nxp.com>
         <e46a57c2-4a28-a8b6-445e-299dd9d8659c@denx.de>
         <1493834298.11226.40.camel@nxp.com>
         <51fb1bd0-028d-c431-acc8-3c4f1d25fdba@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com ([104.47.32.55]:40171
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751825AbdEDJmb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 May 2017 05:42:31 -0400
In-Reply-To: <51fb1bd0-028d-c431-acc8-3c4f1d25fdba@denx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Christoph Fritz <chf.fritz@googlemail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 2017-05-03 at 21:33 +0200, Marek Vasut wrote:
> On 05/03/2017 07:58 PM, Leonard Crestez wrote:
> > On Wed, 2017-05-03 at 17:59 +0200, Marek Vasut wrote:
> > > On 05/03/2017 04:58 PM, Leonard Crestez wrote:
> > > > On Wed, 2017-05-03 at 16:26 +0200, Marek Vasut wrote:

> > > > > 2) It actually fixes a problem with the voltage rails such that the DVFS
> > > > >    works without leaving the system in unstable or dead state. You do
> > > > >    need the second part of my patch if you drop the OPP hackery, without
> > > > >    it the power framework cannot correctly configure the core voltages,
> > > > >    so the patch from Leonard makes things worse.

> > > > No, I think there is a misunderstanding here. The second part of your
> > > > patch will cause cpufreq poking at LDOs to indirectly adjust the input
> > > > from the PMIC to the minimum required (this is LDO target +
> > > > min_dropout_uv). Without it by default VDD_ARM_SOC_IN will remain fixed
> > > > as 1375mV from boot.

> > > Who sets / guarantees that default value for ARM and SOC rails ?

> > I think it's from the PMIC hardware itself (but maybe uboot plays with
> > it). VDD_ARM_SOC_IN on this board is tied to SW1AB from MMPF0200:
> > 
> > http://www.nxp.com/assets/documents/data/en/data-sheets/MMPF0200.pdf
> > 
> > It seems reasonable to rely on such voltages set externally.

> Isn't it an established rule that Linux should not depend on bootloader
> settings ? Or did that change ?

I don't actually know. Is there a hard and fast rule about this, even when it comes to voltages?

In theory it is possible for a bootloader to set a low cpu frequency and low voltage and then have the chip fail when the cpufreq driver attempts to go higher. Setting vin-supply on reg_arm/reg_soc would fix that.

> Well the regulator(s) cannot be correctly configured if the kernel
> doesn't have the correct power distribution described in the DT .

It depends on your definition of "correctness". It it certainly
possible to get a functional system while only partially describing
regulator relationships.

I think there is a further misunderstanding here. I have a problem
where imx6sx-sdb rev C boards crash on boot with upstream (but are
reported to work fine with rev B). Removing the OPP overrides fixes
this specific issue.

I don't object to the second part of your patch, setting correct supply links is a good thing for various reasons. It is just not necessary for fixing the concrete crash mentioned above (and I tested this). It should probably go in a separate patch.

It might seem a pedantic difference but it's good to accurately describe the effect of patches in commit messages. For example it might help somebody looking to backport various fixes.

--
Regards,
Leonard
