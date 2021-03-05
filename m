Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918AEC433DB
	for <linux-pm@archiver.kernel.org>; Fri,  5 Mar 2021 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E7865011
	for <linux-pm@archiver.kernel.org>; Fri,  5 Mar 2021 08:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCEIHu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:07:50 -0500
Received: from verein.lst.de ([213.95.11.211]:45152 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhCEIHu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 03:07:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7220868BEB; Fri,  5 Mar 2021 09:07:48 +0100 (CET)
Date:   Fri, 5 Mar 2021 09:07:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: driver notification when switching between battery vs AC power?
Message-ID: <20210305080748.GA17954@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

do we have infrastructure that notifies the driver when a system is
switching from batter to AC power?  There is a proposal to make the
Linux NVMe driver power management match the policy used by the
Windows driver more closely, which does this and we'd like to prototype
that to check what difference the policy makes.
