From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH 0/3] intel_idle: set the state_tables array into __initdata
 to save mem
Date: Fri, 08 Mar 2013 23:02:06 +0800
Message-ID: <1362754926.31506.42.camel@cliu38-desktop-build>
References: <1362674529.31506.17.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3219 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab3CHFwo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 Mar 2013 00:52:44 -0500
In-Reply-To: <1362674529.31506.17.camel@cliu38-desktop-build>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, daniel.lezcano@linaro.org, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com

As Daniel suggested, I did some cleanup before setting the state_tables array
into __initdata.

Thanks your help to review them.

[PATCH 1/3] intel_idle: changing the continue to break in intel_idle_cpu_init()
[PATCH 2/3] intel_idle: Removing the redundant calculating for dev->state_count
[PATCH 3/3] intel_idle: set the state_tables array as __initdata to save mem


