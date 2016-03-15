From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 00/12] Add T210 support in Tegra soctherm
Date: Tue, 15 Mar 2016 13:46:55 +0800
Message-ID: <56E7A1CF.4060302@nvidia.com>
References: <1457665763-29781-1-git-send-email-wni@nvidia.com> <20160314210152.GA4717@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160314210152.GA4717-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 05:01, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Fri, Mar 11, 2016 at 11:09:11AM +0800, Wei Ni wrote:
>> This patchset adds following functions for tegra_soctherm driver:
>> 1. add T210 support.
>=20
> It would be good to update the compatible string in the binding
> documentation.

The commit "193c9d23a0f0 Documentation: DT bindings: add more Tegra chi=
p
compatible strings" already add compatible string for Tegra210.

>=20
>> 2. export debugfs to show some registers.
>> 3. add thermtrip funciton.
>> 4. add suspend/resume function.
>=20
> Thanks for your effort in keeping up with upstream. I think overall t=
he
> series is good, I had only very few comments (in response to each
> patch).

Thanks for your review. I will check these comments, and update my patc=
hes in
next few days.

Wei.

>=20
> BR,
>=20
> Eduardo Valentin
>=20
>=20
>>
>>
>> --=20
>> 1.9.1
>>
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
