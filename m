From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 09 Oct 2015 13:20:38 +0000
Message-ID: <bug-103351-137361-OaIk3PmSqu@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40114 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676AbbJINUo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 9 Oct 2015 09:20:44 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E368F2084C
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2015 13:20:42 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id BA427208D2
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2015 13:20:40 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #55 from sac <sdfjk40sdnmxyl@mailinator.com> ---
BTW: I was able to update my Asrock H97 BIOS Microcode from 0x10 to 0x12 with
Ubu and the MCEs on my i5 5675C seem to be gone. System is stable since 3 hours
running a VM (where it crashed constantly after 2min earlier). Only found Win
tools to mod the BIOS, but please note that a Microcode BIOS mod seems to be
the most critical thing to mod and not all tools work for all MB vendors. I
only tried because I have a Dual BIOS that restores the original one after 5
failed boot attempts. Try at your own risk.

http://www.win-raid.com/t455f16-Guide-How-to-flash-a-modded-ASUS-or-ASRock-AMI-UEFI-BIOS.html
http://www.win-raid.com/t154f16-Tool-Guide-News-quot-UEFI-BIOS-Updater-quot-UBU.html

-- 
You are receiving this mail because:
You are the assignee for the bug.
