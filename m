Return-Path: <SRS0=B09i=UY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4175DC48BD6
	for <linux-pm@archiver.kernel.org>; Tue, 25 Jun 2019 23:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6DB208CA
	for <linux-pm@archiver.kernel.org>; Tue, 25 Jun 2019 23:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561503891;
	bh=/g5HbSN9aaM8rtS5Vxw7Oi3HXqq2y+sys910VJXMYIs=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=tz52g9f9YDPdg61Efn3ySy6f1IK88yNa3V5pkQyoNWii4S75KUwk/mtQTBPydu19o
	 AOm7/KXLkYiIJe643Acyiwi185BSzNO9aK5Fv40zWgylwydLPjlLm8KB4LQKZUbqG3
	 g9LQBPuBcp6KuKNz//rd8KGjPVK0mbbFAekxw7Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFYXEu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYXEu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Jun 2019 19:04:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FED2084B;
        Tue, 25 Jun 2019 23:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561503889;
        bh=/g5HbSN9aaM8rtS5Vxw7Oi3HXqq2y+sys910VJXMYIs=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=Oe4iNaIAqWM7dHzwIe2027mjsOsNLY4VxAZsubn9VofLSQo5poGekJrJkW9PWHngq
         f/Z0T6YXJXw3BpGf0YsW8VnABhtuNjy6UTBV/h/v76jK1KLrGsVTSyxI3l3kL/d8c9
         lfSQSS9u1Euez/fS5fZ75Mrwpa+5mWQ9gItqSmwg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190612182500.4097-2-nsaenzjulienne@suse.de>
References: <20190612182500.4097-1-nsaenzjulienne@suse.de> <20190612182500.4097-2-nsaenzjulienne@suse.de>
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/7] clk: bcm2835: remove pllb
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        ptesarik@suse.com, linux-rpi-kernel@lists.infradead.org,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 16:04:48 -0700
Message-Id: <20190625230449.78FED2084B@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-12 11:24:53)
> Raspberry Pi's firmware controls this pll, we should use the firmware
> interface to access it.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

