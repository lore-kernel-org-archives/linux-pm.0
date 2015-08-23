From: doa379 <doa379@gmail.com>
Subject: Kernel uevents of laptop battery percentages
Date: Mon, 24 Aug 2015 00:14:48 +0100
Message-ID: <55DA53E8.5070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35217 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbbHWXO6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 23 Aug 2015 19:14:58 -0400
Received: by wicne3 with SMTP id ne3so56998594wic.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2015 16:14:57 -0700 (PDT)
Received: from [192.168.1.4] (88-105-203-173.dynamic.dsl.as9105.com. [88.105.203.173])
        by smtp.googlemail.com with ESMTPSA id ft5sm13455976wib.4.2015.08.23.16.14.56
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2015 16:14:56 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

I have a situation where the Kernel is not sending out uevents of 
battery level percentages.

Only a significant change in the Kernel state sends out a status event 
of the power_supply subsystem for example as follows:

KERNEL[27717.611535] change 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/PNP0C0A:00/power_supply/BAT0 
(power_supply)

I am looking for a way to get status event updates even when the battery 
level (capacity or percentage) changes.

I was wondering if anyone might suggest any insight into this?

Thanks very much.


