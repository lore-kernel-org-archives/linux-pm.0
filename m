Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECEAC197A0
	for <linux-pm@archiver.kernel.org>; Thu, 16 Nov 2023 19:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjKPT17 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Nov 2023 14:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjKPT17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 14:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ACB18B;
        Thu, 16 Nov 2023 11:27:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D571BC433C7;
        Thu, 16 Nov 2023 19:27:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
        id AF8EF10613A1; Thu, 16 Nov 2023 20:27:49 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     sre@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, Su Hui <suhui@nfschina.com>
Cc:     r-rivera-matos@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20231116041822.1378758-1-suhui@nfschina.com>
References: <20231116041822.1378758-1-suhui@nfschina.com>
Subject: Re: [PATCH] power: supply: bq256xx: fix some problem in
 bq256xx_hw_init
Message-Id: <170016286968.830118.5959829920078266260.b4-ty@collabora.com>
Date:   Thu, 16 Nov 2023 20:27:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 16 Nov 2023 12:18:23 +0800, Su Hui wrote:
> smatch complains that there is a buffer overflow and clang complains
> 'ret' is never read.
> 
> Smatch error:
> drivers/power/supply/bq256xx_charger.c:1578 bq256xx_hw_init() error:
> buffer overflow 'bq256xx_watchdog_time' 4 <= 4
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq256xx: fix some problem in bq256xx_hw_init
      commit: b55d073e6501dc6077edaa945a6dad8ac5c8bbab

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

