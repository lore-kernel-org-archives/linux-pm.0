Return-Path: <SRS0=thCJ=B3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B90C433DF
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 21:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A76C20786
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 21:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597698954;
	bh=bE1emfOgDLeyuxnhKKOzY7DvPbagkiLSm58foQVcWZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GqB9qCdq6v3SdsFKtHKcE1ebMB7+9M/MyxAfx9Qq4q+ThJcwAyzk8+L7MXudD14vE
	 zpaPcgtkrJcDGoD66WQy+Kq1iR7QsJfXfakJvkS2uUu6ZSwYOJ/3efvkJxYbqhhh9T
	 /VuNS8fa5PdyK2I5VVSEfvGN0rtc1OiFXp0y0bhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHQVPx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:15:53 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37675 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgHQVPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 17:15:52 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so15799364ilh.4;
        Mon, 17 Aug 2020 14:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FVHVqgDK18wCiMIWFAFS2oWc9xmAjXxcXA3+FK9nNqg=;
        b=hbwrLFKLu8PkjSDiw1tw3DvhtHQKDlPfM0g0JSKRlmMZnVXQT+SASM90a6nl6UD6bt
         BrU97+8/V2U9ZxRomuDOkC2kBnNHeV4StaKr/X9ofbNs/KfVXfQM9fw2Q4WlfzfJ3qAC
         /D8WYY2NcTuapb2LvWWpoDr+DrRwyuGKAo1GZomMAx1jzLSB04Y/ftr2iySPqa6Nwhj3
         a0Oiic+guGwnSEY0uE0rQrfpv2/9N0CHucmfu7ZN7cSIOdMdsx4TF0McOgBwYySl0Pya
         6V9hxfy+FAL6GjT0PZhqBTKFK4PJ3Wze9GAYHaJnkSgZ760UZzg6WCD1/S+hlrv/kD1p
         sw4Q==
X-Gm-Message-State: AOAM530T0vmyNbmrQm5I99OZC1jWTQK9YfOG1EQ9xqtPL1ellgF2HZEQ
        qTbsv7djEemrhVSJAyvtUOpcBzXEMw==
X-Google-Smtp-Source: ABdhPJyT+ETspoZ+AoJcb4qB3UbfE6FZK1nVSToHY8oi3rmD+NN5VW9TFKYU7aKcTndS4rxMZ0PydQ==
X-Received: by 2002:a05:6e02:e07:: with SMTP id a7mr14364922ilk.28.1597698951381;
        Mon, 17 Aug 2020 14:15:51 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id t88sm10687730ilk.26.2020.08.17.14.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:15:50 -0700 (PDT)
Received: (nullmailer pid 1575735 invoked by uid 1000);
        Mon, 17 Aug 2020 21:15:49 -0000
Date:   Mon, 17 Aug 2020 15:15:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        georgi.djakov@linaro.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v3 1/6] dt-bindings: interconnect: Add generic qcom
 bindings
Message-ID: <20200817211549.GA1575684@bogus>
References: <20200801033215.1440-1-mdtipton@codeaurora.org>
 <20200801033215.1440-2-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801033215.1440-2-mdtipton@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 31 Jul 2020 20:32:10 -0700, Mike Tipton wrote:
> Add generic qcom interconnect bindings that are common across platforms. In
> particular, these include QCOM_ICC_TAG_* macros that clients can use when
> calling icc_set_tag().
> 
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> ---
>  drivers/interconnect/qcom/icc-rpmh.h        | 18 ++------------
>  include/dt-bindings/interconnect/qcom,icc.h | 26 +++++++++++++++++++++
>  2 files changed, 28 insertions(+), 16 deletions(-)
>  create mode 100644 include/dt-bindings/interconnect/qcom,icc.h
> 

Acked-by: Rob Herring <robh@kernel.org>
