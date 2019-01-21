From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 2/3] PM / devfreq: fix missing check of return value in
 devfreq_add_device()
Date: Mon, 21 Jan 2019 10:27:50 +0900
Message-ID: <20190121012750epcms1p1b3fae992e1ae0f83c1d530feae02104c@epcms1p1>
References: <20190119160454.23151-2-tiny.windzz@gmail.com>
        <20190119160454.23151-1-tiny.windzz@gmail.com>
        <CGME20190119183509epcas1p27012fefeafe539c3f82030caf85ad308@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119160454.23151-2-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

>devm_kzalloc() could fail, so insert a check of its return value. And
>if it fails, returns -ENOMEM.
>
>Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>---
> drivers/devfreq/devfreq.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>index 076b1c2f40a4..923889229a0b 100644
>--- a/drivers/devfreq/devfreq.c
>+++ b/drivers/devfreq/devfreq.c

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
