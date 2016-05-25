From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [patch] PM / devfreq: exynos-nocp: Checking for IS_ERR instead
 of NULL
Date: Wed, 25 May 2016 17:11:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1605251710500.3644@hadrien>
References: <20160518103707.GA9436@mwanda> <57459BD4.1030201@samsung.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-158073515-1464189096=:3644"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:32187
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375AbcEYPLi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2016 11:11:38 -0400
In-Reply-To: <57459BD4.1030201@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-158073515-1464189096=:3644
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 25 May 2016, Chanwoo Choi wrote:

> On 2016년 05월 18일 19:37, Dan Carpenter wrote:
> > The platform_get_resource() function returns NULL on error, it never
> > returns error pointers.
> >
> > Fixes: 0179a913875a ('PM / devfreq: event: Add new Exynos NoC probe driver')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
> > index 6b6a5f3..03b35d5 100644
> > --- a/drivers/devfreq/event/exynos-nocp.c
> > +++ b/drivers/devfreq/event/exynos-nocp.c
> > @@ -220,8 +220,8 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
> >
> >  	/* Maps the memory mapped IO to control nocp register */
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (IS_ERR(res))
> > -		return PTR_ERR(res);
> > +	if (!res)
> > +		return -ENXIO;
> >
> >  	base = devm_ioremap_resource(dev, res);
> >  	if (IS_ERR(base))
>
> Looks good to me.

I believe that there is no need for the test at all.
devm_ioremap_resource should make the test.

julia

>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> Thanks,
> Chanwoo Choi
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--8323329-158073515-1464189096=:3644--
