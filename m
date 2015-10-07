From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 07 Oct 2015 21:51:24 +0000
Message-ID: <bug-103351-137361-IDa56WP72w@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57027 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667AbbJGVv3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 17:51:29 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1D2072B
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 21:51:28 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 10E1220778
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 21:51:27 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #44 from matthew.dewitt@gmail.com ---
I'll do that tonight

On Wed, Oct 7, 2015 at 4:21 PM, <bugzilla-daemon@bugzilla.kernel.org> wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=103351
>
> --- Comment #43 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
> Jonas Platte: Thanks for the information.  Sorry, I didn't notice you were
> not
> one of the people who also reported glibc issues.
>
> Benjan: Thanks for the information.
>
> Alexey, Matthew: If at all possible, maybe you could repeat the glibc
> lock-elision testing with microcode 0x12, using a VM or chroot?
>
> --
> You are receiving this mail because:
> You are on the CC list for the bug.
>

-- 
You are receiving this mail because:
You are the assignee for the bug.
