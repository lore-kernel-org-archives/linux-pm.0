Return-Path: <SRS0=akx2=AV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57523C433EC
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 12:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3230720748
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594383987;
	bh=6aBy/efwqSNbHGKVg4ZdfQ85XJ40aFOZJto45y2cftA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UD16FRZt5JaQC16mhoBs74FnzBfpfdYec7+dURbAdrlrVxOfzCr9qBPPoU8XFQsp9
	 5Z+TqiB23ZvyQwSxwwVjwCCzrvBkfCatocOnxn+/4UYIsTp2Kqy3j3j1SAkoD1fJoZ
	 s3A4Gc4hVdYvwnQGRDfsy/txlGd7T9jgx9utuzgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGJM0P (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgGJM0M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 08:26:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2698520748;
        Fri, 10 Jul 2020 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594383971;
        bh=6aBy/efwqSNbHGKVg4ZdfQ85XJ40aFOZJto45y2cftA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuvBYzFNdOILgKmCl8WTmMc9uSS8TtRrZYsWLdPSFAxtfq1+kcYE+LuW2OMewf2Ib
         SRdSW9YxYBwNoCddgSNlB9Y802yVLA6F1eXldKyCtWAVowT+aFa8n1TgPe02jfEdxD
         x8hI83YRkUK4WPcpPky6f/5fN9CqWEI1/zTZP4QE=
Date:   Fri, 10 Jul 2020 14:26:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org, swboyd@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 1/1] power: Emit changed uevent on
 wakeup_sysfs_add/remove
Message-ID: <20200710122616.GA1536085@kroah.com>
References: <20200707172845.4177903-1-abhishekpandit@chromium.org>
 <20200707102823.v5.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707102823.v5.1.I51f5a0be89595b73c4dc17e6cf4cc6f26dc7f2fc@changeid>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 07, 2020 at 10:28:44AM -0700, Abhishek Pandit-Subedi wrote:
> Udev rules that depend on the power/wakeup attribute don't get triggered
> correctly if device_set_wakeup_capable is called after the device is
> created. This can happen for several reasons (driver sets wakeup after
> device is created, wakeup is changed on parent device, etc) and it seems
> reasonable to emit a changed event when adding or removing attributes on
> the device.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
