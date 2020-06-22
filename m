Return-Path: <SRS0=EC3c=AD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1249C433DF
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jun 2020 13:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EFD20706
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jun 2020 13:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgFVN73 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:59:29 -0400
Received: from comms.puri.sm ([159.203.221.185]:55288 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgFVN73 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jun 2020 09:59:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 5067EE0318;
        Mon, 22 Jun 2020 06:59:28 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pf4VA7pwlJcG; Mon, 22 Jun 2020 06:59:27 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     leonard.crestez@nxp.com
Cc:     Anson.Huang@nxp.com, a.swigon@partner.samsung.com,
        abailon@baylibre.com, abel.vesa@nxp.com, aisheng.dong@nxp.com,
        angus@akkea.ca, cw00.choi@samsung.com, devicetree@vger.kernel.org,
        fabio.estevam@nxp.com, georgi.djakov@linaro.org,
        kernel@pengutronix.de, krzk@kernel.org, kyungmin.park@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-pm@vger.kernel.org, mark.rutland@arm.com,
        martink@posteo.de, mka@chromium.org, mturquette@baylibre.com,
        myungjoo.ham@samsung.com, ping.bai@nxp.com, rjw@rjwysocki.net,
        robh@kernel.org, saravanak@google.com, sboyd@kernel.org,
        shawnguo@kernel.org, viresh.kumar@linaro.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v4 0/6] PM / devfreq: Add dynamic scaling for imx8m ddr controller
Date:   Mon, 22 Jun 2020 15:58:58 +0200
Message-Id: <20200622135858.15891-1-martin.kepplinger@puri.sm>
In-Reply-To: <cover.1573252696.git.leonard.crestez@nxp.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi Leondard,

before using this patchset I'd like to ask: Do you have plans to create
an update and push this forward? It is useful.

thanks a lot,

                               martin
