From: "weiyongjun (A)" <weiyongjun1@huawei.com>
Subject: RE: [PATCH -next] power: supply: ltc3651-charger: Fix wrong pointer
 passed to PTR_ERR()
Date: Fri, 19 May 2017 01:27:51 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB47F6B4A@SZXEMI508-MBX.china.huawei.com>
References: <20170517121132.7052-1-weiyj.lk@gmail.com>
 <20170519005948.GA34310@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:6357 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbdESB2F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2017 21:28:05 -0400
In-Reply-To: <20170519005948.GA34310@dtor-ws>
Content-Language: zh-CN
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wei Yongjun <weiyj.lk@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi, Dmitry

> Subject: Re: [PATCH -next] power: supply: ltc3651-charger: Fix wrong pointer
> passed to PTR_ERR()
> 
> On Wed, May 17, 2017 at 12:11:32PM +0000, Wei Yongjun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > PTR_ERR should access the value just tested by IS_ERR, otherwise
> > the wrong error code will be returned.
> >
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> This does fix the issue, but maybe we want to use PTR_ERR_OR_ZERO()?
> 
> 	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
> 					"lltc,acpr", GPIOD_IN);
> 	ret = PTR_ERR_OR_ZERO(ltc3651_charger->acpr_gpio);
> 	if (ret)
> 		...
> 
> Or even
> 
> 	err = PTR_ERR_OR_ZERO((ltc3651_charger->acpr_gpio =
> 		devm_gpiod_get(&pdev->dev, "lltc,acpr", GPIOD_IN)));
> 	if (err)
> 		...
> 
> To make sure we never mix up pointer. Maybe we need
> ERR_OR_ASSIGN(ptr1,
> ptr2) to avoid the ugly assignment in argument above...
> 

I have checked devm_gpiod_get() and seems it never return NULL.  And the other
places call devm_gpiod_get() never check for NULL return. So I think PTR_ERR_OR_ZERO()
is not need here.

Regards,
Yongjun Wei
