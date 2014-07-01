From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 00/16] CPU Idle for Armada 370 and Armada 38x
Date: Tue, 1 Jul 2014 16:38:11 +0200
Message-ID: <20140701163811.7d731695@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<20140630174520.194d4781@free-electrons.com>
	<53B1878B.9060701@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36276 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753109AbaGAPCk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jul 2014 11:02:40 -0400
In-Reply-To: <53B1878B.9060701@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Dear Gregory CLEMENT,

On Mon, 30 Jun 2014 17:51:39 +0200, Gregory CLEMENT wrote:

> > I'd like to do some testing of this patch series, especially in big
> > endian situations. Do you have a Git repository where this version was
> > pushed?
> 
> Yes sure, the branch CPU-Idle-mvebu-next-3.16-rc2-V1 on
> https://github.com/MISL-EBU-System-SW/mainline-public.git

Ok, I've tested the following cases:

 * Armada XP LE and BE: it shouldn't be affected by your patch series,
   and indeed, it works fine.

 * Armada 370 LE worked fine.

 * Armada 370 BE didn't work, I had to fix the code in
   pmsu.c/pmsu_ll.S. I already replied to the appropriate patch to
   indicate what was wrong.

 * Armada 375 LE worked fine. Armada 375 BE was also affected by the
   same issue as Armada 370 BE because they use the same work-around
   for the boot issue (Armada 375 Z1 of course, since Armada 375 A0 is
   not affected). With the fix added for big-endian, Armada 375 BE
   works again (i.e its SMP initialization works).

 * Armada 38x LE and BE worked fine (there was a completely unrelated
   issue in the SMP initialization of 38x in BE, I'll sent a patch
   shortly for this).

So all in all, in terms of testing, despite the minor fix for the BE
configuration, it looks good to me.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
