From: "Skidanov, Alexey" <alexey.skidanov@intel.com>
Subject: pm_runtime_active question
Date: Mon, 28 Mar 2016 11:01:58 +0000
Message-ID: <040863540BC4D141BEB1775323508828B44E89@hasmsx108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11586 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbcC1LCF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 07:02:05 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "alexey.skidanov@gmail.com" <alexey.skidanov@gmail.com>

Hi,

The pm_runtime_active is defined as follows:

static inline bool pm_runtime_active(struct device *dev)
{
        return dev->power.runtime_status == RPM_ACTIVE
                 || dev->power.disable_depth;
}

Why does this function take into account the power.disable_depth? That is, this function will return true if the runtime PM is disabled for this device.

Thanks,
Alexey
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

