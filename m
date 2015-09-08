From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 0/2] Update OF thermal properties for cooling-{min,max}-level
Date: Tue,  8 Sep 2015 12:16:51 +0100
Message-ID: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:58455 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753551AbbIHLP7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 07:15:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, rui.zhang@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org

Hi,

The device tree properties regarding the specification and usage of
states for cooling devices suffer from inconsistency in the bindings
as well as the usage.

The two patches here update the bindings to be consistent without
breaking existing support for the device trees already in upstream.

Thanks,
Punit

Punit Agrawal (2):
  of: thermal: Fix inconsitency between cooling-*-state and
    cooling-*-level
  of: thermal: Mark cooling-*-level properties optional

 .../devicetree/bindings/thermal/thermal.txt        | 27 +++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
2.5.0

