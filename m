Return-Path: <SRS0=xbvJ=TK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E0C04AB1
	for <linux-pm@archiver.kernel.org>; Fri, 10 May 2019 03:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7F62070D
	for <linux-pm@archiver.kernel.org>; Fri, 10 May 2019 03:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557458050;
	bh=Me/LxFKe1rQvXPzpBV6nH7nKus0qycnHR7nb6hzQVSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RbQaBnIjTQwJi9o8JTTuTYYYUgw5aePI06rakXdLczEJwAwHzCKMZYP8UCDK7LdIs
	 6XYLvpQjCkmKt+vqkFyePRWJhf90CJ8bogNq2Nc8nD35iaCi3Tm1OS+w3NHa02115x
	 FxrO2w11SrOs9WhbUtBjXZN4vM+ebyIC5JVlFTr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEJDOE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 May 2019 23:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEJDOE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 23:14:04 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C59217F5;
        Fri, 10 May 2019 03:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557458043;
        bh=Me/LxFKe1rQvXPzpBV6nH7nKus0qycnHR7nb6hzQVSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dfDKU6DLzbaj7nJsJ9YzxT/mogyhpy25UZrsVMgewkxqTKelApcrY/2w8iYkQlMi6
         cRMqg0MvtxcYqw4herffvnM4QUPG7KOGGUh3KP/7KGSD+8eKa4KD5hutdkO9LkL77c
         oifiMBGiknn5vEL571uoP0XctApqFVfe5wDKQCII=
Date:   Fri, 10 May 2019 11:13:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yuantian Tang <andy.tang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Subject: Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal zone node
Message-ID: <20190510031335.GD15856@dragon>
References: <20190423022507.34969-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423022507.34969-1-andy.tang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190510031336.0NVtHqKXV4iwLtXvWB6sldDj-Cq2p3w_ROZR5Z6BMfc@z>

On Tue, Apr 23, 2019 at 10:25:07AM +0800, Yuantian Tang wrote:
> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core cluster
> sensor is used to monitor the temperature of core and SoC platform is for
> platform. The current dts only support the first sensor.
> This patch adds the second sensor node to dts to enable it.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v6:
>         - add cooling device map to cpu0-7 in platform node.

@Daniel, are you fine with this version?

Shawn
