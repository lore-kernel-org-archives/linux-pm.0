From: Zhang Rui <rui.zhang@intel.com>
Subject: Possible regression caused by commit 1bd047be37d9 ("tpm_crb: Use
 devm_ioremap_resource")
Date: Sun, 31 Jul 2016 10:47:26 +0800
Message-ID: <1469933246.2361.7.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60702 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbcGaCsE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 30 Jul 2016 22:48:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jgunthorpe@obsidianresearch.com
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi, Jason,

we got a bug report complaining that the system can not enter deeper
package c-states than pc2, and the git bisect result points to commit
1bd047be37d9 ("tpm_crb: Use devm_ioremap_resource").

can you take a look at this issue?

Bugzilla link: https://bugzilla.kernel.org/show_bug.cgi?id=118451

thanks,
rui
