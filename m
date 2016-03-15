From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V7 08/12] of: add notes of critical trips for soctherm
Date: Tue, 15 Mar 2016 16:14:15 +0800
Message-ID: <56E7C457.5000301@nvidia.com>
References: <1457665860-30003-1-git-send-email-wni@nvidia.com> <20160314210027.GA4740@localhost.localdomain> <56E7BE87.405@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18695 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbcCOIOH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 04:14:07 -0400
In-Reply-To: <56E7BE87.405@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 15:49, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 05:00, Eduardo Valentin wrote:
>> * PGP Signed by an unknown key
>>
>> On Fri, Mar 11, 2016 at 11:11:00AM +0800, Wei Ni wrote:
>>> The "critical" type trip in thermal zone can be
>>> set to SOC_THERM hardware, it can trigger shut down
>>> or reset event from hardware.
>>>
>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  Documentation/devicetree/bindings/thermal/tegra-soctherm.txt | 12 =
++++++++++++
>>>  1 file changed, 12 insertions(+)
>>
>> I did not see in your patch set an update on the compatible string f=
or
>> the new chip. Did I miss something?
>=20
> As I said in the previous [00/12], the "commit 193c9d23a0f0" already =
added the
> compatible string. At that time, it just used current tegra_soctherm.=
c driver to
> support Tegra210, it can work, but can't show temperatures correctly.

Oh, sorry, I made a mistake, this "commit 193c9d23a0f0" just added the
compatible string, did not use current tegra_soctherm driver to support=
 Tegra210.

Wei.

>=20
>>
>> * Unknown Key
>> * 0x7DA4E256
>>
