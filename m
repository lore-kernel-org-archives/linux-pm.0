From: Jiri Kosina <jikos@kernel.org>
Subject: 4.8-rc1: resume from hibernation doesn't work
Date: Tue, 9 Aug 2016 10:42:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608091038220.22028@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36606 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbcHIImk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Aug 2016 04:42:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

current Linus' tree (HEAD 65ea11ec6, so basically 4.8-rc1+) has broken 
resume from hibernation on my x200s.

Suspend works correctly, resuming proceeds up to the point where it 
reports 100% of reading of the hibernation image, and afterwards the 
machine reboots (tripple fault ... dunno, I don't really see any kernel 
messages between the report of reading the hibernation image and reboot).

4.7-rc4 is fine on this machine, so I thought I'd bisect it, but 
unfortunately at some point in the bisection process, the hibernation 
itself breaks, so there is not really a way for me to bisect it.

Any ideas which patches to try to revert?

Thanks,

-- 
Jiri Kosina
SUSE Labs

