Return-Path: <SRS0=Jmv8=A3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48353C433E7
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 08:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8E7207F9
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594888281;
	bh=GzFI9I6+K4axw7cYstVenNEukmi1BijumC9HWik5Nfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VCjW9HUthA4MyOKErbiHV/rlIFFWvKA+PQGn8kGA9gXjC/BAtIp8QzmNF2nPSncX6
	 Xx+8LIGQVC9VkqY/waih7tKEjAbYcC1lNhot7KRDizPYOiJYlE0cF+CcVJv88DnyT4
	 gxdGi9m/eaLLb/I4hQj+Ju14oQStFlnKY3oVI1LQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGPIbU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgGPIbT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jul 2020 04:31:19 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED4E20771;
        Thu, 16 Jul 2020 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594888279;
        bh=GzFI9I6+K4axw7cYstVenNEukmi1BijumC9HWik5Nfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nssIDpoby9zjwgo2NHCCkUxkO0RftC4dVhWeH1CB87j44KdTcJSh/p1tMb92MZSvs
         Hvi6fiAAMeD15leFU8RYmO9qWsLyvl6cVGjCzXKGGkxag3Ov4braMP9TiCoz25Cr/f
         +syHFqNoXkdJ9xT+L3sPUtsYFfDX1T4LVQK7hR+0=
Received: by pali.im (Postfix)
        id C8D14E7A; Thu, 16 Jul 2020 10:31:16 +0200 (CEST)
Date:   Thu, 16 Jul 2020 10:31:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: fix duplicated words in bq2415x_charger.h
Message-ID: <20200716083116.oqio4clyotjqy5vw@pali>
References: <74a380ee-d0a7-a58b-5740-6f1049d05d76@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74a380ee-d0a7-a58b-5740-6f1049d05d76@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 15 July 2020 18:30:01 Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled word "for".
> Change "It it" to "If it".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org

Thanks!

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  include/linux/power/bq2415x_charger.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200714.orig/include/linux/power/bq2415x_charger.h
> +++ linux-next-20200714/include/linux/power/bq2415x_charger.h
> @@ -14,8 +14,8 @@
>   * value is -1 then default chip value (specified in datasheet) will be
>   * used.
>   *
> - * Value resistor_sense is needed for for configuring charge and
> - * termination current. It it is less or equal to zero, configuring charge
> + * Value resistor_sense is needed for configuring charge and
> + * termination current. If it is less or equal to zero, configuring charge
>   * and termination current will not be possible.
>   *
>   * For automode support is needed to provide name of power supply device
> 
