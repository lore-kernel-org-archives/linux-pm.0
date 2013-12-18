From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH 2/2] charger-manager : Support deivce tree in charger
 manager driver
Date: Wed, 18 Dec 2013 08:56:39 +0530
Message-ID: <CAKDJKT658j+1DMEZnrADzZt=+uPbT4G8cs9AntXq491=Y5X8dw@mail.gmail.com>
References: <1387332853-5923-1-git-send-email-jonghwa3.lee@samsung.com>
	<1387332853-5923-3-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63867 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab3LRD0k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 22:26:40 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so7872496pbc.33
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2013 19:26:39 -0800 (PST)
In-Reply-To: <1387332853-5923-3-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, myungjoo.ham@samsung.com, cw00.choi@samsung.com

Hi

> +static inline struct charger_desc *cm_get_drv_data(struct platform_device *pdev)
> +{
> +#ifdef CONFIG_OF
> +       if (pdev->dev.of_node)
> +               return of_cm_parse_desc(&pdev->dev);
> +#endif
> +       return (struct charger_desc *)dev_get_platdata(&pdev->dev);
> +}

Can you make use of IS_ENABLED(CONFIG_OF) to get rid of #ifdef?

Thanks
Manish Badarkhe
