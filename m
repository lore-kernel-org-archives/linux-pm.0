Return-Path: <SRS0=i/1K=BA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B838C433E6
	for <linux-pm@archiver.kernel.org>; Tue, 21 Jul 2020 08:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7809620B1F
	for <linux-pm@archiver.kernel.org>; Tue, 21 Jul 2020 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595319704;
	bh=oOcLkyJqyI0Ykt4xlygJfA6NInM/e+o6s5qh24mcjWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F6AW3VnjiPIoW/bIwRNO63GIB5QYmmX3KIn2Jw5vbftYjQ8jHOnrMJb41O+VTx/xI
	 OEw+uzpvvM1PGa4ZfxHd3FIxE3V6PJ1mRugRUF1mCpy+69auwCfnZv0pA6rre4N3lQ
	 GP7DhztgPO/M9YR/GV+wm886KLMr0jGq86na6D3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgGUIVo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUIVn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 04:21:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA7E20714;
        Tue, 21 Jul 2020 08:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595319703;
        bh=oOcLkyJqyI0Ykt4xlygJfA6NInM/e+o6s5qh24mcjWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWBjrkFJ4Binkd5tCLVDH5DGFt99Bfcdo3NZWtLDAv79FO/Xoxd7BZrOubU7BJXl5
         OEpbGmfnhZTXHHtM8xq7DLiavuOkM15NU6waayY86DDxMmTD7CTYeHXMdYPmGqY14j
         59Y1Vf0Uq5Rr/O4ZOn1bJltK1Vihoy42qyaqw0pg=
Date:   Tue, 21 Jul 2020 10:21:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v5 0/4] add some power supply properties about
 wireless/wired charging
Message-ID: <20200721082152.GF1655283@kroah.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595301250.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 01:59:33PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> This patchset aims to provide power supply properties about wireless/wired charging.
> "quick_charge_type" reports different types of quick charge based on the charging power;
> "tx_adapter" shows" the type of wireless charging adapter;
> "signal_strength" shows the coupling level between TX and RX;
> "reverse_chg_mode" provides the interface of enabling/disabling wireless reverse charging.
> 
> Changes in v5
>  - Add details in 0/X email

Thanks for all of the changes, looks much better.

I've reviewed the individual patches.

thanks,

greg k-h
