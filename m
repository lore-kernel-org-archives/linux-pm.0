Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CCCC2BB3F
	for <linux-pm@archiver.kernel.org>; Sat, 18 Nov 2023 13:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjKRNao (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 18 Nov 2023 08:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjKRNan (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Nov 2023 08:30:43 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0610C12B
        for <linux-pm@vger.kernel.org>; Sat, 18 Nov 2023 05:30:38 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E972824002A
        for <linux-pm@vger.kernel.org>; Sat, 18 Nov 2023 14:30:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1700314235; bh=N10+A2ZxwaYqP7PRqiWkwAN6cRL1G1MlE+LnR6+F4EU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=jwbAjZX898UQ9VUXDmfn3QgeHj9JEqFRrrTYbGIFD7kREAIHDR+A67Fuyp7kavswU
         1K48uRm1mfBPf6W28nDOvXskCWbw3sfMNRkxt+tsijwvGqbgAESAWHJTkTyyZfzh4v
         LggHaVl9IfcJz8FHG1pAAedLLxSYE84Dyg7oOmKkWRlPd0KwmHXwdTOpb9U2x1f+AT
         ClRhZ8csRu3JQZuDeu2eMyby2lJ2vCa7MYBLi5ea8ivNQhEdqx/BZRWgbxLtwrbtRq
         xuzw03a22nwCDsmA9U6bBLXLATsQwYHJYI4zwHsAn3rlO0aKpo8mtEJ3U00TxMS7OL
         o/D00+4OQcAUw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SXZQg1fv1z6tsB;
        Sat, 18 Nov 2023 14:30:35 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 0/2] power: supply: checkpatch errors and warnings
Date:   Sat, 18 Nov 2023 13:29:56 +0000
Message-Id: <20231118132958.157238-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

List of the errors and warnings this patchset address:
	Errors:
		(1) code indent should use tabs where possible
		(2) switch and case should be at the same indent
	Warnings:
		(1) quoted string split across lines
		(2) Missing a blank line after declarations

Charalampos Mitrodimas (2):
  power: supply: Fix indentation and some other warnings
  power: supply: Use multiple MODULE_AUTHOR statements

 drivers/power/supply/power_supply_core.c | 167 ++++++++++++-----------
 1 file changed, 84 insertions(+), 83 deletions(-)

-- 
2.39.2

