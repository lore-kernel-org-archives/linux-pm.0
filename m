Return-Path: <SRS0=4Bgw=74=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F45C433E1
	for <linux-pm@archiver.kernel.org>; Mon, 15 Jun 2020 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB03207DA
	for <linux-pm@archiver.kernel.org>; Mon, 15 Jun 2020 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592237950;
	bh=De1ygWfVC04QCSTpGYUm/kRvjgyR4IWcEhnOKIuZGzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M3c75roPSMjwB7qRTzrHnV6RcK9FDPXXP4bPXaIjdymWOuJGLS/cMniHEdxpQ3ENw
	 nmqtCSpY0wU+es5El3UI66KOxBSNrOusqsliNhdV7ZMwMTVY76OxuLvd2nWIos/Ny7
	 hv3brggjmBxY4grhwRzE2VyyoqnmK+4r/juYIIBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgFOQTJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:19:09 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35021 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbgFOQTI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 12:19:08 -0400
Received: by mail-il1-f193.google.com with SMTP id l6so15893165ilo.2;
        Mon, 15 Jun 2020 09:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPfOOEL5DDndxKqYhH4//hh/kNNX+nOa7IzprjkujnA=;
        b=cRmJu8cy9BSQ8vMTfFKkplQJ7m8wYIdBCxA8NFgquV3RERIwVs4HbnRuv2k3lAxvgW
         M7pq3H/45CadZEKohN84B30aObT+CtS7HBnGnhBS24B9xpEwgAAzCyXfwSR6NbVeJD1I
         TzDvacdfRhf5UDlR9PTTh9rEoV3pD+cibRpKJMcM3m7zMU9OYSharzpgmX4op3D6rljJ
         Gg+9V2O9p2AYNJ9921zsNT9xXd2wcJa6SrXftCk0N3c6T1VAYEaStTCgurnS+Km4OG9W
         3iBEfoM1xWr0mZQJia6iOqwvgD+N+ny1wooEEgcPZWOGjawEo2oBUT3u2qnivdfTIgCv
         o21Q==
X-Gm-Message-State: AOAM533nRY/J81nUfMsLyu8X0Zjl0rC56tnOASEMrNYn4/EchO/YrY5O
        EBYyrLyV4zKspub3kxk+qA==
X-Google-Smtp-Source: ABdhPJwBNTN8gYyShvFlByTQFx7N5htyq6qg0xw5IUoPCulOgSRZVKo6/Bey6il0ASqfKtWzFGQctA==
X-Received: by 2002:a92:4948:: with SMTP id w69mr24962411ila.15.1592237947412;
        Mon, 15 Jun 2020 09:19:07 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p5sm8136663ilg.88.2020.06.15.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:19:06 -0700 (PDT)
Received: (nullmailer pid 1882654 invoked by uid 1000);
        Mon, 15 Jun 2020 16:19:04 -0000
Date:   Mon, 15 Jun 2020 10:19:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V5] dt-bindings: thermal: Convert qoriq to json-schema
Message-ID: <20200615161904.GA1882367@bogus>
References: <1591234216-14927-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591234216-14927-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 04 Jun 2020 09:30:16 +0800, Anson Huang wrote:
> Convert the qoriq thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V4:
> 	- add "additionalProperties: false"
> ---
>  .../devicetree/bindings/thermal/qoriq-thermal.txt  |  71 -------------
>  .../devicetree/bindings/thermal/qoriq-thermal.yaml | 114 +++++++++++++++++++++
>  2 files changed, 114 insertions(+), 71 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> 

Applied, thanks!
