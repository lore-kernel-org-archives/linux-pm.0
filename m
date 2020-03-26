Return-Path: <SRS0=yWkS=5L=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D453C2D0E9
	for <linux-pm@archiver.kernel.org>; Thu, 26 Mar 2020 19:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D8C20848
	for <linux-pm@archiver.kernel.org>; Thu, 26 Mar 2020 19:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585250151;
	bh=tTH6qHjSEO3k8Z1qGwFZjVJqGwiShgwV4zNJ4H3UthQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iH9z2R0Rkd78m6tdsuS45g5cQNOimc5EGqRUcRdq5po1W/WozDQhUeXH10y3yUFxn
	 29Ka4x6D6yjUgkcJSNOeSBJYm7TMcDKmROK4i94N1c4trZL4ANg/W1zfQAs8h5x7v4
	 0P8+C35ddex0Tc9aV7ltB1pvZMEdRyqvPDCFnbgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZTPu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:15:50 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46981 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 15:15:50 -0400
Received: by mail-il1-f196.google.com with SMTP id e8so6467273ilc.13;
        Thu, 26 Mar 2020 12:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Olt13sdtE0D4LAs797wG3erKxjKOvDid+wOGLdWtI/Q=;
        b=EcH46TOfrUdkt6EPYEQ3QQQQUyJEOp65u1N7TmQooqSBnk10yLme+BGud+Naf1NK57
         QAISnLxmMk0qxw/vfcheZ7IZch1IKkexNjUuqUSTnQ2LPemCrLpNw/SXRB5oaC4R3oBJ
         ugq2Xq0DPglEju+32dYPFCglNH09hznvxF/DQtXaM1RMHZbuMQbsG7CO+Lz3uywNFKMZ
         G2HNtLSR41mJJ6lO/KqSZvyibEP2azX51Qcm3hyB20kyy3WCSCsOVF6k9v2Y1rAs0jbo
         uKKArPc8I8ECLO/QaqudES7m8V2eDpntHCJHaC0n2dmFrXfCrgoi6LRwfArUcj1HBipg
         qCgw==
X-Gm-Message-State: ANhLgQ2MtVOb7nC0nGSMfLTRdgdVOKRziPdAhhYwHc9NSJ6Ie6r1/z8a
        a0MZMCd1jxFPXbmsJQ/f82zg/Lk=
X-Google-Smtp-Source: ADFU+vt5XiMccSt51KtqStNQbL6xMBa8dlZTZsEXhIz9yvw00X/Uh9S7Hd3S//8uEYuiP17IMzmlNQ==
X-Received: by 2002:a92:dd0e:: with SMTP id n14mr10757476ilm.0.1585250149285;
        Thu, 26 Mar 2020 12:15:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s82sm1074423ili.87.2020.03.26.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:15:48 -0700 (PDT)
Received: (nullmailer pid 4026 invoked by uid 1000);
        Thu, 26 Mar 2020 19:15:47 -0000
Date:   Thu, 26 Mar 2020 13:15:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [PATCH v6 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
Message-ID: <20200326191547.GA3964@bogus>
References: <20200321125241.3072123-1-t.schramm@manjaro.org>
 <20200321125241.3072123-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321125241.3072123-3-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 21 Mar 2020 13:52:40 +0100, Tobias Schramm wrote:
> This patch adds the dts binding schema for the cw2015 fuel gauge.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/power/supply/cw2015_battery.yaml | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
