From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 14 Oct 2015 20:55:23 +0000
Message-ID: <bug-103351-137361-fUVga3xKyo@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47719 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbbJNUz2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 16:55:28 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D58D520876
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 20:55:26 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id E63C6209CC
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 20:55:25 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #60 from kernel@benjam.info <kernel@benjam.info> ---
(In reply to Fredrik Atmer from comment #57)
> I'm using the script from the git repository. It works, but the
> --persist-debian option fails to make it persistent. I don't know if I'm
> using it incorrectly, and I'm happy to provide more information if
> requested. I also tried the method with iucode-tool described above, with
> the same result. The install.sh script does just that, right?

If you're curious what the `install.sh` script does, you can just open it in a
text file and see for yourself. It uses `iucode-tool` with the
`--write-firmware` flag to copy the file to `/lib/firmware/intel-ucode`, and
then `update-initramfs` to rebuild the early-boot image.

I haven't tested this on Ubuntu (I'm using Debian Jessie), but I'll do some
experimentation in a virtual machine.

-- 
You are receiving this mail because:
You are the assignee for the bug.
