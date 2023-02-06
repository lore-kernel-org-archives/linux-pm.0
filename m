Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A5CC6379F
	for <linux-pm@archiver.kernel.org>; Mon,  6 Feb 2023 08:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBFIJY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 6 Feb 2023 03:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFIJX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 03:09:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445665A6;
        Mon,  6 Feb 2023 00:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2756460C7C;
        Mon,  6 Feb 2023 08:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7556AC433D2;
        Mon,  6 Feb 2023 08:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675670961;
        bh=7To9ndX5DYRSorrgvB+E9BrgmwiQP7ZmPzgErIA/JBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOJtPm65eUnxYkUD5jLv1uB5b/01sUtZzEarQIEi7aGVKwKW5sVJzFx4gA5+Fcti5
         XnJxEGioz4FgaUudU65hpYsgK3r7nmxeshNS+cPH/NqSy9rEJ0BYaNxN8L9tiv7Qhq
         NyyGeHEdTmj0eZcGJh56PD0t8qEtnMq1rvYHs6E0DSgABHxx2jCy8Pm1evruHzLAxU
         KPFRyXJfysD4ylCP41hK2gswWzUNFFu5hhVQSiJ7pQkzuLSiFZVGuCQpt6BsYyePD5
         5/NSMzktrd9WAHwEE+57F/JK0rA7sGck2aKAP5Wot9u5ZDTOjQ8SU8Y/f3DRW6qz1d
         uXK6K+1CQK4CQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pOwZS-0003cC-Sy; Mon, 06 Feb 2023 09:09:50 +0100
Date:   Mon, 6 Feb 2023 09:09:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Alexandre Bailon <abailon@baylibre.com>
Subject: Re: [PATCH 04/23] interconnect: imx: fix registration race
Message-ID: <Y+C1zpn3PvRc+6uf@hovoldconsulting.com>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-5-johan+linaro@kernel.org>
 <20230203170121.187108bd@booty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203170121.187108bd@booty>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 03, 2023 at 05:01:21PM +0100, Luca Ceresoli wrote:
> Hello Johan,
> 
> On Wed,  1 Feb 2023 11:15:40 +0100
> Johan Hovold <johan+linaro@kernel.org> wrote:
> 
> > The current interconnect provider registration interface is inherently
> > racy as nodes are not added until the after adding the provider. This
> > can specifically cause racing DT lookups to fail.
> > 
> > Switch to using the new API where the provider is not registered until
> > after it has been fully initialised.
> > 
> > Fixes: f0d8048525d7 ("interconnect: Add imx core driver")
> > Cc: stable@vger.kernel.org      # 5.8
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Georgi pointed me to this series after I reported a bug yesterday [0],
> that I found on iMX8MP. So I ran some tests with my original, failing
> tree, minus one patch with my debugging code to hunt for the bug, plus
> patches 1-4 of this series.
> 
> The original code was failing approx 5~10% of the times. With your 4
> patches applied it ran 139 times with zero errors, which looks great! I
> won't be able to do more testing until next Monday to be extra sure.

Thanks for testing.

It indeed looks like you're hitting the same race, and as the imx
interconnect driver also initialises the provider data num_nodes count
before adding the nodes it results in that NULL-deref (where the qcom
driver failed a bit more gracefully).

Johan

> [0]
> https://lore.kernel.org/linux-arm-kernel/20230202175525.3dba79a7@booty/T/#u
