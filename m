Return-Path: <SRS0=fmUR=CQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A4C43461
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 15:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA019217BA
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 15:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgIGPNy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:13:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47336 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbgIGPNq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Sep 2020 11:13:46 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kFII4-00Dcq2-Ff; Mon, 07 Sep 2020 16:38:40 +0200
Date:   Mon, 7 Sep 2020 16:38:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: armada-37xx: Add missing MODULE_DEVICE_TABLE
Message-ID: <20200907143840.GU3112546@lunn.ch>
References: <20200907132716.6379-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907132716.6379-1-pali@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 07, 2020 at 03:27:16PM +0200, Pali Rohár wrote:
> CONFIG_ARM_ARMADA_37XX_CPUFREQ is tristate option and therefore this
> cpufreq driver can be compiled as a module. This patch adds missing
> MODULE_DEVICE_TABLE which generates correct modalias for automatic
> loading of this cpufreq driver when is compiled as an external module.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 92ce45fb875d7 ("cpufreq: Add DVFS support for Armada 37xx")

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
