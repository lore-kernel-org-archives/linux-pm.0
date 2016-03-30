From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V9 RESEND 13/14] arm64: tegra: add soctherm node for Tegra210
Date: Wed, 30 Mar 2016 11:24:51 +0800
Message-ID: <56FB4703.7020201@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com> <1459247364-1139-14-git-send-email-wni@nvidia.com> <20160329151629.GB1855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:25914 "EHLO
	hkmmgate101.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753725AbcC3DYe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 23:24:34 -0400
In-Reply-To: <20160329151629.GB1855@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: thierry.reding@gmail.com, swarren@wwwdotorg.org
Cc: Eduardo Valentin <edubezval@gmail.com>, rui.zhang@intel.com, MLongnecker@nvidia.com, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Thierry & Stephen,
The driver patches in this series were taken by Eduardo, so do know who=
 can take
these tow dts patches 13 and 14?

Thanks.
Wei.

On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 23:16, Eduardo Valentin wrote:
> On Tue, Mar 29, 2016 at 06:29:23PM +0800, Wei Ni wrote:
>> Adds soctherm node for Tegra210, and add cpu,
>> gpu, mem, pllx as thermal-zones. Set critical
>> trip temperatures for them.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>=20
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>=20
