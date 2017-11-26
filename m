From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Something like devm_pm_runtime_enable desirable?
Date: Mon, 27 Nov 2017 00:13:38 +0100
Message-ID: <66504d0c-1b30-8b36-fd11-bd9abc2eb41a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:46804 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbdKZXNq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Nov 2017 18:13:46 -0500
Received: by mail-wr0-f172.google.com with SMTP id r2so18310771wra.13
        for <linux-pm@vger.kernel.org>; Sun, 26 Nov 2017 15:13:46 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

I have a runtime pm enabled driver which uses device-managed resources
only and therefore wouldn't need a remove callback. The remove callback
does pm_runtime_disable only.
Therefore I'm wondering whether something like devm_pm_runtime_enable
would be desirable doing the pm_runtime_disable automagically.

I can't really imagine that I'm the first one with this idea so I
guess there is some reason why it doesn't exist yet ..
