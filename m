From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 3/3] PM / devfreq: fix mem leak in devfreq_add_device()
Date: Mon, 21 Jan 2019 10:23:51 +0900
Message-ID: <20190121012351epcms1p59b810ea2b6ebdaf80a85fbe17b60d1bf@epcms1p5>
References: <20190119160454.23151-3-tiny.windzz@gmail.com>
        <20190119160454.23151-1-tiny.windzz@gmail.com>
        <CGME20190119183505epcas1p15efda0795b3c94601bcb2f442ab15232@epcms1p5>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119160454.23151-3-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Yangtao Li <tiny.windzz@gmail.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>'devfreq' is malloced in devfreq_add_device() and should be freed in
>the error handling cases, otherwise it will cause memory leak.
>
>Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


>---
> drivers/devfreq/devfreq.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>index 923889229a0b..fe6c157cb7e0 100644
>--- a/drivers/devfreq/devfreq.c
>+++ b/drivers/devfreq/devfreq.c
>@@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
> 		mutex_unlock(&devfreq->lock);
> 		err = set_freq_table(devfreq);
> 		if (err < 0)
>-			goto err_out;
>+			goto err_dev;
> 		mutex_lock(&devfreq->lock);
> 	}
> 
