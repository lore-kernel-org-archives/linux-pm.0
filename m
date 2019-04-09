Return-Path: <SRS0=kGmN=SL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72540C10F0E
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 04:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D31120855
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 04:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sO5pLgPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDIESD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:18:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44212 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfDIESD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Apr 2019 00:18:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so8886453pfm.11
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2019 21:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NsRDe5i2lOT8pKyMQrxZsWMKN4kbmpCVFrK+4XP8UPI=;
        b=sO5pLgPUrZ43X2ZBBGpatwKO916q/pWHQAyJPCEmt7Qvn2P0N8jbzY7YVAaGPIyKg4
         JT7ayHE5mhU+1FmM+0Q8hGsWLKIVzCb8LrF+Gvk5ltC2kbDem24xbWiv6eM/wAwcp+xs
         SmZ2Vzl4XcrDswXrhCqn30ttAU1AAkP0C6a7TNlKpsnDXsFiRZzxiOUorcbNEGQWSLsg
         VGbtKpnGLJ7sTeAwkm1EPP0oMHUlGHVZuiJTojCiJE9++aHmOcH7ouEUVARfXGcywtNz
         Xa62usMya28F6WVdT6G3M12VUClNVXN5BecGHdo+gRzfOuV+8oAg88tcLFTNgq0VZwCw
         GDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsRDe5i2lOT8pKyMQrxZsWMKN4kbmpCVFrK+4XP8UPI=;
        b=VLdbbF2ovbHtW1YYR6DDmrMMTzmIGhLcVjvd8bL3ndHl+CAYKM5n+xr+AksSMJ5xyD
         Ai34w55D0xvAj6ap3LADlYH1QGOfkBaR/fZ88ul3ZK1miCiW2OrMzJCN0WyVbwC0Mb/B
         0VIBmiDIuCNWC5jlpFias9JrasjP8EVtFNTITetf+jf2Gdd5CsNsctPzYClxTvzRoWeA
         3fNHDsznLj2iAoCgLLjAqertGSGZ06qQ78A3MfBSDZBQ4SEttVAjFG/wUHxVbiybwzar
         2E7QR0xEesA0Q6KyX4pEN2XTeh3FcTMSJ0czpNRAAjlYQW+5pvNjOz205OeeixptsIPQ
         euqw==
X-Gm-Message-State: APjAAAV0QyEMy3cfyp70AhuvUAewte+3zVmR/1cJaEMScrVpskn9rJCb
        R/CPEjuY4FUS3gBoiWJrPZmecA==
X-Google-Smtp-Source: APXvYqw03MlKaKs+NIJBcmpiNoli2WHZiVx+Gn+cR9x1BHSOXdTzD4jXChdtvY5gI9zKUiUKtGbdsg==
X-Received: by 2002:a63:1f61:: with SMTP id q33mr29973607pgm.325.1554783482613;
        Mon, 08 Apr 2019 21:18:02 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id v15sm45232586pff.105.2019.04.08.21.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 21:18:01 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:47:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Remove cpufreq_driver check in
 cpufreq_boost_supported()
Message-ID: <20190409041759.gyqax5owzhh7owlp@vireshk-i7>
References: <20190409022536.6164-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409022536.6164-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-04-19, 10:25, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently there are three calling paths for cpufreq_boost_supported() in
> all as below, we can see the cpufreq_driver null check is needless since
> it is already checked before.
> 
> <path1>
>   cpufreq_enable_boost_support()
>     |-> if (!cpufreq_driver)
>     |-> cpufreq_boost_supported()
> 
> <path2>
>   cpufreq_register_driver()
>     |-> if (!driver_data ...
>     |-> cpufreq_driver = driver_data
>     |-> cpufreq_boost_supported()
>     |-> remove_boost_sysfs_file()
>           |-> cpufreq_boost_supported()
> 
> <path3>
>   cpufreq_unregister_driver()
>     |-> if (!cpufreq_driver ...
>     |-> remove_boost_sysfs_file()
>           |-> cpufreq_boost_supported()
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e109227..d9123de 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2426,7 +2426,7 @@ int cpufreq_boost_trigger_state(int state)
>  
>  static bool cpufreq_boost_supported(void)
>  {
> -	return likely(cpufreq_driver) && cpufreq_driver->set_boost;
> +	return cpufreq_driver->set_boost;
>  }
>  
>  static int create_boost_sysfs_file(void)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
