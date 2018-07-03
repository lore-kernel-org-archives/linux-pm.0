From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
Date: Tue, 03 Jul 2018 19:57:23 +0900
Message-ID: <20180703105723epcms1p63bd7b3cf49722b204d7ca0dfd98d5d15@epcms1p6>
References: <20180621220430.25644-1-enric.balletbo@collabora.com>
        <CGME20180621220442epcas2p14960cff4b08825aceb9d0e7ff810aeae@epcms1p6>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621220430.25644-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kernel@collabora.com" <kernel@collabora.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>@@ -988,12 +1030,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
> 	if (ret != 1)
> 		return -EINVAL;
> 
>-	mutex_lock(&devfreq_list_lock);
>-	governor = find_devfreq_governor(str_governor);
>+	governor = try_then_request_governor(str_governor);
> 	if (IS_ERR(governor)) {
>-		ret = PTR_ERR(governor);
>-		goto out;
>+		return PTR_ERR(governor);
> 	}
>+
>+	mutex_lock(&devfreq_list_lock);
>+
> 	if (df->governor == governor) {
> 		ret = 0;
> 		goto out;
>-- 

The possibility that the result of try_then_request_governor is
not kept protected until the line of
"if (df->governor == governor)" is itching.

Can you make it kept "locked" from the return of
find_devfreq_governor() (either in try_then... or in this function)
to the unlock of governor_store()?


Cheers,
MyungJoo
