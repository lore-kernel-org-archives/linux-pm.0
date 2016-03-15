From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 08/12] of: add notes of critical trips for soctherm
Date: Tue, 15 Mar 2016 15:49:27 +0800
Message-ID: <56E7BE87.405@nvidia.com>
References: <1457665860-30003-1-git-send-email-wni@nvidia.com> <20160314210027.GA4740@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160314210027.GA4740-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 05:00, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Fri, Mar 11, 2016 at 11:11:00AM +0800, Wei Ni wrote:
>> The "critical" type trip in thermal zone can be
>> set to SOC_THERM hardware, it can trigger shut down
>> or reset event from hardware.
>>
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/tegra-soctherm.txt | 12 +=
+++++++++++
>>  1 file changed, 12 insertions(+)
>=20
> I did not see in your patch set an update on the compatible string fo=
r
> the new chip. Did I miss something?

As I said in the previous [00/12], the "commit 193c9d23a0f0" already ad=
ded the
compatible string. At that time, it just used current tegra_soctherm.c =
driver to
support Tegra210, it can work, but can't show temperatures correctly.

>=20
> * Unknown Key
> * 0x7DA4E256
>=20
