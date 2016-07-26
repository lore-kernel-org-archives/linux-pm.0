From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Fwd: [Bug 150021] New: kernel panic: "kernel tried to execute NX-protected page" when resuming from hibernate to disk
Date: Tue, 26 Jul 2016 13:32:28 +0200
Message-ID: <16541580.dFLT14ScxF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart8104332.NlgtZdr47K"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64990 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755316AbcGZL11 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2016 07:27:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org

This is a multi-part message in MIME format.

--nextPart8104332.NlgtZdr47K
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

The following commit:

commit 13523309495cdbd57a0d344c0d5d574987af007f
Author: Josh Poimboeuf <jpoimboe@redhat.com>
Date:   Thu Jan 21 16:49:21 2016 -0600

    x86/asm/acpi: Create a stack frame in do_suspend_lowlevel()
    
    do_suspend_lowlevel() is a callable non-leaf function which doesn't
    honor CONFIG_FRAME_POINTER, which can result in bad stack traces.
    
    Create a stack frame for it when CONFIG_FRAME_POINTER is enabled.

is reported to cause a resume-from-hibernation regression due to an attempt
to execute an NX page (we've seen quite a bit of that recently).

I'm asking the reporter to try 4.7, but if the problem is still there, we'll
need to revert the above I'm afraid.

Thanks,
Rafael

--nextPart8104332.NlgtZdr47K
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: bugzilla-daemon@bugzilla.kernel.org: [Bug 150021] New: kernel panic: "kernel tried to execute NX-protected page" when resuming from hibernate to disk

Return-Path: <bugzilla-daemon@bugzilla.kernel.org>
Received: from mail.kernel.org (198.145.29.136) (HELO mail.kernel.org) by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer v0.80.3) id c3522138f7fb18c4; Mon, 25 Jul 2016 23:16:33 +0200
Received: from mail.kernel.org (localhost [127.0.0.1]) by mail.kernel.org (Postfix) with ESMTP id 6363620351 for <rjw@rjwysocki.net>; Mon, 25 Jul 2016 21:16:31 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52]) by mail.kernel.org (Postfix) with ESMTP id 0B5B6202E5 for <rjw@rjwysocki.net>; Mon, 25 Jul 2016 21:16:30 +0000 (UTC)
Received: by bugzilla2.web.kernel.org (Postfix, from userid 48) id 014709F4DC; Mon, 25 Jul 2016 21:16:29 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: rjw@rjwysocki.net
Subject: [Bug 150021] New: kernel panic: "kernel tried to execute NX-protected page" when resuming from hibernate to disk
Date: Mon, 25 Jul 2016 21:16:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: Hibernation/Suspend
X-Bugzilla-Version: 2.5
X-Bugzilla-Severity: normal
X-Bugzilla-Who: shuzzle@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: rjw@rjwysocki.net
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Changed-Fields: bug_id short_desc product version cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-150021-76231@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD, UNPARSEABLE_RELAY autolearn=unavailable version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP

https://bugzilla.kernel.org/show_bug.cgi?id=150021

            Bug ID: 150021
           Summary: kernel panic: "kernel tried to execute NX-protected
                    page" when resuming from hibernate to disk
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.6.x
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Hibernation/Suspend
          Assignee: rjw@rjwysocki.net
          Reporter: shuzzle@mailbox.org
        Regression: No

Created attachment 226381
  --> https://bugzilla.kernel.org/attachment.cgi?id=226381&action=edit
last working .config

Overview: 

When commit 13523309495cdbd57a0d344c0d5d574987af007f is applied to my kernel
sources my kernel panics when trying to resume from hibernate to disk.


Steps to Reproduce: 

1. have a working hibernate/resume setup
2. compile 4.6.x kernel
3. boot and hibernate to disk
4. test various kernels using "git bisect".


Actual Results: kernel panics when trying to resume from hibernate to disk.

Expected Results: Resume from hibernate to disk like kernels without commit
13523309495cdbd57a0d344c0d5d574987af007f did.


I attached my working .config of my 4.5.7 kernel.

Any help will be appreciated. Thanks!

-- 
You are receiving this mail because:
You are the assignee for the bug.

--nextPart8104332.NlgtZdr47K--

