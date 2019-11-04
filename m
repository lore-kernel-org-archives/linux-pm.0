Return-Path: <SRS0=IIwL=Y4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9A1CA9EB5
	for <linux-pm@archiver.kernel.org>; Mon,  4 Nov 2019 15:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B605620650
	for <linux-pm@archiver.kernel.org>; Mon,  4 Nov 2019 15:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDPem (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:34:42 -0500
Received: from verein.lst.de ([213.95.11.211]:39625 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfKDPem (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Nov 2019 10:34:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 194CC68BE1; Mon,  4 Nov 2019 16:34:39 +0100 (CET)
Date:   Mon, 4 Nov 2019 16:34:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4] nvme: Add hardware monitoring support
Message-ID: <20191104153438.GA17328@lst.de>
References: <20191102145530.16104-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102145530.16104-1-linux@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
