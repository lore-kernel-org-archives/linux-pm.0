From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V9 RESEND 14/14] arm: tegra: set critical trips for Tegra124
Date: Tue, 12 Apr 2016 16:53:52 +0800
Message-ID: <570CB7A0.2080908@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com> <1459247364-1139-15-git-send-email-wni@nvidia.com> <20160329151705.GC1855@localhost.localdomain> <56FE1D82.7090908@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:26631 "EHLO
	hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756421AbcDLIxE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 04:53:04 -0400
In-Reply-To: <56FE1D82.7090908@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, thierry.reding@gmail.com, swarren@wwwdotorg.org
Cc: rui.zhang@intel.com, MLongnecker@nvidia.com, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Could anyone take a look at this patch?

On 2016=E5=B9=B404=E6=9C=8801=E6=97=A5 15:04, Wei Ni wrote:
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
> On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 23:17, Eduardo Valentin wrote:
>> On Tue, Mar 29, 2016 at 06:29:24PM +0800, Wei Ni wrote:
>>> Set general "critical" trip temperatures for cpu, gpu, mem and pllx
>>> thermal zones for all Tegra124 platform, these trips can trigger
>>> shut down or reset.
>>> Tegra124 Jetson TK1 was already set "critical" trips before, so it
>>> can overwrite the general values.
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
