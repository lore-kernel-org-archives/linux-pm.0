From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v4 05/10] power: bq24257: Add SW-based approach for Power
 Good determination
Date: Fri, 18 Sep 2015 16:28:17 -0500
Message-ID: <20150918212816.GI27772@beast>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-6-git-send-email-dannenberg@ti.com>
 <55F900F9.90306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33098 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753463AbbIRV2y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Sep 2015 17:28:54 -0400
Content-Disposition: inline
In-Reply-To: <55F900F9.90306@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 16, 2015 at 02:41:13PM +0900, Krzysztof Kozlowski wrote:
> On 16.09.2015 02:58, Andreas Dannenberg wrote:
> > @@ -676,7 +696,7 @@ static int bq24257_pg_gpio_probe(struct bq24257_device *bq)
> >  {
> >  	bq->pg = devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0, GPIOD_IN);
> >  	if (IS_ERR(bq->pg)) {
> > -		dev_err(bq->dev, "could not probe PG pin\n");
> > +		dev_info(bq->dev, "could not probe PG pin\n");
> 
> I think if pg-gpio is provided (e.g. by DTS) but it is invalid (return
> value != ENOENT) then it is an error you could print. The driver will
> fallback to the software method but still user/developer may want to
> notice the error (e.g. error in DTS).
> 
> Anyway it is up to you, rest looks good:

Krzysztof,
I looked at this closer and all the error scenarios I could come up with
to test regarding the pin definition in DT (wrong pin numbers, missing
definition altogether) all generated an -ENOENT coming out of
devm_gpiod_get_index() with no differentiation between the cases. I'm
sure there is some way to accomplish that but for the time being I left
the refinement between dev_err() and dev_info() alone.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

