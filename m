Return-Path: <SRS0=dFIf=ZA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C2C43331
	for <linux-pm@archiver.kernel.org>; Fri,  8 Nov 2019 01:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AEE21D6C
	for <linux-pm@archiver.kernel.org>; Fri,  8 Nov 2019 01:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573174966;
	bh=Xe8aTUi9v+EhewXJWx4w2msv331058sgb10Ksged9dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jeX2OKMHmtlNqcgafIxnBvHICQAmTX8Spij9aZyTKl3XC5brLbIYNRYsKqNvhyAP3
	 bOmrTuqxhKK2Hj9oPi0lDPBVuDOJkvV0FxEmhRJ8kUVr0omCbDgdq6Z077nV7bn0pw
	 o053cVW0pmw5bz9JiXLSv1G5rHGjCBTzQhBwPEuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKHBCp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfKHBCp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Nov 2019 20:02:45 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C482178F;
        Fri,  8 Nov 2019 01:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573174964;
        bh=Xe8aTUi9v+EhewXJWx4w2msv331058sgb10Ksged9dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Rvhyx6r4XfeUEWuG00A62ThrNUrnecINps2x8j4KEFJdsivp+7MRlbIiZGh0Oiqa
         7btD+jeXMt+O3O0HbWjFvPZTrf116SWltijTJcX1+Wb2KCxPYnsUCP0nl2p/8AGHNT
         68OrWSezOGABUzzDbuhW/byuM9aoFgiv5IG4lZq0=
Date:   Fri, 8 Nov 2019 10:02:37 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Healy <cphealy@gmail.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] nvme: Add hardware monitoring support
Message-ID: <20191108010237.GA904@redsun51.ssa.fujisawa.hgst.com>
References: <20191106143518.1557-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106143518.1557-1-linux@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 06, 2019 at 06:35:18AM -0800, Guenter Roeck wrote:
> nvme devices report temperature information in the controller information
> (for limits) and in the smart log. Currently, the only means to retrieve
> this information is the nvme command line interface, which requires
> super-user privileges.
> 
> At the same time, it would be desirable to be able to use NVMe temperature
> information for thermal control.
> 
> This patch adds support to read NVMe temperatures from the kernel using the
> hwmon API and adds temperature zones for NVMe drives. The thermal subsystem
> can use this information to set thermal policies, and userspace can access
> it using libsensors and/or the "sensors" command.
> 
> Example output from the "sensors" command:
> 
> nvme0-pci-0100
> Adapter: PCI adapter
> Composite:    +39.0°C  (high = +85.0°C, crit = +85.0°C)
> Sensor 1:     +39.0°C
> Sensor 2:     +41.0°C
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks, applied for 5.5
