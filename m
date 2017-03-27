From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12 0/5] bq27xxx_battery partial series
Date: Mon, 27 Mar 2017 00:41:54 -0700
Message-ID: <20170327074159.16213-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33283 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdC0HmB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 03:42:01 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so10640001pgf.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2017 00:42:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Andrew, here are the bq27xxx related patches, revised and refactored from your feedback. I
refactored with a somewhat diff mix than you suggested for the sake of readability.

Changes prior to refactoring:
https://github.com/networkimprov/linux/commit/a9c984f0
https://github.com/networkimprov/linux/commit/59fb17ac

I didn't take these 5 suggestions:

/* BlockDataControl() -> Block Data Control, etc
I prefer terms from the docs so that searches in docs for the comment string work.

/* Reports EINVAL ...
This is obvious from the code.

Error reporting
You and Sebastian differ, so I dropped the patch, leaving dev_dbg in I/O methods. Pls resolve in a 
future patchset.

checksum_dm_block()
That code came from bqtool, which I don't want to second guess.

/* This sequence is toxic
It's essential to document a specific feature which must not be added to the code. I revised the 
comment.
