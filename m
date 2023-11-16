Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B1C2BB3F
	for <linux-pm@archiver.kernel.org>; Thu, 16 Nov 2023 00:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjKPAit (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Nov 2023 19:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjKPAit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 19:38:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3E194
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2023 16:38:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734C5C433C9;
        Thu, 16 Nov 2023 00:38:45 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
        id 1DC181062B68; Thu, 16 Nov 2023 01:38:42 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pm@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
In-Reply-To: <20231104154920.68585-1-marex@denx.de>
References: <20231104154920.68585-1-marex@denx.de>
Subject: Re: [PATCH] power: supply: bq27xxx: Stop and start delayed work in
 suspend and resume
Message-Id: <170009512210.785165.13242333866965392934.b4-ty@collabora.com>
Date:   Thu, 16 Nov 2023 01:38:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sat, 04 Nov 2023 16:49:06 +0100, Marek Vasut wrote:
> This driver uses delayed work to perform periodic battery state read out.
> This delayed work is not stopped across suspend and resume cycle. The
> read out can occur early in the resume cycle. In case of an I2C variant
> of this hardware, that read out triggers I2C transfer. That I2C transfer
> may happen while the I2C controller is still suspended, which produces a
> WARNING in the kernel log.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: Stop and start delayed work in suspend and resume
      commit: dfcb264a01a9199e8338a548731baf5bbe77ef19

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

