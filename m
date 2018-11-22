From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/6] devfreq: add basic fileds supporting suspend
 functionality
Date: Thu, 22 Nov 2018 11:37:29 +0900
Message-ID: <5BF61669.9030800@samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180201eucas1p1f1f96941c3d16a96722e65d5c21bfe80@eucas1p1.samsung.com>
        <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1542823301-23563-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> The patch prepares devfreq device for handling suspend/resume functionality.
> The new fields will store needed information during this process.
> Devfreq framework handles opp-suspend DT entry and there is no need of
> modyfications in the drivers code.
> 
> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
> solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch address them keeping in mind suggestions
> from Chanwoo Choi.

You already explain the patch history on cover letter. It is enough.
Please remove the duplicate history description from all patches except for cover letter.

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 3 +++
>  include/linux/devfreq.h   | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 1414130..e20e7e4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -657,6 +657,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  	devfreq->max_freq = devfreq->scaling_max_freq;
>  
> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> +	atomic_set(&devfreq->suspend_count, 0);
> +
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index e4963b0..7fe96f9 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -167,6 +167,10 @@ struct devfreq {
>  	unsigned long scaling_max_freq;
>  	bool stop_polling;
>  
> +	unsigned long suspend_freq;
> +	unsigned long resume_freq;
> +	atomic_t suspend_count;
> +
>  	/* information for device frequency transition */
>  	unsigned int total_trans;
>  	unsigned int *trans_table;
> 

You don't need to make the separate patch for this. You can squash patch1
into patch3 because the newly added variables are used on patch3.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
