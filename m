From: =?UTF-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Subject: stop suspend during update firmware?
Date: Tue, 12 Nov 2013 15:38:47 +0800
Message-ID: <5281DB07.6060206@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:27080 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab3KLHsx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2013 02:48:53 -0500
Received: from [192.168.135.109] ([192.168.135.109])
	by emc.com.tw (8.13.7+Sun/8.13.7) with ESMTP id rAC7ckam020255
	for <"linux-pm@vger.kernel.org">; Tue, 12 Nov 2013 15:38:46 +0800 (CST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org"@emc.com.tw

Hi,
     I'm developing touchscreen i2c driver on Google chrome OS (kernel 
v3.8.11)
     I want to tell kernel do not enter suspend mode during update 
firmware by request_firmware().

     But I only found the pm_wake_lock() for sysfs control, so does 
anyway be tell kernel do not enter suspend/resume?

thanks,
Scott

