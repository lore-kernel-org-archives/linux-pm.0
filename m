From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] power: supply: ltc3651-charger: Fix wrong pointer
 passed to PTR_ERR()
Date: Fri, 19 May 2017 15:07:08 -0700
Message-ID: <20170519220708.GG19281@dtor-ws>
References: <20170517121132.7052-1-weiyj.lk@gmail.com>
 <20170519005948.GA34310@dtor-ws>
 <6AADFAC011213A4C87B956458587ADB47F6B4A@SZXEMI508-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36437 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdESWHM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2017 18:07:12 -0400
Received: by mail-pg0-f44.google.com with SMTP id x64so43644682pgd.3
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2017 15:07:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6AADFAC011213A4C87B956458587ADB47F6B4A@SZXEMI508-MBX.china.huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "weiyongjun (A)" <weiyongjun1@huawei.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Sebastian Reichel <sre@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Wei,

On Fri, May 19, 2017 at 01:27:51AM +0000, weiyongjun (A) wrote:
> Hi, Dmitry
> 
> > Subject: Re: [PATCH -next] power: supply: ltc3651-charger: Fix wrong pointer
> > passed to PTR_ERR()
> > 
> > On Wed, May 17, 2017 at 12:11:32PM +0000, Wei Yongjun wrote:
> > > From: Wei Yongjun <weiyongjun1@huawei.com>
> > >
> > > PTR_ERR should access the value just tested by IS_ERR, otherwise
> > > the wrong error code will be returned.
> > >
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > This does fix the issue, but maybe we want to use PTR_ERR_OR_ZERO()?
> > 
> > 	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
> > 					"lltc,acpr", GPIOD_IN);
> > 	ret = PTR_ERR_OR_ZERO(ltc3651_charger->acpr_gpio);
> > 	if (ret)
> > 		...
> > 
> > Or even
> > 
> > 	err = PTR_ERR_OR_ZERO((ltc3651_charger->acpr_gpio =
> > 		devm_gpiod_get(&pdev->dev, "lltc,acpr", GPIOD_IN)));
> > 	if (err)
> > 		...
> > 
> > To make sure we never mix up pointer. Maybe we need
> > ERR_OR_ASSIGN(ptr1,
> > ptr2) to avoid the ugly assignment in argument above...
> > 
> 
> I have checked devm_gpiod_get() and seems it never return NULL.  And the other
> places call devm_gpiod_get() never check for NULL return. So I think PTR_ERR_OR_ZERO()
> is not need here.

The request to use PTR_ERR_OR_ZERO() had nothing to do with
devm_gpiod_get() returning NULL and everything with reducing number of
times one has to write "ltc3651_charger->acpr_gpio". The original
problem was that we checked the wrong value, if we provide macro
incorporating assignment and conversion to an error code in one step
this will reduce number of times we screw up like that in the future.

Thanks.

-- 
Dmitry
