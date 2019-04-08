Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E9C10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 22:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CC9213F2
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 22:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6F3c3yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfDHWiW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:38:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39950 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDHWiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 18:38:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so8144115plr.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2019 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FfXCNxGjgip9tM/24J4x9HgXgQeH+eXUxsfXR19pBSo=;
        b=I6F3c3ytswQ2No1wfT9BwkH3vkabdrpJcUJ0D+X/pKLNaOCVbJuebSFNRj7cJ/a6KY
         zEPKjzFf/TqyZzQyubdQ0PpkKz1RsmL0kVycfyzx+1ovcvSeam8Eug0aMyu5uvd2e+n/
         APe1+RzO76LnBoWHcTiglOc9BK7fasU8ALOk+Bnl24dS3KL94DMngoJZdQ+SPRz93Eh9
         worpOkyLZcfpmHHToStEVo2EsCQG6K2wj8oJZNUGgHry/8C0vBHizi5KuKg5vqs7BRhh
         leDeM7XlwMbXAh/Sd0elxDag1PLKxXezjtU4ohTfCQ7Jdt6bBRQdnvCwXKyPaJ0x2Yd8
         g7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfXCNxGjgip9tM/24J4x9HgXgQeH+eXUxsfXR19pBSo=;
        b=Q4gRdgD05jnf+2i8gczH3vxVuwaqfjWx8gukRmwJFPOktUd0eCU0zE+J3pKsj7Shs5
         VQkpYh7if9KgFLj5gNu3aQcR+TTAQKSWUs2/dqjUTZQ2sxczLIHnohIF26FbWk/eqgyT
         vMCzGlk0C9PTVaQ4bF3eD2s2o50q4QxpvXQky/7AB7FCe8zA1/FeqyRHQ1hZJKfM47O9
         bGZYRTE7JgdhjVuVydUEJNoIfJCxGTPDBQN9AobUkZAqxkZJKZHsFQorsDeqluWmzMum
         4MxXJnWFNnyBig/vE9x4S/7xsw7D8SegtS7zkWXYCx/AqXfInOqFw/MAO7ISZbFio/fY
         u6Ow==
X-Gm-Message-State: APjAAAWhWxLXYJ9MPP4oB2sMroocVhbhazE0jwdz552yHhlKqyr2JBT6
        wcrj5WtBezIm7+jL00jole/n/A==
X-Google-Smtp-Source: APXvYqyB09EAnp/9MaAYN3lufSGL1bahGfdNMb6d9BPZ6LXfhvrFMOl2X8idIwXTbK4AEPQrCaabnQ==
X-Received: by 2002:a17:902:7441:: with SMTP id e1mr32220266plt.13.1554763101258;
        Mon, 08 Apr 2019 15:38:21 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v12sm41115361pfe.148.2019.04.08.15.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 15:38:20 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:38:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
Message-ID: <20190408223817.GS1843@tuxbook-pro>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-2-georgi.djakov@linaro.org>
 <20190405143254.GM1843@tuxbook-pro>
 <9ee2c9b2-f201-abfb-be60-180befa9dc6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <9ee2c9b2-f201-abfb-be60-180befa9dc6d@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190408223817.Qt7laDiW8ovPK8HcmuvecAxXQhtVzrKfiVErRXttSqQ@z>

On Fri 05 Apr 08:46 PDT 2019, Georgi Djakov wrote:

> Hi Bjorn,
> 
> On 4/5/19 21:32, Bjorn Andersson wrote:
> > On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
> > 
> >> The Qualcomm QCS404 platform has several buses that could be controlled
> >> and tuned according to the bandwidth demand.
> >>
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>  .../bindings/interconnect/qcom,qcs404.txt     | 45 +++++++++++++++++++
> >>  1 file changed, 45 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> >> new file mode 100644
> >> index 000000000000..2ea63ea827d7
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> >> @@ -0,0 +1,45 @@
> >> +Qualcomm QCS404 Network-On-Chip interconnect driver binding
> >> +-----------------------------------------------------------
> >> +
> >> +Required properties :
> >> +- compatible : shall contain only one of the following:
> >> +			"qcom,qcs404-bimc"
> > 
> > As this is a hardware block available in mmio register space I think you
> > better represent this on the mmio (soc) bus - and then represent the
> > link to rpm as a child node of the rpm.
> 
> The mmio register space is not used for expressing bandwidth needs, but
> contains mostly QoS related stuff. We do not support QoS for now and
> that's why i haven't included it. When we decide to support QoS, we can
> add the nodes for the QoS registers and then reference them with some DT
> property like qcom,qos = <&bimc_qos>;
> 

The fact that QoS support is not implemented today is an implementation
detail, it does not relate to how we're describing the hardware in
DeviceTree. Adding three new nodes under soc{} and referencing these
(and potentially duplicating the clocks properties in the two sets of
nodes?) in the future, rather than just describing the hardware
appropriately today seems odd to me.

Further more, as I shared a while back the aggregation code related to
the RPM would better be shared between 404, 410, 820 and 835. So to me
it makes sense to even on the implementation side split this is NoC part
and RPM part, from the beginning.

Regards,
Bjorn

> Thanks,
> Georgi
> 
> > 
> > Apart from that this looks good.
> > 
> > Regards,
> > Bjorn
> > 
> >> +			"qcom,qcs404-pcnoc"
> >> +			"qcom,qcs404-snoc"
> >> +- #interconnect-cells : should contain 1
> >> +
> >> +Optional properties :
> >> +clocks : list of phandles and specifiers to all interconnect bus clocks
> >> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> >> +
> >> +Example:
> >> +
> >> +rpm-glink {
> >> +	...
> >> +	rpm_requests: glink-channel {
> >> +		...
> >> +		bimc: interconnect@0 {
> >> +			compatible = "qcom,qcs404-bimc";
> >> +			#interconnect-cells = <1>;
> >> +			clock-names = "bus_clk", "bus_a_clk";
> >> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> >> +				<&rpmcc RPM_SMD_BIMC_A_CLK>;
> >> +		};
> >> +
> >> +		pnoc: interconnect@1 {
> >> +			compatible = "qcom,qcs404-pcnoc";
> >> +			#interconnect-cells = <1>;
> >> +			clock-names = "bus_clk", "bus_a_clk";
> >> +			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> >> +				<&rpmcc RPM_SMD_PNOC_A_CLK>;
> >> +		};
> >> +
> >> +		snoc: interconnect@2 {
> >> +			compatible = "qcom,qcs404-snoc";
> >> +			#interconnect-cells = <1>;
> >> +			clock-names = "bus_clk", "bus_a_clk";
> >> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> >> +				<&rpmcc RPM_SMD_SNOC_A_CLK>;
> >> +		};
> >> +	};
> >> +};
