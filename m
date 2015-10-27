From: wangfei <w.f@huawei.com>
Subject: Re: Can arm64 plan to support =?UTF-8?B?aGliZXJuYXRpb27vvIhzdXNw?=
 =?UTF-8?B?ZW5kLXRvLWRpc2vvvIlpbiBjdXJyZW50IGtlcm5lbO+8iEFURu+8ie+8nw==?=
Date: Tue, 27 Oct 2015 09:06:27 +0800
Message-ID: <562ECE13.5030702@huawei.com>
References: <562DF7B9.9030309@huawei.com> <20151026100948.GA8299@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:18150 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbJ0BGp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2015 21:06:45 -0400
In-Reply-To: <20151026100948.GA8299@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wangdedong@huawei.com, Maxiaobo <maxiaobo@huawei.com>

On 2015/10/26 18:09, Lorenzo Pieralisi wrote:
> On Mon, Oct 26, 2015 at 05:51:53PM +0800, wangfei wrote:
>> Hi all=EF=BC=8C
>>
>> Is any one knew=EF=BC=8Cwhether mainline kernel and psci plan to sup=
port hibernation on arm64 architecture now=EF=BC=9F
>=20
> Suspend-to-disk relies on PSCI SYSTEM_OFF to be implemented and does =
not
> require any additional calls in ATF.
>=20
> Suspend to disk ARM64 kernel patches are under review (series below o=
n LAKML),
> I hope you can help us review and test them.
>=20
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/37=
6450.html
OK=EF=BC=8C thanks Lorenzo=EF=BC=8Cwe will test on our arm64 devices an=
d feed back result to you=E3=80=82
>=20
> Thanks a lot,
> Lorenzo
>=20
>>
>> Thanks
>> Best Regards
>>
>> william
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>=20
> .
>=20


