From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / ACPI: Removed unused function
Date: Tue, 10 Oct 2017 18:55:12 +0200
Message-ID: <3567036.iJx6k4I4BV@aspire.rjw.lan>
References: <1507273714-26394-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57894 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932268AbdJJREl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 13:04:41 -0400
In-Reply-To: <1507273714-26394-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>

On Friday, October 6, 2017 9:08:34 AM CEST Ulf Hansson wrote:
> acpi_dev_pm_get_node() isn't used or implemented, let's remove it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/acpi.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 502af53..3b89b4f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -868,17 +868,12 @@ int acpi_dev_runtime_suspend(struct device *dev);
>  int acpi_dev_runtime_resume(struct device *dev);
>  int acpi_subsys_runtime_suspend(struct device *dev);
>  int acpi_subsys_runtime_resume(struct device *dev);
> -struct acpi_device *acpi_dev_pm_get_node(struct device *dev);
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
>  #else
>  static inline int acpi_dev_runtime_suspend(struct device *dev) { return 0; }
>  static inline int acpi_dev_runtime_resume(struct device *dev) { return 0; }
>  static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
>  static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
> -static inline struct acpi_device *acpi_dev_pm_get_node(struct device *dev)
> -{
> -	return NULL;
> -}
>  static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
>  	return -ENODEV;
> 

Applied, thanks!
