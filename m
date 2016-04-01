From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V9 RESEND 13/14] arm64: tegra: add soctherm node for Tegra210
Date: Fri, 1 Apr 2016 15:01:15 +0800
Message-ID: <56FE1CBB.9000807@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com> <1459247364-1139-14-git-send-email-wni@nvidia.com> <20160329151629.GB1855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329151629.GB1855@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Patches 1 to 12 in this series were accepted by Eduardo.
Patches 13 and 14 need to go via platform or dt tree.

Used get_maintainer.pl to get maintainers and open list, add them in To=
: and Cc:
list.

To:
Rob Herring <robh+dt@kernel.org>
Pawel Moll <pawel.moll@arm.com>
Mark Rutland <mark.rutland@arm.com>
Ian Campbell <ijc+devicetree@hellion.org.uk>
Kumar Gala <galak@codeaurora.org>

Cc:
devicetree@vger.kernel.org

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
