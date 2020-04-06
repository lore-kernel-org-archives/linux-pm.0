Return-Path: <SRS0=HvZr=5W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99782C2BA1E
	for <linux-pm@archiver.kernel.org>; Mon,  6 Apr 2020 11:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6882072A
	for <linux-pm@archiver.kernel.org>; Mon,  6 Apr 2020 11:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JtsEqtO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgDFL6n (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:58:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgDFL6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 07:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2ci0DUzI2b4YmDq85O6Os3gM/ouyEFXJM6YNbwYK0l8=; b=JtsEqtO9OMmmoHeZ0ckvc6hbVU
        Gj5LmOmatezUDEbzz1nTvc+I11CH0PZnstD/Xe9xe+B8MwbhcAzxfFLyFu3d7rOIflPkdFF4trvO7
        j9stw8GS1H55fJAIZXJBu79mnHmj93pn/iRMmwguSnKXo+teAleEfBFJ3iGek4zvcsjuvkz4weVMX
        vukKc5n1n7ja/4UdTt0jUx/ZLBn3MURbXIHf9cFQ5hi80UOGj6xxPlDkKUOiow2I9qkuTDdZHsuC5
        cQIfbd06/MutK40g/TmkPLpFnxmS9gUxSkqLwqGhsCFC3/w0mGKjrLxp6JL2uX4JPTYLXo+F7vtq2
        wgeIoRxA==;
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQOj-0008FX-99; Mon, 06 Apr 2020 11:58:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: improve the uswsusp ioctl handling to avoid set_fs
Date:   Mon,  6 Apr 2020 13:58:33 +0200
Message-Id: <20200406115835.1150002-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

this series refactors the uswsusp ioctl so that no rewriting of
the ioctl structure for the compat case, and thus messing with the
address limit is required.
