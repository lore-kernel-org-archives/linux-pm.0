Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D66C433FE
	for <linux-pm@archiver.kernel.org>; Tue,  8 Dec 2020 07:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA68023A69
	for <linux-pm@archiver.kernel.org>; Tue,  8 Dec 2020 07:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgLHHaZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 8 Dec 2020 02:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLHHaZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 02:30:25 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC56C0613D6
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 23:29:44 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e2so3070976pgi.5
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 23:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8h/OBn5YsQcazbH0YJ7H9JhJyr0LzcHAvsUeLZrYXoE=;
        b=T2KoDWfMFaB/av8cF5B2b6YMAcRuVuayrd/BdqYJmDPpYtuAKyMEU1A8+TujtnGIzC
         EaHKGHFRkF4oGVPxKfhhuqj4LET5hI81E07bSCr1VWNRFtGRZ1QV+r7dPUAo6zt5Cfx7
         qrU3eGjTcE9fR+Re1/Qw9S9OpwUPk9ykolygbkRTbq73HLtjNoXs3ViewCJbYDZv85SA
         sI8qJInQiX/fdndM/MQW7ORzzY6Bel4EUI0gyefHSbC7TqC3Nqt6zJLMbbhmbkHGm3Sk
         qCAqVR/9ikOCHJ2mQ5p7BHNkzt0ZAB+fiNQfFZw6jG0uMpIbP1KXbikOx+p4/JEA/Cht
         +Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8h/OBn5YsQcazbH0YJ7H9JhJyr0LzcHAvsUeLZrYXoE=;
        b=nEabzoWq9DgHohyCBSbdP+WcVVfQMxAM1+ISz15BEfOJ2l1zZLu0NrSVXWAFPVKEcL
         K3aLOI4FJfBH+eoL3CANOwf8EN+2vLDn3h8W9gFFQ8eWwswFz/WI8DZtCrIYOIRKWLGR
         qLd5EzFtWvFfMGtYPjLNLck4boQ92YMl17ab+C0KlPHWW8OgZLJhLNXRz4LIqYYKWkRT
         hu2gBfv+QaPhxzitIZHGBl9w7mEUtnOfq/ZoYYTnlnbG4ympqfV3dvjdR94PWcGYjHk3
         kX2UDuASwcpqaHvhXrr71Y3PpWikTkPaxQV260TcMGI8OXNfLFy//zWDviVJ1XL8aZlt
         PCrA==
X-Gm-Message-State: AOAM533Nz8/L2G214xcwhpubCEag4BtbnKWwctX4PS/xgZ2KAD/c5oT6
        G1v1F4uyF4C/XlOA7YJtH6Sax/EWj7acFg==
X-Google-Smtp-Source: ABdhPJwCFWtVmJZShx+XTTI521TezRb3o93j0vtSG0nISjwgARpJMC0+38h8keb+qMeJO407Qdo7ow==
X-Received: by 2002:a63:2253:: with SMTP id t19mr21823988pgm.400.1607412584477;
        Mon, 07 Dec 2020 23:29:44 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id d203sm442940pfd.148.2020.12.07.23.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 23:29:43 -0800 (PST)
Date:   Tue, 8 Dec 2020 12:59:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>
Cc:     tiny.windzz@gmail.com, rjw@rjwysocki.net, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@siol.net, samuel@sholland.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] cpufreq: sun50i: add efuse_xlate to get efuse
 version.
Message-ID: <20201208072941.7xbqbolo6mct6niz@vireshk-i7>
References: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Please use --thread=shallow while creating the patches, I use the following
options normally, so they appear as a thread.

git format-patch -C -M --thread=shallow

-- 
viresh
