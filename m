From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Wed, 3 May 2017 16:32:06 +0200
Message-ID: <0f84e2ee-1ea1-acf8-8368-3fc848d33e23@denx.de>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
 <CAOMZO5BsgXRfgZ0hszk2Vgo2keVDHH1BLbJTbW+awMS2cBoNow@mail.gmail.com>
 <CAOMZO5CKUsEr1yf5RrsPLipNtLC_6sK0dPjT2M-eN-uo8hEbrQ@mail.gmail.com>
 <1493141004.3557.8.camel@nxp.com>
 <f3bbd20c-2132-1121-1044-ba00dba302d6@denx.de>
 <20170503135715.GG18578@dragon>
 <76e22a7e-590f-00ee-04f8-87604303eaad@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41891 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbdECOcL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 10:32:11 -0400
In-Reply-To: <76e22a7e-590f-00ee-04f8-87604303eaad@denx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Peter Chen <Peter.Chen@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Christoph Fritz <chf.fritz@googlemail.com>

On 05/03/2017 04:26 PM, Marek Vasut wrote:
> On 05/03/2017 03:57 PM, Shawn Guo wrote:
>> On Tue, Apr 25, 2017 at 07:28:06PM +0200, Marek Vasut wrote:
>>> On 04/25/2017 07:23 PM, Leonard Crestez wrote:
>>>> Anyway, that version also sets the supply for reg_arm and reg_soc. It
>>>> is not necessary for fixing the crash I'm seeing but is good because it
>>>> will result in the minimum voltage on VDD_ARM_SOC_IN rather than a fix
>>>> 1375mv. I tested Marek's patch and it works fine on my rev B board
>>>> (which otherwise fails to boot upstream).
>>>
>>> Oh that's nice , thanks ! I don't have SDB and I hacked it up after a
>>> brief discussion with Fabio without even compile-testing it, thus RFC.
>>> Glad to hear it works and thanks for testing it ! Can you add a formal
>>> Tested-by please ?
>>
>> Hi Marek,
> 
> Hi Shawn,
> 
>> Thanks for your patch.  But I prefer Leonard's version because: 1) it
>> has a better commit log; 2) it sticks to one-patch-does-one-thing
>> policy.
> 
> Well I'd prefer this patch because
> 1) It has T-B

Correction, two TBs [1]

[1] https://patchwork.kernel.org/patch/9698749/

> 2) It actually fixes a problem with the voltage rails such that the DVFS
>    works without leaving the system in unstable or dead state. You do
>    need the second part of my patch if you drop the OPP hackery, without
>    it the power framework cannot correctly configure the core voltages,
>    so the patch from Leonard makes things worse.
> 
>> But I'm going to wait for a while to get Peter's comment discussed,
>> before I actually apply Leonard's patch.
>>
>> Shawn
>>
> 
> 


-- 
Best regards,
Marek Vasut
