From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V9 RESEND 13/14] arm64: tegra: add soctherm node for Tegra210
Date: Tue, 12 Apr 2016 16:53:21 +0800
Message-ID: <570CB781.8040208@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com> <1459247364-1139-14-git-send-email-wni@nvidia.com> <20160329151629.GB1855@localhost.localdomain> <56FE1CBB.9000807@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:23295 "EHLO
	hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756339AbcDLIw3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 04:52:29 -0400
In-Reply-To: <56FE1CBB.9000807@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, thierry.reding@gmail.com, swarren@wwwdotorg.org
Cc: Eduardo Valentin <edubezval@gmail.com>, rui.zhang@intel.com, MLongnecker@nvidia.com, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Could anyone take a look this patch?

On 2016=E5=B9=B404=E6=9C=8801=E6=97=A5 15:01, Wei Ni wrote:
> Patches 1 to 12 in this series were accepted by Eduardo.
> Patches 13 and 14 need to go via platform or dt tree.
>=20
> Used get_maintainer.pl to get maintainers and open list, add them in =
To: and Cc:
> list.
>=20
> To:
> Rob Herring <robh+dt@kernel.org>
> Pawel Moll <pawel.moll@arm.com>
> Mark Rutland <mark.rutland@arm.com>
> Ian Campbell <ijc+devicetree@hellion.org.uk>
> Kumar Gala <galak@codeaurora.org>
>=20
> Cc:
> devicetree@vger.kernel.org
>=20
> On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 23:16, Eduardo Valentin wrote:
>> On Tue, Mar 29, 2016 at 06:29:23PM +0800, Wei Ni wrote:
>>> Adds soctherm node for Tegra210, and add cpu,
>>> gpu, mem, pllx as thermal-zones. Set critical
>>> trip temperatures for them.
>>>
>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>
>> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
