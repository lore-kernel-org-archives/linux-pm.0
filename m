Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26712C433EF
	for <linux-pm@archiver.kernel.org>; Fri, 27 May 2022 03:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiE0Dyv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 May 2022 23:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiE0Dyq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 23:54:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4200EE27A8
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 20:54:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j6so3302308pfe.13
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 20:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q+7+AE7kVM1YjRtXKhEfeh4yej0Si8mQXZu38lNU+Gk=;
        b=qcJ8aFpQawJ96ZtaMBPv2UWImIDaUB+bc9IHlMD92X47hXMaqW0Djf8o/Hib4jQcyD
         oyHmh+LWMi5m9G9f5fM9sZ+rzmCfTzPEakPuOLTryqralYCBFqYTW57BoZOGReAcWPlg
         GMksKVafzw14mzRGxM9SdSjfZx6U7b5gBG4ej4HaYmg4Ue76cdoQN+wEjVzx7ravx2rK
         HDnb+fYOsqqy/rmePY1pZ4dtJZQIrqmLTL+RsTfU6dJ7DjKV8/0cvwIjCLJ65Pm0iaMt
         LMznMQO+aD4dlabINsLCEiWJGeftXCXQFZHZpR/JGHg/5afHR/MIDL9FnZoMUnUu+m3I
         5+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q+7+AE7kVM1YjRtXKhEfeh4yej0Si8mQXZu38lNU+Gk=;
        b=LoIJXV6gdD+xIcqL5gDbHCNAvQ12pwGc+hJYWRZQ197TpaebhgrWiLsm2hrJXG2pFA
         FxjnJYOtSRA7QasHYt+Urtip6Zd+HukLE/JyIP1Uzn5LrM6bxjyeZpRn/uNyArnYpatN
         MgAR8U43OMxCoFxYREnWSye90Q3PcGblTuq12XTo1iLTSxNFlEKOswETNcUYdZzfyt05
         jRLNmzY0/mGzz6crPy4Kw7BSL7hO6hp5HfYJUbX7qC72lb8Jb1TH5Z5E56GxYLB366mH
         iyx2Rbjq+JmBI3iD8sQcx+3f/iYn1QfLusPLe83jgf2/z0Jy+nW3JWXs8xpsbizvX0d6
         gLGQ==
X-Gm-Message-State: AOAM532/bQZk38UtuBpIUbST29rL+hR19ul4VNLcXw8WvVQlSPm1BvIz
        WxIpRo8GnFhWnAwkVovnMFL4bZ+K1w9bEQ==
X-Google-Smtp-Source: ABdhPJzDwwi4BYL5Ncjkp5B/bzUdoxkj7z3ZIco97p1UZHy6ZWDavGGS59i2CIWg/jqcgH+7ND/ZJQ==
X-Received: by 2002:a63:9752:0:b0:3c6:5a7a:5bd6 with SMTP id d18-20020a639752000000b003c65a7a5bd6mr36017565pgo.390.1653623684752;
        Thu, 26 May 2022 20:54:44 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id r22-20020a635d16000000b003db580384d6sm2272281pgb.60.2022.05.26.20.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 20:54:44 -0700 (PDT)
Date:   Fri, 27 May 2022 09:24:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, lkp@lists.01.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [cpufreq]  a6cb305191: kernel_BUG_at_drivers/cpufreq/cpufreq.c
Message-ID: <20220527035442.su7hridojtvik5x7@vireshk-i7>
References: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
 <20220527031320.GA10419@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527031320.GA10419@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-05-22, 11:13, kernel test robot wrote:
> [ 10.349308][ T200] cpufreq_online (drivers/cpufreq/cpufreq.c:1562) 
> [ 10.349314][ T200] cpufreq_add_dev (drivers/cpufreq/cpufreq.c:1578) 
> [ 10.349318][ T200] subsys_interface_register (drivers/base/bus.c:1036) 

Thanks. I have updated the patch now to fix this.

-- 
viresh
