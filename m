From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [RESEND PATCH] PM / devfreq: Fix static checker warning in
 try_then_request_governor
Date: Thu, 14 Mar 2019 16:47:34 +0900
Message-ID: <20190314074734epcms1p8c7c23ea44032c17581fd1bf252bea5fa@epcms1p8>
References: <20190313122253.24355-1-enric.balletbo@collabora.com>
        <CGME20190313122310epcas5p1cc4a6a8570c90ce76743b90a7e5c96c1@epcms1p8>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313122253.24355-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kernel@collabora.com" <kernel@collabora.com>, Dan Carpenter <dan.carpenter@oracle.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>The patch 23c7b54ca1cd: "PM / devfreq: Fix devfreq_add_device() when
>drivers are built as modules." leads to the following static checker
>warning:
>
>    drivers/devfreq/devfreq.c:1043 governor_store()
>    warn: 'governor' can also be NULL
>
>The reason is that the try_then_request_governor() function returns both
>error pointers and NULL. It should just return error pointers, so fix
>this by returning a ERR_PTR to the error intead of returning NULL.
>
>Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>---
>Hi,
>
>This is a resend of [1] as seems that got lost at some point and I just
>noticed that was never merged.
>
>Thanks,
> Enric

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Thanks!


CHeers,
MyungJoo
