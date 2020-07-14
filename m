Return-Path: <SRS0=bP2c=AZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37135C433E5
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DEC20890
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594712245;
	bh=WGqbEi++112wwV5KzytHV6vA+xPXhlyWXePXIMpJXJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QSQdg/T2rmqUtlkBoKv+JQvcpn2viYVqG3ewFt2GZIIWr7O15+cN6tSakSXjT1rjY
	 eaHZic9W1iWJ33r4u4JDni/RX+rDAfKYXC8HNrzNh4dlu02dtpt/KNtg86TmuU1mSA
	 HG3a4vYaKXJY2McktWp9WjazRo/9VtG6yyzz65lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgGNHhY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgGNHhY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 03:37:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9162084C;
        Tue, 14 Jul 2020 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594712244;
        bh=WGqbEi++112wwV5KzytHV6vA+xPXhlyWXePXIMpJXJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8rQ4fa/S6rD7U7hRiMrT6g76oSmOGWpLNJVof+Xk0JOz0f/ACN/laUdP9b+3uHox
         XkyniaSUD61Miv1zteDEZyUNkogC4kvHPosv7dYLKiLx1KvgsX3vG8Q/dWNOa28uvk
         CT64IGIdliw7pYO/X77Bjl35tJXyjy6So23uMdNM=
Date:   Tue, 14 Jul 2020 09:37:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ivan <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v2 2/5] power: supply: core: add wireless charger adapter
 type property
Message-ID: <20200714073722.GB689066@kroah.com>
References: <cover.1594612572.git.huangqiwu@xiaomi.com>
 <b20548fc825241c69878bfb05464b0e4f378f4ce.1594612572.git.huangqiwu@xiaomi.com>
 <20200713084200.GD215949@kroah.com>
 <CAPtXDt3kX0=MNXUjDfKr0EgmTxejctdoSoDWUY561gfT6CAr1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPtXDt3kX0=MNXUjDfKr0EgmTxejctdoSoDWUY561gfT6CAr1Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 03:34:04PM +0800, ivan wrote:
> same as before, we should add it

Please do.
