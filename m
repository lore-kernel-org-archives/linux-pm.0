Return-Path: <SRS0=Z5dc=BM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A082C433DF
	for <linux-pm@archiver.kernel.org>; Sun,  2 Aug 2020 12:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B732075B
	for <linux-pm@archiver.kernel.org>; Sun,  2 Aug 2020 12:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHBMA1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 2 Aug 2020 08:00:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51402 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHBMA1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2020 08:00:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7601C1C0BDD; Sun,  2 Aug 2020 14:00:23 +0200 (CEST)
Date:   Sun, 2 Aug 2020 14:00:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jiangfei1@xiaomi.com, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v4 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200802120015.GA1289@bug>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595214246.git.huangqiwu@xiaomi.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 2020-07-20 13:47:14, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports the kind of quick charge type based on
> different adapter power.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                | 10 ++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 216d61a22f1e..dd3773dcf16a 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -708,3 +708,24 @@ Description:
>  
>  		Access: Read
>  		Valid values: 1-31
> +
> +What:		/sys/class/power_supply/<supply_name>/quick_charge_type
> +Date:		Jul 2020
> +Contact:	Fei Jiang <jiangfei1@xiaomi.com>
> +		Description:
> +		Reports the kind of quick charge type based on different adapter power.
> +		Different quick charge type represent different charging power.
> +		QUICK_CHARGE_NORMAL : Charging Power <= 10W
> +		QUICK_CHARGE_FAST : 10W < Charging Power <= 20W
> +		QUICK_CHARGE_FLASH : 20W < Charging Power <= 30W
> +		QUICK_CHARGE_TURBE : 30W < Charging Power <= 50W
> +		QUICK_CHARGE_SUPER : Charging Power > 50W
> +
> +		Access: Read-Only
> +		Valid values:
> +			0: QUICK_CHARGE_NORMAL,
> +			1: QUICK_CHARGE_FAST,
> +			2: QUICK_CHARGE_FLASH,
> +			3: QUICK_CHARGE_TURBE,
> +			4: QUICK_CHARGE_SUPER.

NAK.

Just expose value in watts or something... People are talking about > 100W charging, no
need to go with fast/turbe/super/hyper/nonsense.

BTW fast charge is already "well defined", and what you call Normal is usually fast charge.


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
