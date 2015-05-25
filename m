From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq:cpufreq-nforce2 - Fix typo in comment to
 function nforce2_init().
Date: Mon, 25 May 2015 12:50:39 +0530
Message-ID: <20150525072039.GA9992@linux>
References: <1432357578-4069-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33728 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbEYHUn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 03:20:43 -0400
Received: by padbw4 with SMTP id bw4so65643750pad.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 00:20:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432357578-4069-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 23-05-15, 10:36, Shailendra Verma wrote:

Always mention something here on why this is required. Even if the
subject is good enough :)

> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-nforce2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> index a225809..db69eeb 100644
> --- a/drivers/cpufreq/cpufreq-nforce2.c
> +++ b/drivers/cpufreq/cpufreq-nforce2.c
> @@ -414,7 +414,7 @@ static int nforce2_detect_chipset(void)
>   * nforce2_init - initializes the nForce2 CPUFreq driver
>   *
>   * Initializes the nForce2 FSB support. Returns -ENODEV on unsupported
> - * devices, -EINVAL on problems during initiatization, and zero on
> + * devices, -EINVAL on problems during initialization, and zero on
>   * success.
>   */
>  static int __init nforce2_init(void)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
