From: Justin Waters <justin.waters@timesys.com>
Subject: Baytrail C6 auto-demotion disable causing UART issues
Date: Fri, 11 Mar 2016 11:28:38 -0500
Message-ID: <CAENNV6+1H+F38Le4MPxZdNmRNb2cpR7X3ZiN18FLGg_zdvbugg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36587 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264AbcCKQ26 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2016 11:28:58 -0500
Received: by mail-vk0-f53.google.com with SMTP id c3so140078130vkb.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Mar 2016 08:28:58 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org, "Bhuyan, Jyotideep (GE Healthcare)" <JyotideepBhuyan@ge.com>

Hello Len,

We recently upgraded to a 4.x kernel on a Baytrail platform, and began
to notice odd behavior on the UART ports. We use these ports to load
firmware to an FPGA, and while it worked fine on the older kernel, our
data was being corrupted on newer kernels. I also noticed subtle
issues on the serial console, especially when using applications like
vi. Interestingly enough, we were unable to reproduce the issue using
a USB to Serial dongle.

While we initially suspected a regression in the UART driver, using
bisection, we narrowed the cause down to the following commit:
8c058d53f6f2eb0b9cd3bc4ce5c053a64dded671

By reverting this commit (thereby re-enabling the C6 auto-demotion on
the Baytrail platform), our corruption issue disappeared.

Is there any reason that I should be seeing this behavior? Will
reverting this commit on my side have any adverse side effects on my
system (beyond a decrease in power efficiency, as described by the
commit message)?

Thank you,

-- 
Justin Waters
Director of Engineering
Timesys Corporation
