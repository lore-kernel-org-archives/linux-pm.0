From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v5] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
Date: Thu, 5 Jul 2018 09:13:02 +0900
Message-ID: <CAGTfZH315DM0r4qxZ28rW=0SpWOJHjFoBij0=c8-OTG5BxeLAQ@mail.gmail.com>
References: <20180704084550.7565-1-enric.balletbo@collabora.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180704084550.7565-1-enric.balletbo@collabora.com>
Sender: stable-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Enric,

2018-07-04 17:45 GMT+09:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> When the devfreq driver and the governor driver are built as modules,
> the call to devfreq_add_device() or governor_store() fails because the
> governor driver is not loaded at the time the devfreq driver loads. The
> devfreq driver has a build dependency on the governor but also should
> have a runtime dependency. We need to make sure that the governor driver
> is loaded before the devfreq driver.
>
> This patch fixes this bug by adding a try_then_request_governor()
> function. First tries to find the governor, and then, if it is not found,
> it requests the module and tries again.
>
> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v5:
> - Requested by MyungJoo and Chanwoo.
>   - Fix returning without the lock acquired after request_module.
> - Requested by Chanwoo.
>   - In request governor function check if governor name is NULL or not.
>   - Remove some unrelated changes (added/removed some blank lines).
>
> Changes in v4:
> - Kept "locked" devfreq_list from the return of find_devfreq_governor() to
>   the unlock of governor_store(). Requested by MyungJoo Ham.
>
> Changes in v3:
> - Remove unneded change in dev_err message.
> - Fix err returned value in case to not find the governor.
>
> Changes in v2:
> - Add a new function to request the module and call that function from
>   devfreq_add_device and governor_store.
>
>  drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0b5b3abe054e..aa92fbf9f0dd 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c

(snip)

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi
