Return-Path: <SRS0=BqmF=7A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C8C433E0
	for <linux-pm@archiver.kernel.org>; Mon, 18 May 2020 20:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC8B20758
	for <linux-pm@archiver.kernel.org>; Mon, 18 May 2020 20:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcBP9jUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgERUTK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 18 May 2020 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgERUTK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 16:19:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0CCC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 13:19:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so13422105wru.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6qVk6ayqY8T1Ekhft7YbqZU4BR9r4bGUredEZpEoINo=;
        b=JcBP9jUMa5TMqO8GM00LKbCuQvHwdMfv2DRVUCOe+uIqe6MUrzzBmFeGVke4gO7yvm
         HB0kpK4Vuhq+YJ2WkOGo1AHe6h5OydWz8tHZRXkaqBdgtMNshMwKqKpuCSN5n4QC3GFk
         htMDvCgfb7wnye81E/oOIzKM92uHTuL24GL3dH19yhbGu7vG5lFYxx/COiHPdPoS/3GH
         PzFOzNynUdmhoQycNP4iZlqflNtcVRI+MrbmKL8c7E3qm+KDpX1UolR4eGvxOSC5Rhj2
         oa7McwruEEB5O1DwguHS8XCY30m9QZ406Xx8bxdAxnxZvs9RU7tzIpv3gYjUPI/Tzin1
         ZHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6qVk6ayqY8T1Ekhft7YbqZU4BR9r4bGUredEZpEoINo=;
        b=Ktw99G141pJNEpECmcut24jTts7ojpc680Ol0+WAkPpb1Loy4rMbyWH5fMUf5i+rnm
         NPnDb+0koYmLCdT+7LOeRqDIYRqIioRRNz90JFTMBBnizSbacy4rLuDCyMATEpQ9zBBD
         AW1OWx5nltBkCaD9q13uufNg+gkJjILRPCMzC1CdOLkWzlNJlY+ZzdXsTGvMc67jMdOh
         /1zBjPrrlixUkkAXjwm5FNWqzcX9BUjru5QKEe+ty049pf8iIGKCebJ7gDUSO8zCNWaC
         B0bBtsoZBcDN1GPICilLrn+lwIdaH2CKnsP+92PgcP9DBRt8X8pN0x17BqhIBuzELNlh
         teWQ==
X-Gm-Message-State: AOAM530USVNU6Hki84z2r5NYGYBUo1VcfK1nwF6iQPGiUiizY/PKCuTH
        MAvk/vS4jqp4RhMxu5p0jPOqKQ==
X-Google-Smtp-Source: ABdhPJxFMSFT+yihCcC9bZsR1gxs1WKUCVSZok/KCOstFVO4lDRbW4V4aM0WIZN3c0MQcpw6I4ATfA==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr20762580wrm.87.1589833148870;
        Mon, 18 May 2020 13:19:08 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id v131sm926727wmb.27.2020.05.18.13.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 13:19:08 -0700 (PDT)
Subject: Re: [RFC v2 PATCH 4/6] cpuidle: sysfs: Remove sysfs_switch and switch
 attributes
To:     Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
 <1588235987-12300-5-git-send-email-guohanjun@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c9d8ce67-ec31-258f-10d7-2aaac48365c4@linaro.org>
Date:   Mon, 18 May 2020 22:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588235987-12300-5-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/04/2020 10:39, Hanjun Guo wrote:
> Since the cpuidle governor can be switched via sysfs in default,
> remove sysfs_switch and cpuidle_switch_attrs.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
