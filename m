From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 10:38:17 +0900
Message-ID: <596EB809.7050605@samsung.com>
References: <CGME20170718214411epcas2p43fc1475c80245889737ba9e731497e38@epcas2p4.samsung.com>
        <20170718214339.7774-17-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170718214339.7774-17-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 2017년 07월 19일 06:42, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/devfreq/devfreq-event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 8648b32ebc89..d67242d87744 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -277,8 +277,8 @@ int devfreq_event_get_edev_count(struct device *dev)
>  						sizeof(u32));
>  	if (count < 0) {
>  		dev_err(dev,
> -			"failed to get the count of devfreq-event in %s node\n",
> -			dev->of_node->full_name);
> +			"failed to get the count of devfreq-event in %pOF node\n",
> +			dev->of_node);
>  		return count;
>  	}
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
