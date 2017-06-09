From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH] devfreq: exynos-ppmu: Staticize event list
Date: Fri, 09 Jun 2017 00:28:27 +0000
Message-ID: <20170609002827epcms1p74adfa60f131853c9c7ab9826a921fb53@epcms1p7>
References: <5938A6CC.8030206@samsung.com>
        <20170607181228.32102-1-krzk@kernel.org>
        <CGME20170607181258epcas2p4191204d7b3853ef0482d84df7a06589d@epcms1p7>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5938A6CC.8030206@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Hi Krzysztof,
> 
> On 2017년 06월 08일 03:12, Krzysztof Kozlowski wrote:

> > The ppmu_events array is accessed only in this compilation unit so it

> > can be made static.

> > 

> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

> > ---

> >  drivers/devfreq/event/exynos-ppmu.c | 2 +-

> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > 

> > diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c

> > index 9b7350935b73..c68f3b5a10b5 100644

> > --- a/drivers/devfreq/event/exynos-ppmu.c

> > +++ b/drivers/devfreq/event/exynos-ppmu.c

> > @@ -44,7 +44,7 @@ struct exynos_ppmu {

> >  	{ "ppmu-event2-"#name, PPMU_PMNCNT2 },	\

> >  	{ "ppmu-event3-"#name, PPMU_PMNCNT3 }

> >  

> > -struct __exynos_ppmu_events {

> > +static struct __exynos_ppmu_events {

> >  	char *name;

> >  	int id;

> >  } ppmu_events[] = {

> > 

> 

> Looks good to me.

> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>



Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>





Cheers,

MyungJoo
