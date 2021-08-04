Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B9DC432BE
	for <linux-pm@archiver.kernel.org>; Wed,  4 Aug 2021 12:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26176109E
	for <linux-pm@archiver.kernel.org>; Wed,  4 Aug 2021 12:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbhHDMEU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Aug 2021 08:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237991AbhHDMET (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Aug 2021 08:04:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F25CC60F22;
        Wed,  4 Aug 2021 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628078646;
        bh=SA09EAAKTkUs1OqwmkOmft4MkR4GN2nXfPFNIrNpdXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPe4efqDC7Xbj/2Eg3fPcTh+8aRcYpWQ+9NYlQAZmiUgyRRgyYed31yEGisg8pr6r
         bpDY40rNZm86eTB5xHmh/cU9nM/YOoA/3NCKuBxuxpULdng0v7eNUlqCrQcunftKll
         XyAB91uOqhu4CIsEKbfJjGTq1nsOZDqSNTNdgpJ4=
Date:   Wed, 4 Aug 2021 14:04:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ting Wang <zxc52fgh@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangting11 <wangting11@xiaomi.com>
Subject: Re: [PATCH v11 0/4] add some power supply properties about
 wireless/wired charging
Message-ID: <YQqCNKoLdwaCjmIl@kroah.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 04, 2021 at 07:01:57PM +0800, Ting Wang wrote:
> From: wangting11 <wangting11@xiaomi.com>
> 
> This patchset aims to provide power supply properties about wireless/wired charging.
> "quick_charge_type" reports different types of quick charge based on the charging power;
> "tx_adapter" shows" the type of wireless charging adapter;
> "signal_strength" shows the coupling level between TX and RX;
> "reverse_chg_mode" provides the interface of enabling/disabling wireless reverse charging.
> 
> Changes in V11
>  - Fix build error on linus/master 
>  - Fix build error on power-supply/for-next
>  - Fix conflict

Where are the users of these new properties?  Shouldn't drivers be
submitted with them as well, otherwise why would these be added?

thanks,

greg k-h
