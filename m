Return-Path: <SRS0=MKj8=AH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83785C433E0
	for <linux-pm@archiver.kernel.org>; Fri, 26 Jun 2020 04:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E8020885
	for <linux-pm@archiver.kernel.org>; Fri, 26 Jun 2020 04:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgFZE0d (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:26:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42477 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgFZE0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 00:26:33 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id C7517CECFD;
        Fri, 26 Jun 2020 06:36:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: Comment on unbalanced pm reference
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200625162544.1.Iea2fbf7a284191c0f09c2ffbe8c14b872d0f68b2@changeid>
Date:   Fri, 26 Jun 2020 06:26:30 +0200
Cc:     Oliver Neukum <oneukum@suse.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-pm@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D70FEC02-74EA-4082-B3F6-40B099EA645B@holtmann.org>
References: <20200625162544.1.Iea2fbf7a284191c0f09c2ffbe8c14b872d0f68b2@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Abhishek,

> Add a comment clarifying that a PM reference in btusb_qca_cmd_timeout is
> not unbalanced because it results in a device reset.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

