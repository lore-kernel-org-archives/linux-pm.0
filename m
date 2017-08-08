From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH] devfreq: add error check for sscanf in userspace
 governor
Date: Tue, 08 Aug 2017 00:14:43 +0000
Message-ID: <20170808001443epcms1p53655025662e843eab56aca33554b09df@epcms1p5>
References: <1502111205-22560-2-git-send-email-gsantosh@codeaurora.org>
        <1502111205-22560-1-git-send-email-gsantosh@codeaurora.org>
        <CGME20170807130735epcas5p4386af2ade3bd98b67fc5a9c956152c7d@epcms1p5>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502111205-22560-2-git-send-email-gsantosh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gsantosh@qti.qualcomm.com" <gsantosh@qti.qualcomm.com>, "gsantosh@codeaurora.org" <gsantosh@codeaurora.org>, "skannan@quicinc.com" <skannan@quicinc.com>, "rgottimu@qti.qualcomm.com" <rgottimu@qti.qualcomm.com>
List-Id: linux-pm@vger.kernel.org

> store_freq function of devfreq userspace governor
> executes further, even if error is returned from sscanf,
> this will result in setting up wrong frequency value.
> 
> Add proper error check to bail out if any error is returned.
> 
> Signed-off-by: Santosh Mardi <gsantosh@codeaurora.org>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/devfreq/governor_userspace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
