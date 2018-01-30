From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] arm: imx: Add MODULE_ALIAS for cpufreq
Date: Tue, 30 Jan 2018 20:50:08 +0530
Message-ID: <20180130152008.GE13395@vireshk-i7>
References: <20180130095526.9478-1-kwizart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39447 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeA3PUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jan 2018 10:20:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id e11so9287263pff.6
        for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2018 07:20:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180130095526.9478-1-kwizart@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Chauvet <kwizart@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 30-01-18, 10:55, Nicolas Chauvet wrote:
> Without this, the imx6q-cpufreq driver isn't loaded
> automatically when built as a module
> 
> Tested on wandboard quad with a fedora 27 kernel rpm
> 
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index d9b2c2de49c4..cef3d46fd642 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -473,6 +473,7 @@ static struct platform_driver imx6q_cpufreq_platdrv = {
>  };
>  module_platform_driver(imx6q_cpufreq_platdrv);
>  
> +MODULE_ALIAS("platform:imx6q-cpufreq");
>  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
>  MODULE_DESCRIPTION("Freescale i.MX6Q cpufreq driver");
>  MODULE_LICENSE("GPL");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
