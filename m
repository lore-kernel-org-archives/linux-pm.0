From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V9 RESEND 13/14] arm64: tegra: add soctherm node for Tegra210
Date: Tue, 3 May 2016 17:29:59 +0800
Message-ID: <57286F97.4060007@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com> <1459247364-1139-14-git-send-email-wni@nvidia.com> <20160329151629.GB1855@localhost.localdomain> <56FE1CBB.9000807@nvidia.com> <570CB781.8040208@nvidia.com> <571EE220.3070609@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <571EE220.3070609@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, thierry.reding@gmail.com, swarren@wwwdotorg.org
Cc: Eduardo Valentin <edubezval@gmail.com>, rui.zhang@intel.com, MLongnecker@nvidia.com, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Will move patch 12 and 14 to my "Add HW throttle for Tegra soctherm" se=
ries.

On 2016=E5=B9=B404=E6=9C=8826=E6=97=A5 11:36, Wei Ni wrote:
> Hi Thierry,
>=20
> Do you know who can take these patch 13 and 14?
> The corresponding driver was merged to linux-next several weeks ago.
> Does I need to send these two patches again?
>=20
> Thanks.
> Wei.
>=20
> On 2016=E5=B9=B404=E6=9C=8812=E6=97=A5 16:53, Wei Ni wrote:
>> Could anyone take a look this patch?
>>
>> On 2016=E5=B9=B404=E6=9C=8801=E6=97=A5 15:01, Wei Ni wrote:
>>> Patches 1 to 12 in this series were accepted by Eduardo.
>>> Patches 13 and 14 need to go via platform or dt tree.
>>>
>>> Used get_maintainer.pl to get maintainers and open list, add them i=
n To: and Cc:
>>> list.
>>>
>>> To:
>>> Rob Herring <robh+dt@kernel.org>
>>> Pawel Moll <pawel.moll@arm.com>
>>> Mark Rutland <mark.rutland@arm.com>
>>> Ian Campbell <ijc+devicetree@hellion.org.uk>
>>> Kumar Gala <galak@codeaurora.org>
>>>
>>> Cc:
>>> devicetree@vger.kernel.org
>>>
>>> On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 23:16, Eduardo Valentin wrot=
e:
>>>> On Tue, Mar 29, 2016 at 06:29:23PM +0800, Wei Ni wrote:
>>>>> Adds soctherm node for Tegra210, and add cpu,
>>>>> gpu, mem, pllx as thermal-zones. Set critical
>>>>> trip temperatures for them.
>>>>>
>>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>>
>>>> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pm"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
