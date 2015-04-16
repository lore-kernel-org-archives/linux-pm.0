From: Heinz Diehl <htd+ml@fritha.org>
Subject: Failure to wake from S2D
Date: Thu, 16 Apr 2015 11:47:39 +0200
Message-ID: <20150416094739.GA10911@fritha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64992 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbbDPJrn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 05:47:43 -0400
Received: from localhost ([88.90.246.218]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0MI6Uo-1Yeq6k2epa-003sN4 for
 <linux-pm@vger.kernel.org>; Thu, 16 Apr 2015 11:47:40 +0200
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

about 3-4 times out of 10, my system doesn't wake from S2D. S2R works
flawlessly. The only documentation I have is a screenshot when the system hangs
(hard reset required), due to "no_console_suspend=1".

The screendump is here:
http://www.fritha.org/dump.jpg

The dump shows the output running kernel 4.0.0-rc5, but the same output is
present using 3.19.x or 4.0.0 final.

Booting with "maxcpus=1" resolves the problem, but that can't be a serious
option on a multicore Xeon. The mainboard is an Asus H97-Pro with the latest
BIOS.

Thanks,
 Heinz.
 

