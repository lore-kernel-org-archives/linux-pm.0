Return-Path: <SRS0=GSFJ=YR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424ACA9EB9
	for <linux-pm@archiver.kernel.org>; Thu, 24 Oct 2019 03:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF42521872
	for <linux-pm@archiver.kernel.org>; Thu, 24 Oct 2019 03:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XB1BmdDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437261AbfJXDLY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:11:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44948 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408284AbfJXDLX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 23:11:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so13313129pgd.11
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2019 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fj9Ud66oz8U5Yh/1XlnusXjEqU0kK7uCGc0WJQSBIGo=;
        b=XB1BmdDhK1Adc+3GLTBFyds8asDdFqNihkzaQZ3S0CZh7SQbidKgRG564fjDr8uB1/
         3JEh+cQDXM0ji4XKwLsOp7+ziNhy3LQ/wWgOXMAmXxD3StUN5n0NxQNmU3tkcWjIUW/D
         sZk6o0jRBTDpoc8BZzGwbsUIukB/3rOcsvMDwux6XxvJ3rMUeHCY83yiwEXq4h6/qC1B
         8qEHs1L9y7RLG/oQjUS7c63yT7OCWEhiJ+bsNmJ/skoOyzAWQYZz7fhF/OayF5lvePu4
         1HwdDBxqjxjPfBWGQX4NmKf2w2MRqmB7jRSCWSXQfiULKRfFjdOXEMe5Qz/lIjIqKSnY
         mknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fj9Ud66oz8U5Yh/1XlnusXjEqU0kK7uCGc0WJQSBIGo=;
        b=uTzEEtDYoW42oMm1dB9WQtanMRhUnHqagu0n3wkDrIt/O/ge66DPizibxEfxX3XHro
         cO/LFa0cKEgRIuvj4jBs+utOfvE+HBmTUIJpEUdKx4Lv7XG6ST/iuZMib4GuLQB7pVbF
         p+aRNc+8tj0iM6ps20nkAg0Vjr/p1xkFUR5tP5IqhUYVQxX/vqpTe+KQGGD90xjVihO0
         xQIfWunVBQ525JYzpl6x8qFLat96cN4JySxVxqbov+8a4FqiZgmNLA6fHkcTvEkTjBM9
         deg2F9MHawauso9Qwd80l70cOiul2c/gvIQHN3y8DHWHdA6bWbDYETHp4V6t0CbjasnF
         2+ig==
X-Gm-Message-State: APjAAAVTYzC4sxTPU/3bDNFtns/FQABgT8FqWtfrYQbv7IUduBzgiLu0
        QVF7ypV+7tg/r1ddaq9lUcNcS8vJkdE=
X-Google-Smtp-Source: APXvYqxmnp5RrvmPrhq+UllAh+A8a8Xg1WZP8AMCjdS1kF97/TLSGAp65Nm72oumNauPtPKePcXIZQ==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id z14mr4042999pjr.40.1571886681892;
        Wed, 23 Oct 2019 20:11:21 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id bx18sm600994pjb.26.2019.10.23.20.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:11:21 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:41:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: vexpress-spc: use macros instead of
 hardcoded values for cluster ids
Message-ID: <20191024031116.jwwwrc5hmy2knwmk@vireshk-i7>
References: <20191023110811.15086-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023110811.15086-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-19, 12:08, Sudeep Holla wrote:
> A15 and A7 cluster identifiers are fixed to 0 and 1 respectively. There are
> macros for the same and used in most of the places except this instance.
> 
> Lets use macros instead of hardcoded values for cluster ids even here.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied both. Thanks.

-- 
viresh
