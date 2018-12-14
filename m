From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v4] PM / devfreq: Restart previous governor if new
 governor fails to start
Date: Fri, 14 Dec 2018 10:45:27 +0900
Message-ID: <20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479@epcms1p6>
References: <20181212135313.30268-1-sibis@codeaurora.org>
        <CGME20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07@epcms1p6>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212135313.30268-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm-owner@vger.kernel.org" <linux-arm-msm-owner@vger.kernel.org>, "skannan@codeaurora.org" <skannan@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

> From: Saravana Kannan <skannan@codeaurora.org>
> 
> If the new governor fails to start, switch back to old governor so that the
> devfreq state is not left in some weird limbo.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Hello,

In overall, the idea and the implementation looks good.

However, I have a question:

What if the following line fails?

+		df->governor->event_handler(df, DEVFREQ_GOV_START,
+					    NULL);

Don't we still need something to handle for such events?

Cheers,
MyungJoo
