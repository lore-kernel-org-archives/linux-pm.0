From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] PM / devfreq: Rewrite devfreq_update_status() to fix
 multiple bugs
Date: Mon, 03 Mar 2014 16:35:52 -0800
Message-ID: <53151FE8.70703@codeaurora.org>
References: <1393558737-24037-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1393558737-24037-1-git-send-email-skannan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 02/27/2014 07:38 PM, Saravana Kannan wrote:
> The current devfreq_update_status() has the following bugs:
> - If previous frequency doesn't have a valid level, it does an out of bounds
>    access into the trans_table and causes memory corruption.
> - When the new frequency doesn't have a valid level, the time spent in the
>    new frequency is counted towards the next valid frequency switch instead of
>    being ignored.
> - The time spent on the previous frequency is added to the new frequency's
>    stats instead of the previous frequency's stats.
>
> This patch fixes all of this.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---

MyungJoo/Kyungmin,

Can you please take a look and let me know if this looks ok? Any 
possibility of getting this into 3.14?

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
