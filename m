From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq: add new attribute type
 cpufreq_freq_attr_wr_perm()
Date: Mon, 7 Nov 2016 10:03:48 +0530
Message-ID: <20161107043348.GA21030@vireshk-i7>
References: <20161104165536.20088-1-code@mmayer.net>
 <20161104165536.20088-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36132 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbcKGEl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Nov 2016 23:41:29 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so84822792pfz.3
        for <linux-pm@vger.kernel.org>; Sun, 06 Nov 2016 20:41:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161104165536.20088-2-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

On 04-11-16, 09:55, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> With the new attribute type, it is possible to create write-only
> CPUfreq attributes.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  include/linux/cpufreq.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 5fa55fc..ed09930 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -234,6 +234,10 @@ __ATTR(_name, _perm, show_##_name, NULL)
>  static struct freq_attr _name =			\
>  __ATTR(_name, 0644, show_##_name, store_##_name)
>  
> +#define cpufreq_freq_attr_wr_perm(_name, _perm)	\

shouldn't this be _wo_perm ?

Also, I wouldn't mind doing this in the second patch itself.

> +static struct freq_attr _name =			\
> +__ATTR(_name, _perm, NULL, store_##_name)
> +
>  struct global_attr {
>  	struct attribute attr;
>  	ssize_t (*show)(struct kobject *kobj,
> -- 
> 2.7.4

-- 
viresh
