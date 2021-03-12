Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02683C433E6
	for <linux-pm@archiver.kernel.org>; Fri, 12 Mar 2021 14:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3AC564FEE
	for <linux-pm@archiver.kernel.org>; Fri, 12 Mar 2021 14:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhCLOz2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:55:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbhCLOzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 09:55:10 -0500
Date:   Fri, 12 Mar 2021 15:55:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615560909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtrIBNzZjitdUwopViAjV+EBIosnDc42hL0LAlzBpMc=;
        b=Dtc1M0LL0zsr780sT+VW5tYhmvfPaWh0giY1RO9s6oaJilC9tBSzPNtkhtdQRrsbsuQggf
        oLTWG/zKkWe2EEmTr6Ea93EV0xHnqVHeMxqyPt+urReARMA9ZSHVh+zxPOTRiSHu9XsMdK
        0G7Cd3osgWwW6P9Ma1AuKwlz6+2fkDOnEerqAhchoeLagGSZ0bhTk8HY00kwCAwLhwIoc1
        iFZSKD9n/TephB+y6VwOnrjSAiHiOM/j40RAub+V32Q0iZk+ilOxsTogNzN9/YA/KKT8PG
        h/xzAm819rhMGL7n/mxq5hDxVVwHiXxiTQcNCzYAvsqKk0arHC0fQ3LrDIjoKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615560909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtrIBNzZjitdUwopViAjV+EBIosnDc42hL0LAlzBpMc=;
        b=ThquELCnrMTU/IxonX/gv2epUy/GEXBZupM/5gvQo0r60LKzUSoxOR9T0yTbY3sxaCKQ00
        OqH+RLFfz5hJw6AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Timon Baetz <timon.baetz@protonmail.com>, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sebastian.reichel@collabora.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] extcon: Provide *extcon_*_notifier_all() stubs for
 !CONFIG_EXTCON
Message-ID: <20210312145507.nssjwwi5qffffcpc@linutronix.de>
References: <20210312141051.blqkm2v2yx6psild@linutronix.de>
 <CAJKOXPeXQS2pZ-siZGP+E3y1Gus5_9-ByAetUD9Mk0UH+t0OYA@mail.gmail.com>
 <20210312145307.mkzkrbehqertfv3r@linutronix.de>
 <29f27256-e5ca-3bbe-4b73-afeac4ff23cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29f27256-e5ca-3bbe-4b73-afeac4ff23cf@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-03-12 15:53:53 [+0100], Krzysztof Kozlowski wrote:
> Yeah, it missed the merge window...

Could you please send it for -rc3?

> Best regards,
> Krzysztof

Sebastian
