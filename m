From: "David.Wu" <wdc@rock-chips.com>
Subject: Re: [PATCH] PM / AVS: rockchip-io: add GRF and PMUGRF types to
 distinguish
Date: Tue, 2 Feb 2016 17:38:43 +0800
Message-ID: <56B07923.9020900@rock-chips.com>
References: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com>
 <5387650.lAgTxexlF2@phil> <56AF1D4E.40307@rock-chips.com>
 <5354361.hQXgJ7cEGx@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:49747 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbcBBJin (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 04:38:43 -0500
In-Reply-To: <5354361.hQXgJ7cEGx@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: David Wu <david.wu@rock-chips.com>, khilman@kernel.org, nm@ti.com, huangtao@rock-chips.com, cf@rock-chips.com, zyw@rock-chips.com, xjq@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Heiko,

=E5=9C=A8 2016/2/2 5:17, Heiko St=C3=BCbner =E5=86=99=E9=81=93:
> Hi David,
>
> Am Montag, 1. Februar 2016, 16:54:38 schrieb David.Wu:
>> =E5=9C=A8 2016/1/30 20:39, Heiko Stuebner =E5=86=99=E9=81=93:
>>> Am Samstag, 30. Januar 2016, 20:01:45 schrieb David Wu:
>>>> As rk3368 contained two separated iodomain areas, this was
>>>> determined to use which regmap base address.
>>>>
>>>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>>> I don't think we need to specify this on a driver level. Both GRF a=
reas
>>> are
>>> "General register files" only located in two separate power-domains=
=2E
>>> So the rockchip,grf property should work for both. Especially as no=
thing
>>> keeps designers from introducing yet another GRF-area somewhere els=
e ;-)
>>>
>>> >From when I started working on the rk3368, I still have a prelimin=
ary
>>>
>>> patches for that sitting here, so I've attached on how I envisoned =
that to
>>> work.
>> Okay, i agree to you, but it make someone a little confused just fro=
m
>> the drive code,
>> not DT file,  about  pmugrf regmap base address.:-)
>>
>> How do you feel about intergating GRF and PMU drivers in one driver?
>> Thanks!
> I will very strongly disagree here ;-) .
> Similar to the power-domains being part of the pmu, the io-domains ar=
e
> part of their individual GRFs. So if you want it really clean and tid=
y the way
> to go foward will be the attached patches. Compile-tested only.

Thanks for your reply, the patchs look better than mine.
I have tested them on sdk board and i found something may be wrong.
"parent->of_node" instead of "parent", as the parent is not null if=20
parent-node not used.
         if (parent->of_node) {
             iod->grf =3D syscon_node_to_regmap(parent->of_node);
         } else {
             dev_dbg(&pdev->dev, "falling back to old binding\n");
             iod->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip=
,grf");
         }

> Other things like the usbphy control should move there as well in the=
 long
> run. But that's not immediate necessary.
>
>
> Heiko


