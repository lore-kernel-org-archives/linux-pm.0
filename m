Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5161EB64DA
	for <linux-pm@archiver.kernel.org>; Fri, 14 Jul 2023 07:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjGNH4P (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Jul 2023 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjGNHzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 03:55:39 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4BE23C2A;
        Fri, 14 Jul 2023 00:54:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0D3D280A8;
        Fri, 14 Jul 2023 07:52:47 +0000 (UTC)
Date:   Fri, 14 Jul 2023 10:52:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v2 15/18] soc: ti: Mover power-domain drivers to the
 genpd dir
Message-ID: <20230714075245.GE5194@atomide.com>
References: <20230711142220.751795-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711142220.751795-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [230711 14:22]:
> To simplify with maintenance let's move the ti power-domain drivers to the
> new genpd directory. Going forward, patches are intended to be managed
> through a separate git tree, according to MAINTAINERS.

Reviewed-by: Tony Lindgren <tony@atomide.com>
