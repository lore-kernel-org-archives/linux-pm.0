From: Paul Bolle <pebolle@tiscali.nl>
Subject: config SOC_DRA7XX?
Date: Sun, 14 Jul 2013 16:54:46 +0200
Message-ID: <1373813686.1370.55.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:50372 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752576Ab3GNOys (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jul 2013 10:54:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org

0) Mainline commit 8926fa4f9b6160b1953ca44852d6044b58a829e1 ("thermal:
ti-soc-thermal: add thermal data for DRA752 chips") added a Kconfig
entry for DRA752_THERMAL.

1) That symbol depends on SOC_DRA7XX. But SOC_DRA7XX doesn't exist. This
means that currently the code depending on DRA752_THERMAL can't be
build.

2) Why is this dependency on SOC_DRA7XX needed? And what would
SOC_DRA7XX actually be? Some searches on the web returned nothing that
could show me what it is.


Paul Bolle

