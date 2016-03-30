From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V9 RESEND 13/14] arm64: tegra: add soctherm node for Tegra210
Date: Wed, 30 Mar 2016 18:28:08 +0800
Message-ID: <56FBAA38.6000309@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com> <1459247364-1139-14-git-send-email-wni@nvidia.com> <20160329151629.GB1855@localhost.localdomain> <56FB4703.7020201@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FB4703.7020201-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

On 2016=E5=B9=B403=E6=9C=8830=E6=97=A5 11:24, Wei Ni wrote:
> Hi Thierry & Stephen,
> The driver patches in this series were taken by Eduardo, so do know w=
ho can take
> these tow dts patches 13 and 14?
>=20
> Thanks.
> Wei.
>=20
> On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 23:16, Eduardo Valentin wrote:
>> On Tue, Mar 29, 2016 at 06:29:23PM +0800, Wei Ni wrote:
>>> Adds soctherm node for Tegra210, and add cpu,
>>> gpu, mem, pllx as thermal-zones. Set critical
>>> trip temperatures for them.
>>>
>>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
