From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH] thermal: tegra: mark PM functions __maybe_unused
Date: Wed, 20 Apr 2016 14:44:22 +0800
Message-ID: <57172546.6090106@nvidia.com>
References: <1460838026-1242452-1-git-send-email-arnd@arndb.de> <20160418071513.GA13078@ulmo.ba.sec> <5715998B.6080607@nvidia.com> <20160419124319.GG8284@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:30282 "EHLO
	hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964AbcDTGnN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 02:43:13 -0400
In-Reply-To: <20160419124319.GG8284@ulmo.ba.sec>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org



On 2016=E5=B9=B404=E6=9C=8819=E6=97=A5 20:43, Thierry Reding wrote:
> * PGP Signed by an unknown key
>=20
> On Tue, Apr 19, 2016 at 10:35:55AM +0800, Wei Ni wrote:
>>
>>
>> On 2016=E5=B9=B404=E6=9C=8818=E6=97=A5 15:15, Thierry Reding wrote:
>>>> Old Signed by an unknown key
>>>
>>> On Sat, Apr 16, 2016 at 10:19:33PM +0200, Arnd Bergmann wrote:
>>>> After the PM support has been added to this driver, we get
>>>> a harmless warning when that support is disabled at compile
>>>> time:
>>>>
>>>> drivers/thermal/tegra/soctherm.c:641:12: error: 'soctherm_resume' =
defined but not used [-Werror=3Dunused-function]
>>>>  static int soctherm_resume(struct device *dev)
>>>>
>>>> This marks the two PM functions as __maybe_unused to shut up
>>>> the warning. This is preferred over adding an #ifdef around
>>>> them, as it is harder to get wrong, and provides better
>>>> compile-time coverage.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> Fixes: a134b4143b65 ("thermal: tegra: add PM support")
>>>> ---
>>>>  drivers/thermal/tegra/soctherm.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> The need for this should go away when Jon's generic power domain se=
ries
>>
>> Hi Thierry,
>> Could you please show me the Jon's generic power domain series, so t=
hat I can
>> verify it.
>=20
> Here are the remaining patches from Jon's series:
>=20
> 	https://patchwork.ozlabs.org/patch/603285/
> 	https://patchwork.ozlabs.org/patch/603287/
> 	https://patchwork.ozlabs.org/patch/603284/

I checked this generic power domain series, it select PM and PM_GENERIC=
_DOMAINS
for Tegra SoC Family. But the soctherm_suspend/resume callbacks defined=
 by
SIMPLE_DEV_PM_OPS are only used when the CONFIG_PM_SLEEP is enabled, so=
 if the
CONFIG_PM_SLEEP is disabled, we still will get this warning.
So to avoid the warning, I think this patch is needed.

Wei.

>=20
> Thierry
>=20
> * Unknown Key
> * 0x7F3EB3A1
>=20
