From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 0/5] Thermal: build all thermal framework code into thermal_sys module
Date: Wed, 27 Mar 2013 00:26:04 +0800
Message-ID: <1364315169-15427-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57346 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933031Ab3CZQ0P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 12:26:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: amit.daniel@samsung.com, durgadoss.r@intel.com, andi@lisas.de, Zhang Rui <rui.zhang@intel.com>

A regression introduced by thermal governor feature
is reported in http://marc.info/?l=linux-kernel&m=136085598604095&w=2

And the root cause is that all the thermal governors can not be registered
successfully when the thermal framework is built as a module.

Thus I made this patch set to build all the thermal framework component,
including governors and cpu_cooling feature into one module so that all the
thermal features are loaded/unloaded altogether.

any comments?

thanks,
rui
