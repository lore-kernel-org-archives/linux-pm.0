From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH] PM / devfreq: fix mem leak and missing check of return
 value in devfreq_add_device()
Date: Mon, 21 Jan 2019 10:22:08 +0900
Message-ID: <20190121012208epcms1p4a7d1132bcfb6cc86db294ae5c606aa8b@epcms1p4>
References: <20190119050256.22520-1-tiny.windzz@gmail.com>
        <CGME20190119050400epcas4p34ea32277236e72d4527176fd0e98bd72@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119050256.22520-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> 'devfreq' is malloced in devfreq_add_device() and should be freed in
> the error handling cases, otherwise it will cause memory leak.
> 
> devm_kzalloc() could fail, so insert a check of its return value. And
> if it fails, returns -ENOMEM.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Dear Yangtao,

Could you please make your patch without indentation style changes?


The label, "err_devfreq", would fit more if it's renamed "err_kzalloc".


Cheers,
MyungJoo.
