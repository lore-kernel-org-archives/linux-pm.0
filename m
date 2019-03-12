From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v5] PM / devfreq: Restart previous governor if new
 governor fails to start
Date: Tue, 12 Mar 2019 16:17:14 +0900
Message-ID: <20190312071714epcms1p20e78a537f8cb0d7d04e4fd077916fd51@epcms1p2>
References: <20190311100630.12952-1-sibis@codeaurora.org>
        <CGME20190311100759epcas5p41fc634cd67a99b39cd25c4129e489c4c@epcms1p2>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311100630.12952-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Sibi Sankar <sibis@codeaurora.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm-owner@vger.kernel.org" <linux-arm-msm-owner@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

>From: Saravana Kannan <skannan@codeaurora.org>
>
>If the new governor fails to start, switch back to old governor so that the
>devfreq state is not left in some weird limbo.
>
>[Mjungjoo: assume fatal on revert failure and set df->governor to NULL]
>Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

I'll modify WARN->ERROR for the case when it's fatal:

>+		if (ret) {
>+			dev_warn(dev,
>+				 "%s: reverting to Governor %s failed (%d)\n",
>+				 __func__, df->governor_name, ret);
>+			df->governor = NULL;
>+		}

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


>---
>V5:
>* assume fatal on revert failure and set df->governor to NULL
>
>V4:
>* Removed prev_governor check.
>
>V3:
>* Fix NULL deref for real this time.
>* Addressed some style preferences.
>
>V2:
>* Fixed typo in commit text
>* Fixed potential NULL deref
>
> drivers/devfreq/devfreq.c | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)
>
