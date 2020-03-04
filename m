Return-Path: <SRS0=FCtK=4V=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF6C3F2CD
	for <linux-pm@archiver.kernel.org>; Wed,  4 Mar 2020 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3294721775
	for <linux-pm@archiver.kernel.org>; Wed,  4 Mar 2020 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583333281;
	bh=dCZS1p7lSMpLDS34qXZDJF5oRfPs/vKmX31bJrZT68s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dtk1T1K/g9ZMv1sFJd97LY4td8X9uh1Wnw6xqTpijCQA9WZxDj6kdRyvixyFOcKZL
	 0hMWkJCEtmOPfxseC6hgR+jWMIS7WufkVqJRX993PIhTTpOAabc6MoX9bPtNItgMfy
	 wsH3z0KV5dQ7HNVTwAb5NDtE+8yl623Kg2zpjHIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCDOsA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:48:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40606 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOsA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 09:48:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id j80so2312282oih.7;
        Wed, 04 Mar 2020 06:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTVi0CY1WYThcNH0JrXSu81YjmvaHeU7QQq5m/gXIKM=;
        b=B6hP+COhtvWmPxY5gY9uEjoc2Fth0BawPEQFtfryYb2HIi4bxzujR244QERiuyLj8Y
         ZnwkLXMfouWvKMAc15h90DnAv1mGsqeGSg2D0JaEER2fIHVoJzlwLQ9ll2BrV+Fb8cr8
         VtSd0sgEXe9H41nRyVVGuvu4+Tx21uD0strfVeLlgqQ1hYD3ffZzsxnxnYwe8BQUfBRV
         NE3nnpt+5ItZn4nuPyQ4fyaVnLDarApyZ32njdR2vNFIO3ecUk0mEhi5IoiH/QNdrI3p
         zDkag23Yt8rABJAV4dlHXSO4gKBd1ewCiYucLpQ2BDU398QYaLGJR6ekR2R0//wEW5Aq
         Ow5Q==
X-Gm-Message-State: ANhLgQ2vETDzJk0rHgM7UQ48szznECF/UO1D5rPs/cvpI56inYyHXo/Q
        P1Mm3gLzne2aeI+czuJvAurKE8g=
X-Google-Smtp-Source: ADFU+vutJMPeQAk58XIyXq44RtRjch3aZjhj5tMH/gdNf7NpGZqGIc4M4+aVGrQmnTlsNKVWGrSmyA==
X-Received: by 2002:a54:4085:: with SMTP id i5mr1991775oii.17.1583333279432;
        Wed, 04 Mar 2020 06:47:59 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q1sm1200434oij.18.2020.03.04.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:47:58 -0800 (PST)
Received: (nullmailer pid 31673 invoked by uid 1000);
        Wed, 04 Mar 2020 14:47:57 -0000
Date:   Wed, 4 Mar 2020 08:47:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: arm: Fix cpu compatibles in the
 hierarchical example for PSCI
Message-ID: <20200304144757.GA31548@bogus>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303150749.30566-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue,  3 Mar 2020 16:07:44 +0100, Ulf Hansson wrote:
> Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
