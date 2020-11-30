Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E3AC64E7B
	for <linux-pm@archiver.kernel.org>; Mon, 30 Nov 2020 01:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B4420757
	for <linux-pm@archiver.kernel.org>; Mon, 30 Nov 2020 01:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwNrl0Yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgK3Bln (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 29 Nov 2020 20:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgK3Bln (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2020 20:41:43 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E728C0613D3
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2020 17:41:03 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a16so18217554ejj.5
        for <linux-pm@vger.kernel.org>; Sun, 29 Nov 2020 17:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YNYyQoH11Uy49BqvFcvhTDHG+XYaaGyowBqhzVBSUAY=;
        b=WwNrl0Ybr20BSwcEyIynEsdNTjjydkiaOOK+8xaxlNamiVtWQDFg4dSjd7crFvEsFa
         0hUWJGsxkcsFjLP18+Kcky7cgJGqLjlr/e1HCFaCSXVnMX3gNDW8vDsvNNbpM8YXCB6P
         eKBamIGx4Oi7tF70nS13vGryycE4zosApoI4ZLqtutxVBbGt+1t4q5zfjkQrJWlTF86Q
         e7PbXx5U6mpoMEl1gbMbd0o7wo8juA3U4/yO1goCXLEyaEan2jY+uYjt0tEaMwMSRuwo
         S8NGrNH+N/A5k8yAKdnmicNWjDMCtR4/HbVPVQzcNmniBbtYNs9AagYYNd9f+F9Pgk1l
         wQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YNYyQoH11Uy49BqvFcvhTDHG+XYaaGyowBqhzVBSUAY=;
        b=nb8jGoF8ewkM4sd8JSVGF2F6Dqx5HE9nZD3Idct+l1SSVK9uUMpIf5nEPrO24juBSY
         WKZx8mUfllRgzezv3kGPe4N7WAsk796Or2kXwyW67qCAFv/mW2/H8CiJlByGUDvAqJRW
         FP6abAmKMBpNR/0X/9a8Nn91ag6fUPT2Ak1D3sedOnjtCsMNwYX4Kxnb+HtiTPVk7rkB
         qRxuHm/m+qEJADr0lpQSjjid4RZ/SvUchqMNIHDs1EEY0GTGLE3wqr1Vgs1RS4v7p/Fl
         ZcRDG1stNe4DaJqBqLYWtTGhP9hX3upyziXDFWh94wXYQLJOUANaWtMZuDaffD9Aku0D
         FWGg==
X-Gm-Message-State: AOAM532x6GKhEJjapxpQ7ejZi8Wa+ZUGERsV4b2csFzpS1cjz6H3veUC
        +s616E3n+lDjSgy2x4sSf81rV3totAN/k8K8ey0LAQ==
X-Google-Smtp-Source: ABdhPJyI8iq9Qcoh9z+BgQGsOaQVWGtfyNzvOoKL5oqxj8FOxSgc4pj2PZ1+KU9i112A2dmNHWlk9d0rgvij/Qc7bQE=
X-Received: by 2002:a17:907:3f93:: with SMTP id hr19mr18726449ejc.235.1606700461879;
 Sun, 29 Nov 2020 17:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20200930081645.3434-1-jun.nie@linaro.org> <43318c75-cfe2-d219-2ea4-7a130ea5883b@linaro.org>
In-Reply-To: <43318c75-cfe2-d219-2ea4-7a130ea5883b@linaro.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Mon, 30 Nov 2020 09:40:50 +0800
Message-ID: <CABymUCOjh0BEwaZsFO6YzbMskeNnhPCDLAOhzU8Civ_3JM0yrw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Consolidate RPM interconnect and support to MSM8939
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Georgi Djakov <georgi.djakov@linaro.org> =E4=BA=8E2020=E5=B9=B411=E6=9C=882=
6=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:20=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 9/30/20 11:16, Jun Nie wrote:
> > This patch set split shared RPM based interconnect operation code and a=
dd
> > support to MSM8939 interconnect.
> >
>
> Hi Jun,
>
> Are you planning to refresh this patchset?

Yes. Just come back from a long vocation. Thanks for reminder!

Jun

>
> Thanks,
> Georgi
