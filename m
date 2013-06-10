From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Fwd: [Bug 58971] High temperature after resuming from suspend to RAM (system idle).
Date: Mon, 10 Jun 2013 21:59:41 +0200
Message-ID: <4314262.2IYItRHfbT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2311176.cbnUae7iRN"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:33488 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab3FJTuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 10 Jun 2013 15:50:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: intel-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>

This is a multi-part message in MIME format.

--nextPart2311176.cbnUae7iRN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

It looks like an i915 commit causes problems with frequency scaling to
happen to people.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart2311176.cbnUae7iRN
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: bugzilla-daemon@bugzilla.kernel.org: [Bug 58971] High temperature after resuming from suspend to RAM (system idle).

Return-Path: <bugzilla-daemon@bugzilla.kernel.org>
Delivered-To: <rjw@sisk.pl>
Received: from hydra.sisk.pl by hydra.sisk.pl (Dovecot) with LMTP id A1MMLWvntVFgEgAAw1yIng for <rjw@sisk.pl>; Mon, 10 Jun 2013 16:49:55 +0200
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201]) by hydra.sisk.pl (Postfix) with ESMTP id 97324E3DA6 for <rjw@sisk.pl>; Mon, 10 Jun 2013 16:49:55 +0200 (CEST)
Received: from mail.kernel.org (localhost [127.0.0.1]) by mail.kernel.org (Postfix) with ESMTP id 137572040A for <rjw@sisk.pl>; Mon, 10 Jun 2013 14:53:11 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217]) by mail.kernel.org (Postfix) with ESMTP id 5824F203FF for <rjw@sisk.pl>; Mon, 10 Jun 2013 14:53:07 +0000 (UTC)
Received: by bugzilla.kernel.org (Postfix, from userid 1000) id 503AB11FB80; Mon, 10 Jun 2013 14:53:07 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: rjw@sisk.pl
Subject: [Bug 58971] High temperature after resuming from suspend to RAM (system idle).
X-Bugzilla-Reason: CC
X-Bugzilla-Type: newchanged
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Severity: high
X-Bugzilla-Who: alexkaltsas@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: rjw@rjwysocki.net
X-Bugzilla-Target-Milestone: ---
In-Reply-To: <bug-58971-10028@https.bugzilla.kernel.org/>
References: <bug-58971-10028@https.bugzilla.kernel.org/>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-ID: <20130610145307.503AB11FB80@bugzilla.kernel.org>
Date: Mon, 10 Jun 2013 14:53:07 +0000
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD, UNPARSEABLE_RELAY,WEIRD_PORT autolearn=unavailable version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP

https://bugzilla.kernel.org/show_bug.cgi?id=58971





--- Comment #42 from Alexander Kaltsas <alexkaltsas@gmail.com>  2013-06-10 14:53:06 ---
Ok, I managed to complete a git bisect. The result was:

First bad commit: [15239099d7a7a9ecdc1ccb5b187ae4cda5488ff9] drm/i915: enable
irqs earlier when resuming.

http://o.cs.uvic.ca:20810/perl/cid.pl?cid=15239099d7a7a9ecdc1ccb5b187ae4cda5488ff9

I removed the above patch from kernel 3.9.4, 3.9.5 and it seems to work ok
after suspend and resume. With Intel PSTATE enabled.

The temperature is back to normal and the cpu frequency doesn't "lock" to the 
highest value.



Just a side note. Don't know if related at all:

I have noticed that when using Intel PSTATE. If the system starts with
frequency
scaling to powersave the frequency is around to 800~900 MHz. If I change it to 
performance it will go up. After changing it back to powersave the frequency
will
stay to ~2000 MHz. If I suspend and resume it will be around to 800~900 MHz
again.
This doesn't seem to effect the temperature of the system'

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug.

--nextPart2311176.cbnUae7iRN--

