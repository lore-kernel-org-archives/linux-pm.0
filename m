Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B949CC282DD
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 06:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8708320880
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 06:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmOzrBN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfDHGQI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:16:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32954 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDHGQH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 02:16:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so6689522pgh.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Apr 2019 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CfvbGnjyK6QBz+f+ilqK6DelekKKtPChS3cXJ94sQ7k=;
        b=dmOzrBN3YULvEY0f4eCIYBRnInVqZzkclcfjxL0+6tjS0CzCI7wJS4nUXQ3bAojUbH
         yiUdPNEDcSZHn7CpQ9QHY3ZgQEX4UvZFXuOUPERrG0AmpxRLwLGa6RrHAjg3syepwk/7
         z2FvFKUWnesuGWLbsyuDtU52U8HMAyDm/dj7OFHb7SggGZrVLZ//HOocmTtjIvro3ugD
         CbPApvXZJQCVmcQtiVyDs0hK9/ya5AJ4ox+ORrGxSzVxFCyd7E4X1SLsGAJAYWIn5y0u
         z/K0AipwLjVcVhllloY/h6qwETGIEUFcFllb0xJf2NUjEUo3RaFAJR+MmU+Y+Tb5aaOJ
         uvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfvbGnjyK6QBz+f+ilqK6DelekKKtPChS3cXJ94sQ7k=;
        b=hY93D+TxlX3bcsvJbqVFuu8HtJsswnGROmfB1eLLzuNOwBIh5ARZaNDRae55yLC4Fk
         9J91aO6Lr40lTfAZcLFPPdke16r3yugvJWDZjHviCwYW3UZQzoVDL/zsn7cB8qNn0q9v
         NbHu5gFod1UVAB6Khgv9FXKu/9eIFk2S7Pz3pgCA6Afb1xe64A8Ck7LRee5qsmJndgKm
         GX2ppkg37hyOTvcNHtd7QRvmkuRk2lJtzZgmTCHJ3lBVvbCmKkcx80dNShqqACs5nqB1
         oVE93iXIAEmfW4usb7mBJzMEVa3iSezSoIEDfyesDY8aj74UW7obby4B2ss/txj8eERw
         4BOQ==
X-Gm-Message-State: APjAAAVoCBf8fEL4AL3toSft68VFf4TREHbMsf+rdbFTE2CjEyg/XCBv
        2oMx87avw49NJfgW6C04fyipYQ==
X-Google-Smtp-Source: APXvYqyGw1d2DrXrhALSJbebXmgwtFetA7DWxJPdBM5szRUq2LmSoUKxxERkEgGlWGLoRwUEr6Zw9g==
X-Received: by 2002:a62:474a:: with SMTP id u71mr27860107pfa.87.1554704167103;
        Sun, 07 Apr 2019 23:16:07 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id m2sm41859927pgr.74.2019.04.07.23.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 23:16:06 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:46:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 0/4] Documentation: PM: Assorted updates
Message-ID: <20190408061604.vezucnff4dp2tx7x@vireshk-i7>
References: <4546107.fVFrecLk33@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <4546107.fVFrecLk33@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190408061604.bEKEWn3tErRvIhiwMOOaCQ7NWkSaLre4AGuVz93SNLI@z>

On 04-04-19, 00:02, Rafael J. Wysocki wrote:
> Hi All,
> 
> There patches make some changes in the PM documentation:
> 
> - Add "references" sections to cpufreq-related documents (patch [1/4]).
> - Add SPDX license tags to multiple PM-related documents (patch [2/4]).
> - Unify copyright notices in PM-related documents (patch [3/4]).
> - Add an SPDX license tag and a copyright notice to the new
>   intel_epb doc (in linux-next only ATM).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
