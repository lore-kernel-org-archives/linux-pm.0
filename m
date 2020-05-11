Return-Path: <SRS0=+SOU=6Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC0DC47255
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 11:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D662098B
	for <linux-pm@archiver.kernel.org>; Mon, 11 May 2020 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589196327;
	bh=23t0/WcS+2Mlv461sc+mk+6Tyg7VLqyFZMsaM2GNRP8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=aVnUelcP33lCaeLLYFD54I6DSP3L5n27FEP4jtWyOlnd5Bx//pOtKLl70+1uFfYI6
	 CtOjwHd8MMCRyy4TsCfEYmhjHrKeT7HAAJbFzODKyk+w5LCm12unKvss5DowPa34To
	 i+S/pRKsugQFtQL+3poaYbnDKZo52a/NBAQp+/sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgEKLZ0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 May 2020 07:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgEKLZ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 May 2020 07:25:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A3520722;
        Mon, 11 May 2020 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589196326;
        bh=23t0/WcS+2Mlv461sc+mk+6Tyg7VLqyFZMsaM2GNRP8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qgF3COVBhRMrAD+N2rt5A0nGnoRrFMvXWIoourMXjd9CjX4ozvuZNoZgDKsLWjLlR
         9jPCRhWD8iBui2HB561GKJ4NhQ8/KdalJZXV7nXd3/7UD7u6XUub9LB1yTvbIEOHGc
         dmmAJwrL2zemuMiG71Q/ZOqSdoYw8LWb3ElLrweo=
Date:   Mon, 11 May 2020 12:25:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     mazziesaccount@gmail.com,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     brendanhiggins@google.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sre@kernel.org
In-Reply-To: <20200509151519.GA7100@localhost.localdomain>
References: <20200509151519.GA7100@localhost.localdomain>
Subject: Re: [PATCH] lib: linear_ranges: Add missing MODULE_LICENSE()
Message-Id: <158919630590.8372.10685814849051811697.b4-ty@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 9 May 2020 18:15:19 +0300, Matti Vaittinen wrote:
> When linear_ranges is compiled as module we get warning
> about missing MODULE_LICENSE(). Fix it by adding
> MODULE_LICENSE("GPL") as is suggested by SPDX and EXPORTs.

Applied to

   local tree asoc/for-5.7

Thanks!

[1/1] lib: linear_ranges: Add missing MODULE_LICENSE()
      (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
