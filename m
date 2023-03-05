Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF7AC6FA8E
	for <linux-pm@archiver.kernel.org>; Sun,  5 Mar 2023 10:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCEKsq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 5 Mar 2023 05:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCEKsp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 05:48:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D746901C;
        Sun,  5 Mar 2023 02:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEBA8B80A37;
        Sun,  5 Mar 2023 10:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42496C433D2;
        Sun,  5 Mar 2023 10:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678013321;
        bh=nhdJu4LQhooaSy4c5P+gyJoq12VArD88hHPCwr7yDLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLjHYoTPdV/vsKmeaJabIYL5hl70jNhzH/5uAemenyxR5yB0zRvGuAvRnYVnFe1/T
         kolS5MUPjmQ5R54RAeSkHgaE6NZOV6lMmKJXgE8782NHG1YckpavOp6kYcNRUyljYR
         M+JUBVRo0a8MVBiiiaj1pi6B/eQxALLqG5iiykVjBeYhVGoN4Lzq0QN3GegnmFoyP6
         phzDT86M9/oEMe/qGYmgf/IzHYxTC79zorCCcaCdO57hOJS++jmk6mr7qTQNc1qFkQ
         D5dB10ePX1ujQu/KKON60Pc5IpXVpSjWjcr8b15Hh/tqN6OuQASy/PvheFpC8xieKr
         JXTPUb/CYjv9g==
Date:   Sun, 5 Mar 2023 10:48:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 03/10] mfd: rt5033: Fix comments and style in includes
Message-ID: <20230305104835.GH2574592@google.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <606950da6f4b36f5a124ff13756c78644fc89804.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <606950da6f4b36f5a124ff13756c78644fc89804.1677620677.git.jahau@rocketmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 28 Feb 2023, Jakob Hauser wrote:

> Fix comments and remove some empty lines in rt5033-private.h. Align struct
> rt5033_charger in rt5033.h.
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  include/linux/mfd/rt5033-private.h | 17 +++++++----------
>  include/linux/mfd/rt5033.h         |  7 +++----
>  2 files changed, 10 insertions(+), 14 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
