From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH RESEND] cpufreq: exynos: Fix build error of no type of
 module_init
Date: Wed, 22 Jan 2014 15:59:20 +0100
Message-ID: <1390402760.18340.6.camel@AMDC1943>
References: <1390400476-22951-1-git-send-email-k.kozlowski@samsung.com>
 <CAKohpo=2wR+Sqwxj4koH0rvuk29BkNyAZgN0RR7bVH+3uqpB1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpo=2wR+Sqwxj4koH0rvuk29BkNyAZgN0RR7bVH+3uqpB1Q@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-01-22 at 20:12 +0530, Viresh Kumar wrote:
> On 22 January 2014 19:51, Krzysztof Kozlowski <k.kozlowski@samsung.co=
m> wrote:
> > Add missing include to fix build error:
> > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition ha=
s no type or storage class [enabled by default]
> > drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to =E2=
=80=98int=E2=80=99 in declaration of =E2=80=98module_init=E2=80=99 [-We=
rror=3Dimplicit-int]
> > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (w=
ithout types) in function declaration [enabled by default]
> > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition ha=
s no type or storage class [enabled by default]
> > drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to =E2=
=80=98int=E2=80=99 in declaration of =E2=80=98module_exit=E2=80=99 [-We=
rror=3Dimplicit-int]
> > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (w=
ithout types) in function declaration [enabled by default]
> > drivers/cpufreq/exynos-cpufreq.c:292:1: warning: =E2=80=98exynos_cp=
ufreq_platdrv_init=E2=80=99 defined but not used [-Wunused-function]
> > cc1: some warnings being treated as errors
> > make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
> > make[1]: *** [drivers/cpufreq] Error 2
> >
> > Build error happens on gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubun=
tu5)
> > and was introduced by commit d568b6f71df1 (cpufreq: exynos: Convert
> > exynos-cpufreq to platform driver).
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Lukasz Majewski <l.majewski@samsung.com>
> > Cc: Tomasz Figa <t.figa@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/cpufreq/exynos-cpufreq.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exy=
nos-cpufreq.c
> > index fcd2914d081a..fa54c2b88dd7 100644
> > --- a/drivers/cpufreq/exynos-cpufreq.c
> > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/suspend.h>
> > +#include <linux/module.h>
> >  #include <linux/platform_device.h>
>=20
> I am surprised how that patch went through then? And nothing was
> reported by kbuild for it..

Hi,

A little more explanation from my side: the build error actually happen=
s
only on next/master, not Linus' tree.

Mentioned commit which changes the driver to platform driver is in
mainline since 3.12-rc2 so it seems this is not the cause of the build
error. I think I need to find first the real cause of this build error.

Best regards,
Krzysztof



