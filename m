From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/1] turbostat regression fix
Date: Tue, 17 Oct 2017 15:50:37 -0400
Message-ID: <20171017195038.30941-1-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43265 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759148AbdJQTuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2017 15:50:46 -0400
Received: by mail-qk0-f172.google.com with SMTP id w134so3578139qkb.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2017 12:50:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Rafael,

This revert fixes a regression that shipped in 4.13.
Please apply.

It is marked for 4.13-stable.

thanks!
-Len
