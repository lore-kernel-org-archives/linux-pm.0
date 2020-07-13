Return-Path: <SRS0=gH2j=AY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4841DC433DF
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jul 2020 15:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26927206F0
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jul 2020 15:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="xhQXZmL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgGMPfC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbgGMPfB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:35:01 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D1C061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:35:01 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id el4so5926712qvb.13
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dS/t0yiexaZCrqeV5/e3m7On60/CA6XnE/8+DugAd3o=;
        b=xhQXZmL6pVITnzChn/H4Xl7FN0rJWCuhMPQ2vGTPA/AIAUtsBpDMnNQwxyheYPKGk/
         B6+Y7DliDAxAiU2tZU4gzJ8giSUJRogsQGl3+pMMtNKAu6vzwh0jiB48C8x59kfmj6iT
         lLvnvrNpdDPbBqI1ZVoD16TSzIoIGIsGb2iXd3aQ4WfYYYsLsbnA/iTWCVv3lYTJ+4AG
         imFFHrVgTCnugO4wxWbKVSjpUcacpIhnVpeOj0iG6jgBeGLQ6vt4qUwEuBVdTMbUUlbH
         d9SRbMt8i2uPOkDyVLaau3Z3TDxsTBmKFbjNtY1ti7tuNpV+0GRUAn6JjAR3ILXPkuVo
         pDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dS/t0yiexaZCrqeV5/e3m7On60/CA6XnE/8+DugAd3o=;
        b=Hl8sxBAsCQVqrWtm9WFMKpMgaDJ7ph1eqwER+RM6fzxC0JtC94WKyGcjfqkbVR/qjJ
         nxJ7pxXAZHLkVGvpBf6bOE1JsufuDxd81L3oNvdcZTuUQqtNPNEDDpz0ONcr5ArHmItJ
         7h//DiIAcgleBqr6BvCmHnG5Y620GR+pXeZFfBeOor+jX7BmZyvuOrnYgeTcnttNYNE5
         RUKYPFUx1zEShA30N59CC89v0hKmMLXPSYguLnNm/4V95XYtP2FMCzVfin0NesbYPwQs
         ZZSQjbgyRAbXX3URRRgG8CT7vKpD4bm11RpBQUEB0+jL7gDXn2/Y6HafypB90vQz7O/7
         NwXA==
X-Gm-Message-State: AOAM533cfKzmeha1C9o0putFvRlKXt/31yv1M631NCSHQx/TsP+PZiNu
        moChz5U8aMoA48WVidQ4GLaXGjhX+m4=
X-Google-Smtp-Source: ABdhPJyBUaGS6buzVXPID50rG0JvO7x5+eFVDVsq9yIhY/8e/yNNVmJqXmePEKjoThhiDzsbBZ70GQ==
X-Received: by 2002:a05:6214:18f2:: with SMTP id ep18mr51647qvb.96.1594654497166;
        Mon, 13 Jul 2020 08:34:57 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 21sm19500226qkj.56.2020.07.13.08.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 08:34:56 -0700 (PDT)
Subject: Re: [RFC PATCH] interconnect: qcom: add functions to query addr/cmds
 for a path
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        kbuild test robot <lkp@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:INTERCONNECT API" <linux-pm@vger.kernel.org>
References: <20200701042528.12321-1-jonathan@marek.ca>
 <3063d037-a781-6327-ef88-37b626c552e1@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <9f0628df-26b2-6ec8-3868-b2f72f0c8918@marek.ca>
Date:   Mon, 13 Jul 2020 11:33:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3063d037-a781-6327-ef88-37b626c552e1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/13/20 11:24 AM, Georgi Djakov wrote:
> On 7/1/20 07:25, Jonathan Marek wrote:
>> The a6xx GMU can vote for ddr and cnoc bandwidth, but it needs to be able
>> to query the interconnect driver for bcm addresses and commands.
> 
> It's not very clear to me how the GMU firmware would be dealing with this? Does
> anyone have an idea whether the GMU makes any bandwidth decisions? Or is it just
> a static configuration and it just enables/disables a TCS?
> 

The GMU is able to vote for bandwidth, and presumably RPMh is 
aggregating those votes with the votes from the interconnect driver. We 
need to be able to fill out the "struct a6xx_hfi_msg_bw_table" in 
drivers/gpu/drm/msm/adreno/a6xx_hfi.h, which has a table of DDR 
bandwidth cmds which can be selected when changing the GPU frequency 
(the bw field in a6xx_hfi_gx_bw_perf_vote_cmd).

 From Jordan: "the GMU registers a bus vote directly with the hardware. 
It should handle aggregation for us."

> I think that we can query the address from the cmd-db, but we have to know the
> bcm names and the path. All the BCM/TCS information looks to be very low-level
> and implementation specific, so exposing it through an API is not very good,
> but hard-coding all this information is not good either.
> 
> Thanks,
> Georgi
> 
>>
>> I'm not sure what is the best way to go about implementing this, this is
>> what I came up with.
>>
>> I included a quick example of how this can be used by the a6xx driver to
>> fill out the GMU bw_table (two ddr bandwidth levels in this example, note
>> this would be using the frequency table in dts and not hardcoded values).
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 20 ++++-------
>>   drivers/interconnect/qcom/icc-rpmh.c  | 50 +++++++++++++++++++++++++++
>>   include/soc/qcom/icc.h                | 11 ++++++
>>   3 files changed, 68 insertions(+), 13 deletions(-)
