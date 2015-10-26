From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Can arm64 plan to support =?utf-8?Q?hi?=
 =?utf-8?Q?bernation=EF=BC=88suspend-to-disk=EF=BC=89in_current_kernel?=
 =?utf-8?B?77yIQVRG77yJ77yf?=
Date: Mon, 26 Oct 2015 10:09:48 +0000
Message-ID: <20151026100948.GA8299@red-moon>
References: <562DF7B9.9030309@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <562DF7B9.9030309@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wangfei <w.f@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wangdedong@huawei.com, Maxiaobo <maxiaobo@huawei.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 26, 2015 at 05:51:53PM +0800, wangfei wrote:
> Hi all=EF=BC=8C
>=20
> Is any one knew=EF=BC=8Cwhether mainline kernel and psci plan to supp=
ort hibernation on arm64 architecture now=EF=BC=9F

Suspend-to-disk relies on PSCI SYSTEM_OFF to be implemented and does no=
t
require any additional calls in ATF.

Suspend to disk ARM64 kernel patches are under review (series below on =
LAKML),
I hope you can help us review and test them.

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/3764=
50.html

Thanks a lot,
Lorenzo

>=20
> Thanks
> Best Regards
>=20
> william
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
