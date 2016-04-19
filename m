From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] thermal: tegra: mark PM functions __maybe_unused
Date: Tue, 19 Apr 2016 10:35:55 +0800
Message-ID: <5715998B.6080607@nvidia.com>
References: <1460838026-1242452-1-git-send-email-arnd@arndb.de> <20160418071513.GA13078@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160418071513.GA13078-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B404=E6=9C=8818=E6=97=A5 15:15, Thierry Reding wrote:
> * PGP Signed by an unknown key
>=20
> On Sat, Apr 16, 2016 at 10:19:33PM +0200, Arnd Bergmann wrote:
>> After the PM support has been added to this driver, we get
>> a harmless warning when that support is disabled at compile
>> time:
>>
>> drivers/thermal/tegra/soctherm.c:641:12: error: 'soctherm_resume' de=
fined but not used [-Werror=3Dunused-function]
>>  static int soctherm_resume(struct device *dev)
>>
>> This marks the two PM functions as __maybe_unused to shut up
>> the warning. This is preferred over adding an #ifdef around
>> them, as it is harder to get wrong, and provides better
>> compile-time coverage.
>>
>> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> Fixes: a134b4143b65 ("thermal: tegra: add PM support")
>> ---
>>  drivers/thermal/tegra/soctherm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> The need for this should go away when Jon's generic power domain seri=
es

Hi Thierry,
Could you please show me the Jon's generic power domain series, so that=
 I can
verify it.

Thanks.

> gets merged (hopefully very soon now) and enabled on 32-bit ARM. In t=
he
> meantime:
>=20
> Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> * Unknown Key
> * 0x7F3EB3A1
>=20
