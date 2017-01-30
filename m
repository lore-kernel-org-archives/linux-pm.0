From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] PM / devfreq: Add suspend frequency support
Date: Mon, 30 Jan 2017 10:20:19 +0530
Message-ID: <CAOh2x=mwykUBLstKTmUooa4VSpXwaokHraDHHjqW_u9sDsDsnw@mail.gmail.com>
References: <CGME20161228120710epcas5p25597b14fdf1dce59f2bc185d0f5f5401@epcas5p2.samsung.com>
 <1482926828-19746-1-git-send-email-cw00.choi@samsung.com> <1482926828-19746-3-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34501 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdA3E4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2017 23:56:46 -0500
In-Reply-To: <1482926828-19746-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, hl@rock-chips.com, tjakobi@math.uni-bielefeld.de, chanwoo@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 28, 2016 at 5:37 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> +++ b/drivers/devfreq/devfreq.c
> @@ -620,6 +620,23 @@ struct devfreq *devfreq_add_device(struct device *dev,
>                 goto err_init;
>         }
>
> +       /*
> +        * Get the suspend frequency from OPP table. But the devfreq device
> +        * using passive governor don't need to get the suspend frequency
> +        * because the passive devfreq device depend on the parent devfreq
> +        * device.
> +        */
> +       devfreq->suspend_freq = 0L;
> +       if (strncmp(devfreq->governor_name, "passive", 7)) {
> +               struct dev_pm_opp *opp;
> +
> +               rcu_read_lock();
> +               opp = dev_pm_opp_get_suspend_opp(dev);
> +               if (opp)
> +                       devfreq->suspend_freq = dev_pm_opp_get_freq(opp);

The interface has changed a bit recently. Can you please use below
function instead ?

dev_pm_opp_get_suspend_opp_freq()
