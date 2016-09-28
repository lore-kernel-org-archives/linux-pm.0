From: Zhang Rui <rui.zhang@intel.com>
Subject: Regression:  Laptop cannot suspend after update to kernel 4.5.3,
 caused by aa8e54b559
Date: Wed, 28 Sep 2016 09:16:26 +0800
Message-ID: <1475025386.4284.12.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61077 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754101AbcI1BQb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Sep 2016 21:16:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tomeu.vizoso@collabora.com
Cc: ulf.hansson@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

Hi, Tomeu,

we've got a regression report at https://bugzilla.kernel.org/show_bug.c
gi?id=156441
the bug reporter has confirmed that reverting commit aa8e54b559 on
kernel 4.5.3 solves the problem.
can you please take a look at the problem?

thanks,
rui
