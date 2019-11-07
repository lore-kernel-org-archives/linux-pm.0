Return-Path: <SRS0=/bOj=Y7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C47FC6197
	for <linux-pm@archiver.kernel.org>; Thu,  7 Nov 2019 21:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807AD222CD
	for <linux-pm@archiver.kernel.org>; Thu,  7 Nov 2019 21:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Imc2kjH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKGVYS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:24:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKGVYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 16:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v7prfR74WqpB6QjYI8Y2BOHTsG7nZfh2FWlkAYoo2zA=; b=Imc2kjH0IvF3QaF7CwIUZA1V8
        1vhnmAP/TlwFxEl14+16JWeXd/8A3xITJYmDlzybsR88oprxcQI/wdEeV3VK+Z5likFSENCJA6fCz
        RriAfb0x702kNR92AkTM/YZ+Xs0jp2awOTdxc6ouRkl5Lde/3/PTTTD/+E9v/dNdKw01b6M8T+NrH
        bt8CL1YmL5ihf3A7z2vCzxqJeJYhWG8gxf8R+zdae0PDpLzRSWOWyod3gWJI4etT33yd8UDWDpaKl
        EH9rzODP+4wvBLfi0D/ehwjxSfugUfOHOtMhy2zqaBR9Kk4bAiJ3G7a87Iq+oHOLo/oZ0lXZIYdPD
        8iGVgO6OQ==;
Received: from [2001:4bb8:184:e48:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSpGH-0007F5-Hl; Thu, 07 Nov 2019 21:24:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: QEMU RISC-V virt machine poweroff driver
Date:   Thu,  7 Nov 2019 22:24:06 +0100
Message-Id: <20191107212408.11857-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

this patch add a driver for the test device in the Qemu RISC-V
virt machine which allows properly shutting down the VM.
It also is added to the riscv defconfig given that qemu-virt
is the most popular riscv platform.
