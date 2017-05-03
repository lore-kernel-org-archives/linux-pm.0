From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Wed, 3 May 2017 21:33:24 +0200
Message-ID: <51fb1bd0-028d-c431-acc8-3c4f1d25fdba@denx.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:33853 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbdECTqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 15:46:37 -0400
In-Reply-To: <1493834298.11226.40.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christoph Fritz <chf.fritz@googlemail.com>, Shawn Guo <shawnguo@kernel.org>

On 05/03/2017 07:58 PM, Leonard Crestez wrote:
> On Wed, 2017-05-03 at 17:59 +0200, Marek Vasut wrote:
>> On 05/03/2017 04:58 PM, Leonard Crestez wrote:
>>> On Wed, 2017-05-03 at 16:26 +0200, Marek Vasut wrote:
>>>> 2) It actually fixes a problem with the voltage rails such that the DVFS
>>>>    works without leaving the system in unstable or dead state. You do
>>>>    need the second part of my patch if you drop the OPP hackery, without
>>>>    it the power framework cannot correctly configure the core voltages,
>>>>    so the patch from Leonard makes things worse.
>>> No, I think there is a misunderstanding here. The second part of your
>>> patch will cause cpufreq poking at LDOs to indirectly adjust the input
>>> from the PMIC to the minimum required (this is LDO target +
>>> min_dropout_uv). Without it by default VDD_ARM_SOC_IN will remain fixed
>>> as 1375mV from boot.
> 
>> Who sets / guarantees that default value for ARM and SOC rails ?
> 
> I think it's from the PMIC hardware itself (but maybe uboot plays with
> it). VDD_ARM_SOC_IN on this board is tied to SW1AB from MMPF0200:
> 
> http://www.nxp.com/assets/documents/data/en/data-sheets/MMPF0200.pdf
> 
> It seems reasonable to rely on such voltages set externally.

Isn't it an established rule that Linux should not depend on bootloader
settings ? Or did that change ?

>> With the OPP override in place, there's at least the guarantee that both
>> rails will have the same voltage requirement. If you remove the OPP
>> override without modeling the actual regulator wiring, the guarantee is
>> gone.
> 
> The imx6sx chip has internal LDO_ARM and LDO_SOC regulators which can
> generate separate voltages for arm/soc. The fact that these regulators
> share the same supply is only an issue when they are set in bypass
> mode.
> 
> However the boot issues happen on REV C but apparently not REV B of the
> board. I don't have a good explanation for this so maybe I am missing
> something.

Well the regulator(s) cannot be correctly configured if the kernel
doesn't have the correct power distribution described in the DT .

-- 
Best regards,
Marek Vasut
