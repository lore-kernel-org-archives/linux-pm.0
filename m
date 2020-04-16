Return-Path: <SRS0=eR+e=6A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE68C2BA2B
	for <linux-pm@archiver.kernel.org>; Thu, 16 Apr 2020 20:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A496B21841
	for <linux-pm@archiver.kernel.org>; Thu, 16 Apr 2020 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587069881;
	bh=ynGbnIT4pnntI9B7fjPXuZHS5SYvmW7+1GP3SGVuzhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S0qTDBnReaBpjH+i67Cl5l0yDGCUSMK+p9wZqfSFHNed54e5+zI/otbrMt7zL1cQP
	 7aJtXMieyjrLqCaCw1ZKzM6NZv5Zqi2TCnqFEOXqmKFJVTQpeWTtes2nVGdBsiPjv9
	 kJKfSlyW+ux9xR5fh4uOT3qJcktLPi45jES6ywDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgDPUoi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:44:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34064 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgDPUoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 16:44:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id m2so4288967otr.1;
        Thu, 16 Apr 2020 13:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yi9rW2hcrQI044TTGmD3SpdpVrHiwZ/VfGa5oOsnsdc=;
        b=sD3m2A8XsM7Tz+ZZbhIrPHqXMON8ivPHtOqdUCdM2BK0XkwzOnONHgNrCMPnKX3mtU
         kRmbszRqXjgPa2TXlnhVAJSl75XZIaDkKdZRSyDK+4DFAtl1qma1ZEEps/k2NmxttoVZ
         BWkk/BwXC+6z6j4bYSaW3/V6IObojGwkCnf1F4KHRZyuxcFLCsys7ZcuxdK6AbaVI2ol
         a3OmMtOmNV0W5c4pPKcSJ2olB2mz8qPc2dEHJ82Q4igBcLT8t+4eaW4jFBaELTTsAGlW
         n3zZXafYp6OH8mg/OX+y+05jGTouiaChfSeNxYqJafdrfgj96dffnoOSEYP817mJwFDT
         XyqQ==
X-Gm-Message-State: AGi0PuZbd860IvVV4OoGjeVpaYJQ4r4jdl90hgy7AqAYuNW2WtA/i6gl
        qoLZhS3CY8liIg4TDqtRDA==
X-Google-Smtp-Source: APiQypKBpcF29A5Z99HB1PtYwR19nLnL23EQjtQJ5e8lRTqcPV6Fqo+5Okfb2v7AK3cAEowNirm0dw==
X-Received: by 2002:a9d:75ce:: with SMTP id c14mr10356otl.64.1587069876593;
        Thu, 16 Apr 2020 13:44:36 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q3sm161210oom.12.2020.04.16.13.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:44:36 -0700 (PDT)
Received: (nullmailer pid 17673 invoked by uid 1000);
        Thu, 16 Apr 2020 20:44:34 -0000
Date:   Thu, 16 Apr 2020 15:44:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Re: [PATCH v9 1/6] dt-bindings: mfd: add document bindings for mp2629
Message-ID: <20200416204434.GA17165@bogus>
References: <20200415162030.16414-1-sravanhome@gmail.com>
 <20200415162030.16414-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415162030.16414-2-sravanhome@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Apr 2020 18:20:25 +0200, Saravanan Sekar wrote:
> Add device tree binding information for mp2629 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/mfd/mps,mp2629.example.dts:19.22-32.11: Warning (unit_address_vs_reg): /example-0/i2c@7e205000: node has a unit name, but no reg or ranges property

See https://patchwork.ozlabs.org/patch/1271317

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
