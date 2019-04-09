Return-Path: <SRS0=kGmN=SL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808B1C10F13
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 03:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AFB21874
	for <linux-pm@archiver.kernel.org>; Tue,  9 Apr 2019 03:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POYQ5Z9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDID1S (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:27:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42714 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfDID1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 23:27:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id w25so7383637pfi.9
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2019 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JBW7znSTK5u+NcnjHQQNoax3ZsvZZDyQhDwb7fk3Tos=;
        b=POYQ5Z9KTB/FEKN616wWh8UQafyl0K0tiwB+SHsQoS3rpFRKAB87EA/hQWbY6jHJL4
         gcsf2QYY/BcxsCinDPXeh7k4Cqiz89W1APG/DeRjCS0dTAIuXJYerEOfRk296VXwwSEv
         z0vS6ZwnBXg5ENk3OxIs4xrRvsldhiKmmMQpS51z40MsdZ/ZS1HpMeunm65Wv8s3d6JK
         mn+lv810uvg1k4/XAh6SsPs48b0Qs6DtHsf3k1dJs5wnUSW2yj5Q+ToUxvkDzezIEEJI
         nW+6gDGbEdbM8dJl/5hdXAqjynE6njZJ/KgQ36ZDwhFsA0oMuzNi4WlcuVe6Dq6P6FCU
         ObmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JBW7znSTK5u+NcnjHQQNoax3ZsvZZDyQhDwb7fk3Tos=;
        b=d9fDwbHfP+2L1n4rErZmPx7eeU/4Ula0ODKUpGb+ZwBQhshylhRUbY1S6t3BRH1ibs
         gaSrflbR8N5DPMOiiBUv2+BDFW12fARb2K7UY8FFnErMKkQEKzirlvA8p8acjqWAVs8n
         9jl1+2NbukLSZ4309nndlVBq3tOekKW4cNqrMO8/jbrgJdjOMSmgFRjLuA7Aj9m6qWEL
         xMuqKaUNTvMvi4dWpzz3N+AX6qLaPkPDOEIanMIyMu9W61C7Wvvo/aEmzkrQM6M00xM9
         Tba8EZqzuY6klSEOi/VNxmNTOUmu6FZyi1FvWHl94yAClCy2ea4JePbm1q1z2q5CNaxU
         e71Q==
X-Gm-Message-State: APjAAAVDS9ZKK6t3aiCEMioW8Ty7fjbmTFsut5FJuM8rg/FX3c4177On
        JHE9Q0PlnGtNKC+mmQDihNGV5A==
X-Google-Smtp-Source: APXvYqzT4jL1UR5d+ELDXfDkHyw+UKtIT4PksKbAb2d1pfCcmKLH65qT9RoZaNzfgPRckkVmdZ2zeA==
X-Received: by 2002:a62:1647:: with SMTP id 68mr33731518pfw.113.1554780437354;
        Mon, 08 Apr 2019 20:27:17 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w21sm42124197pfn.48.2019.04.08.20.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 20:27:16 -0700 (PDT)
Date:   Mon, 8 Apr 2019 20:27:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] interconnect: qcom: Add QCS404 interconnect provider
 driver
Message-ID: <20190409032714.GT1843@tuxbook-pro>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-3-georgi.djakov@linaro.org>
 <20190405145756.GN1843@tuxbook-pro>
 <0ca7862f-31ba-748a-945d-a925a40a16de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <0ca7862f-31ba-748a-945d-a925a40a16de@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190409032714.shRhsCKodK3gYkdPrxDnB_7_DWD3D8xHxpbDINxPBVc@z>

On Mon 08 Apr 07:33 PDT 2019, Georgi Djakov wrote:
> On 4/5/19 17:57, Bjorn Andersson wrote:
> > On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
> > [..]
[..]
> >> diff --git a/drivers/interconnect/qcom/qcs404_ids.h b/drivers/interconnect/qcom/qcs404_ids.h
> > 
> > You use these defines in the driver, so I think this file should be the
> > one in include/dt-bindings...
> 
> The ids in this header are in a single global namespace in order to
> build the internal topology and could be used for drivers that support
> only platform data (although not sure if there would be any).
> 

As you say these numbers could be used by drivers on non-DT enabled
platforms, but for that this include file should be in
include/linux/interconnect. That said, there are no such Qualcomm
platforms, so these numbers will only ever be used internally in the
qcs404.c provider, so it would be better to just define them in that
file - to remove the risk of confusion.

> > 
> > [..]
> >> diff --git a/include/dt-bindings/interconnect/qcom,qcs404.h b/include/dt-bindings/interconnect/qcom,qcs404.h
> > 
> 
> These header is using per NoC local ids and should be used on DT enabled
> platforms.
> 

I had missed that you implemented support for xlating NoC-specific ids,
so this makes sense now, nice. I presume we won't ever include files in
a way where these defines collide - so this looks good.

Regards,
Bjorn
