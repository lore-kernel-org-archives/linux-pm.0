Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D902C433E4
	for <linux-pm@archiver.kernel.org>; Mon, 22 Mar 2021 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED95D61994
	for <linux-pm@archiver.kernel.org>; Mon, 22 Mar 2021 12:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCVMSG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhCVMRl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 08:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9C526198E;
        Mon, 22 Mar 2021 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415460;
        bh=n7cl0zm8j+Q42WggUpdUE5fIaxSoD8Al61tzvpAizCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/4ui5R3Uh0xLcbsqD9rEdetFRrTMCNEIVWDq9N4O5e5De5oBHjSgOixflEkbxn9y
         g7zE2JBTD43dRajb4BCQ84lWzgYCItb2N2sfyKGfly6OehipTmj99XzkssM7XTgnAm
         1D8Cy8N8lbl46BHarA9XAhJ+gN7eaCr+aOxKG0gDyYQjkeHQw+ArhHlwLM8vMeToAr
         hs1YVAFeXtyjgPlXuPXBwFOhPERng9Ga5WmY+0tqGMIBZ6YQnBw/8yChJiSSI27ray
         IAsT/9U71SBErkRPErY4R+ugO+53iG5n8iGEXvNS0w7BtHZGgE36C8SxuWFhjYEqxv
         eUFOKzlUdkLig==
Date:   Mon, 22 Mar 2021 17:47:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8350: Add thermal zones and
 throttling support
Message-ID: <YFiK4HvTSMxhqJzA@vkoul-mobl.Dlink>
References: <20210322100420.125616-1-robert.foss@linaro.org>
 <20210322100420.125616-2-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322100420.125616-2-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-03-21, 11:04, Robert Foss wrote:
> sm8350 has 29 thermal sensors split across two tsens controllers. Add
> the thermal zones to expose them and wireup the cpus to throttle their
> frequencies on crossing passive temperature thresholds.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
