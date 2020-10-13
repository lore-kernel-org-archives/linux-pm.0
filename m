Return-Path: <SRS0=fxtO=DU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B53C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 13 Oct 2020 17:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD5B25345
	for <linux-pm@archiver.kernel.org>; Tue, 13 Oct 2020 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602609486;
	bh=eNCCvcvQ6UE43iOdBhgi9kejO+Edb7whF1T1L/Tz5Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Khw0byc4KYa2SGje0hhPG/KbG/jP7L7Wl4fHlguKUdZueMFuH8lfIDyg3uz5NfUxe
	 AaS+vu9bL82phWilX/pncuS/OP/gjIChLU2ArNI0heveVxpOBq12ktpWrttKc4zGKD
	 vss9Vy9EaLJSY6yAyN5mrqGlG9iU9oDXmKczdshQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbgJMRSC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:18:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44955 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJMRSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 13:18:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id e20so701917otj.11;
        Tue, 13 Oct 2020 10:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oAgL+fcQX6cQENvM7HFJALQXy7xcg9RXhbSjkn/52oc=;
        b=K3xUrh9UjqCZyBu6uy15W+gfwOdMClcGwTT1Feeg+yySZ2safizJlQTqui4tMBjPaL
         3271uoMPV5AoAWvcGc0l+zZnDiO/gm2NCJtrP14qwgR8lcAPpYePMK4QlUaiuKa+5vEd
         M2RyQb4wei8UafOjCvJ6eY4tTuL3xGOtFJ81RM8eXRoOrL+XhPTrE1DEk3soEhZlujPD
         NB8vhsGBRIpfK09ss0JiEqgDiSiyailbfWBjJab0EW2OoEtB2N45Y670z8bUmdN/A97y
         G+GUmEQIs/WBwR07cUODwOZfQeZ46nM3xNboeKhQwqx51BsyKYcZoGBW7a5ptWrrmBMf
         Fyew==
X-Gm-Message-State: AOAM5332AW0BDOEx8ylKaXhloLsrKFC68t7tKwyxk9UXpg5YqMOVR9RT
        4e+qqHSfvXo0XNuvp9mtDA==
X-Google-Smtp-Source: ABdhPJy0lSY/ZeGDaAyNk/JablfzwCtpz61hQiNytpGKyQe7S2fFAdaHIgwB9f2d3TlCWsjbvbnXRg==
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr517796otd.258.1602609481531;
        Tue, 13 Oct 2020 10:18:01 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w64sm135656oig.31.2020.10.13.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 10:18:00 -0700 (PDT)
Received: (nullmailer pid 3719465 invoked by uid 1000);
        Tue, 13 Oct 2020 17:18:00 -0000
Date:   Tue, 13 Oct 2020 12:18:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to
 YAML bindings
Message-ID: <20201013171800.GA3716411@bogus>
References: <20201012155012.28938-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012155012.28938-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 09:20:12PM +0530, Manivannan Sadhasivam wrote:
> Convert Qualcomm cpufreq devicetree binding to YAML.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Removed qcom,freq-domain property which doesn't belong to this binding

It needs to be defined *somewhere*. As I said before, you need a 
separate schema for it.

> 
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 ---------------
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 204 ++++++++++++++++++
>  2 files changed, 204 insertions(+), 172 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
