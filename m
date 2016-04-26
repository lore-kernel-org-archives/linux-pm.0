From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V9 RESEND 13/14] arm64: tegra: add soctherm node for Tegra210
Date: Tue, 26 Apr 2016 11:36:00 +0800
Message-ID: <571EE220.3070609@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com> <1459247364-1139-14-git-send-email-wni@nvidia.com> <20160329151629.GB1855@localhost.localdomain> <56FE1CBB.9000807@nvidia.com> <570CB781.8040208@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570CB781.8040208-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Thierry,

Do you know who can take these patch 13 and 14?
The corresponding driver was merged to linux-next several weeks ago.
Does I need to send these two patches again?

Thanks.
Wei.

On 2016=E5=B9=B404=E6=9C=8812=E6=97=A5 16:53, Wei Ni wrote:
> Could anyone take a look this patch?
>=20
> On 2016=E5=B9=B404=E6=9C=8801=E6=97=A5 15:01, Wei Ni wrote:
>> Patches 1 to 12 in this series were accepted by Eduardo.
>> Patches 13 and 14 need to go via platform or dt tree.
>>
>> Used get_maintainer.pl to get maintainers and open list, add them in=
 To: and Cc:
>> list.
>>
>> To:
>> Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
>> Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
>> Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> Cc:
>> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>
>> On 2016=E5=B9=B403=E6=9C=8829=E6=97=A5 23:16, Eduardo Valentin wrote=
:
>>> On Tue, Mar 29, 2016 at 06:29:23PM +0800, Wei Ni wrote:
>>>> Adds soctherm node for Tegra210, and add cpu,
>>>> gpu, mem, pllx as thermal-zones. Set critical
>>>> trip temperatures for them.
>>>>
>>>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>
>>> Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
