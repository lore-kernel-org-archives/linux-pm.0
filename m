Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A4C433F5
	for <linux-pm@archiver.kernel.org>; Tue,  9 Nov 2021 13:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495FC61152
	for <linux-pm@archiver.kernel.org>; Tue,  9 Nov 2021 13:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhKINOB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Nov 2021 08:14:01 -0500
Received: from comms.puri.sm ([159.203.221.185]:47440 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhKINOB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 08:14:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CD8C8E0306;
        Tue,  9 Nov 2021 05:10:45 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k3Q3wFnK-lMX; Tue,  9 Nov 2021 05:10:45 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     sakari.ailus@linux.intel.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 0/2] media: i2c: hi846: minor PM fixes
Date:   Tue,  9 Nov 2021 14:10:11 +0100
Message-Id: <20211109131013.2684058-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hi Saraki and all,

Here are minor PM fixes for the hi846 sensor while testing system suspend:

thank you very much for your time,

                             martin


Martin Kepplinger (2):
  media: i2c: hi846: check return value of regulator_bulk_disable()
  media: i2c: hi846: use pm_runtime_force_suspend/resume for system
    suspend

 drivers/media/i2c/hi846.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.30.2

