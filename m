From: Sravan <asravan@codeaurora.org>
Subject: avoid adding devices without pm_ops to dpm list
Date: Mon, 21 Apr 2014 17:37:06 +0530
Message-ID: <535509EA.2090006@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:36259 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbaDUMHK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 08:07:10 -0400
Received: from [10.44.21.154] (unknown [202.46.23.62])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: asravan@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 03FB713EDFE
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2014 12:07:08 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I have come across below code which looks can be optimized to reduce 
suspend/resume latencies.

During device registration at boot up, device_add() is called.
In this device_add() function, device_pm_add() is called without 
checking if the device has pm_ops or not.
Thus dpm_list is generated with all devices even if some devices don't 
have pm_ops.

device_add() -> device_pm_add()-> generate dpm_list

During suspend/resume process, suspend/resume APIs are called for 
devices present in dpm_list.
due to this, suspend/resume APIs for devices without pm_ops also called 
and just return with NULL.

Can we optimize this code by adding *ONLY* devices with pm_ops to 
dpm_list and ignore remaining?
It will help reduce suspend/resume latencies. I observed 10mS savings 
with my debug code. It may change based on number of devices without pm_ops.

Let me know your opinion/suggestions on this.

---
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
