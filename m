From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/5] thermal: convert ID allocation to IDA
Date: Wed, 21 Dec 2016 10:04:10 +0800
Message-ID: <1482285855-2974-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65334 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752226AbcLUCES (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Dec 2016 21:04:18 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Currently, thermal subsystem uses IDRs to allocate IDs, but actually
it only needs to know whether IDs are in use or not, and the ID to pointer
functionality of the IDR is unused.
That means it can use the more space-efficient IDA.

This patch set converts ID allocation to IDA for thermal subsystem.

PS: only build test is done for this patch set.

thanks,
rui
