From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] randconfig warning fixes for thermal
Date: Mon, 25 Jan 2016 17:44:09 +0100
Message-ID: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:64293 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbcAYQpE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 11:45:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, spear-devel@list.st.com

These are three simple fixes for ARM randconfig builds:

 [PATCH 1/3] thermal: spear: use __maybe_unused for PM functions
 [PATCH 2/3] thermal: allow spear-thermal driver to be a module
 [PATCH 3/3] thermal: allow u8500-thermal driver to be a module

All three bugs are on configurationsn that are not important and
that rarely happen even with randconfig builds.

	Arnd
