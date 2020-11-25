Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD8FC64E7A
	for <linux-pm@archiver.kernel.org>; Wed, 25 Nov 2020 05:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216E6208C3
	for <linux-pm@archiver.kernel.org>; Wed, 25 Nov 2020 05:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Mykl1Et3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgKYFU1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 25 Nov 2020 00:20:27 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:55135 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgKYFU0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Nov 2020 00:20:26 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Cgq3D6M1Wz7N;
        Wed, 25 Nov 2020 06:20:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1606281625; bh=a/ABNGQZUY2RgGIR/vdmzx0XrmZnqiHNCtmC0MrjZFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mykl1Et3yQzfukUn5nqFNlj2BSJ0GA9Cwp1c/Gn1FL7jQA8dBCAXkwHhQGVAuVrfd
         4atSkIksYNABG3CAey/dUlq8ImlkZ9ovRO2raV/VXOxoGswEZ4vADra1+E7AMTUYOp
         cc49WhFBBH1feyzuEQt2FmsntdzMGHG0Lz79ykj+dvAGwoEnY8x78TLfEt40kW3Z/Y
         bM32L3blPi/yOJOjxdzK/Z155HrGpr/zcIT1GzRLgx/1UEAQxETbSLkPSxVaC0HzoT
         sRd5BHhX2EP/qrQAM1aaqUUnVN5ObDTCB+72/C7h6cW/vFSZS7HGxURQmpG5MNSKtf
         zMENKs9VgqFlQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 25 Nov 2020 06:20:20 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH] power: bq25890: Use the correct range for IILIM register
Message-ID: <20201125052020.GA13966@qmqm.qmqm.pl>
References: <1780852.554hdvx4Kp@pliszka>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1780852.554hdvx4Kp@pliszka>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 25, 2020 at 04:48:05AM +0100, Sebastian Krzyszkowiak wrote:
> I've checked bq25890, bq25892, bq25895 and bq25896 datasheets and
> they all define IILIM to be between 100mA-3.25A with 50mA steps.

That's what DS says, indeed. 

Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
