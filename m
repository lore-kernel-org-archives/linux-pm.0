From: Thomas Lee <t.lee2000@frontier.com>
Subject: Suspend/Resume Failure on Gateway MD2614-U
Date: Sun, 13 Oct 2013 20:35:06 -0500
Message-ID: <525B4A4A.9080100@frontier.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter03.roch.ny.frontiernet.net ([66.133.183.233]:37424 "EHLO
	filter03.roch.ny.frontiernet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755423Ab3JNBml (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2013 21:42:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by filter03.roch.ny.frontiernet.net (Postfix) with ESMTP id 7D5A518A204
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2013 01:35:11 +0000 (UTC)
Received: from relay01.roch.ny.frontiernet.net ([66.133.182.164])
	by localhost (filter03.roch.ny.frontiernet.net [66.133.183.233]) (amavisd-new, port 10024)
	with LMTP id Cqrg-JgitKgE for <linux-pm@vger.kernel.org>;
	Mon, 14 Oct 2013 01:35:08 +0000 (UTC)
Received: from [192.168.254.19] (unknown [50.103.236.107])
	by relay01.roch.ny.frontiernet.net (Postfix) with ESMTPA id A23E6600B
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2013 01:35:06 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

As detailed in the Ubuntu bug report filed at 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1227689 the Gateway 
MD2614U laptop will not properly resume from a 'Suspended' state, 
instead remaining at a black screen on power-up.
