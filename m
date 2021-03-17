Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C77C433E9
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 17:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDC264E89
	for <linux-pm@archiver.kernel.org>; Wed, 17 Mar 2021 17:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhCQRCZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhCQRB6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Mar 2021 13:01:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EC1261580;
        Wed, 17 Mar 2021 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616000516;
        bh=D5aIjqmiOUYZl13Ajhpo46UMf5Qv0uThh2gxXrypg4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/lDAbTusNU8/I+ESum6PU/pLylMXRA05sso9tvoSpj1oxQJoR/zW6Z7R9EY6LtZM
         Uvs7O3FjhBy7+kZlykyWDkSjt9lhcIJG7FB7uPyOyrR+8pnMLifCANcdqFYxvAQUkj
         +Md3iz/vtf0Br6kdNrHT4wgX5R1YODHy9VFpeFcozXQBGLje1b1L/rWFrDnMyRYM1T
         eyJ6h945OWso43VtenJ6HM+SAiWSPHzCjwbfvsckHXvDqxfwL+4UkeU9zQ6hqCN4lM
         a2cELM02A/BBXBWOea+SHy1ZFOq720LpJHIilBACsEc44YUQDoxrxbwuEFPT+BOPGf
         HynHOUtcm93bQ==
Received: by pali.im (Postfix)
        id 900E18A9; Wed, 17 Mar 2021 18:01:52 +0100 (CET)
Date:   Wed, 17 Mar 2021 18:01:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv2 18/38] dt-bindings: power: supply: n900-battery:
 Convert to DT schema format
Message-ID: <20210317170152.dsg7s6kik5gyqd64@pali>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-19-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210317134904.80737-19-sebastian.reichel@collabora.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 17 March 2021 14:48:44 Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> Cc: Pali Rohár <pali@kernel.org>

Rejected-by: Pali Rohár <pali@kernel.org>

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Hello Sebastian! I'm really really sorry, I have nothing against you,
but personally I cannot ack change signed by company where some people
are supporting censorship, GPL violations and other similar immoral
activities against other individual developers.

> ---
>  .../power/supply/nokia,n900-battery.yaml      | 49 +++++++++++++++++++
>  .../bindings/power/supply/rx51-battery.txt    | 25 ----------
>  2 files changed, 49 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/rx51-battery.txt
