From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 01 Oct 2015 18:59:13 +0000
Message-ID: <bug-103351-137361-636BxVdeks@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52566 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbbJAS7R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 14:59:17 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id ABF49207B3
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 18:59:16 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 72BEF207BD
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 18:59:15 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #32 from matthew.dewitt@gmail.com ---
Well, it still has to be applied at every reboot right?

Still, very awesome!

On Thu, Oct 1, 2015 at 2:58 PM, <bugzilla-daemon@bugzilla.kernel.org> wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=103351
>
> --- Comment #31 from Alexey Dyachenko <adotfive@gmail.com> ---
> (In reply to kernel@benjam.info from comment #28)
> > https://github.com/bgw/bdw-ucode-update-tool
>
> Confirm this working for 5675C, thank you!
> To think that we got an update to fix such critical issue (and HLE glibc
> crashes aswell, btw) by hacking vendor BIOS rather than from Intel itself
> is
> mind boggling.
>
> --
> You are receiving this mail because:
> You are on the CC list for the bug.
>

-- 
You are receiving this mail because:
You are the assignee for the bug.
