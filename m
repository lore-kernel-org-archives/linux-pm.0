From: Jean Delvare <jdelvare@suse.de>
Subject: Thermal governors non-modularity
Date: Sat, 20 Feb 2016 14:04:48 +0100
Message-ID: <20160220140448.19b749dd@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49646 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbcBTNEw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 20 Feb 2016 08:04:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Rui, Eduardo,

Is there any fundamental reason why thermal governors can't be built as
modules? We have more and more of them, 5 now, and the most recent is
fairly big... Would be much more practical if they could be built as
modules and loaded at run-time only as needed.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
