From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [RFC] PM / devfreq: Add support for alerts
Date: Thu, 31 May 2018 15:17:20 +0900
Message-ID: <20180531061720epcms1p31f5451bcf3150a7dddd33e1e415bb730@epcms1p3>
References: <1527745019-25155-1-git-send-email-akhilpo@codeaurora.org>
        <CGME20180531053717epcas5p48e0d962e2108d04529b4582a70cd7d5a@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527745019-25155-1-git-send-email-akhilpo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Akhil P Oommen <akhilpo@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mka@chromium.org" <mka@chromium.org>
Cc: "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Currently, DEVFREQ reevaluates the device state periodically and/or
> based on the OPP list changes. Private API has to be exposed to allow
> the device driver to alert/notify the governor to reevaluate when a new
> set of data is available. This makes the governor more coupled to a
> particular device driver. We can improve here by exposing a DEVFREQ API
> to allow the device drivers to send generic alerts to the governor.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
> ---
>  drivers/devfreq/devfreq.c  | 21 +++++++++++++++++++++
>  drivers/devfreq/governor.h |  1 +
>  include/linux/devfreq.h    |  5 +++++
>  3 files changed, 27 insertions(+)
> 

Hello Akhil,

It appears that this will have the same effect with
"[PATCH 08/11] PM / devfreq: Make update_devfreq() public" from Matthias Kaehlcke, doesn't it?


Cheers,
MyungJoo
