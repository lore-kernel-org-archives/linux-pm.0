Return-Path: <SRS0=8pdy=3R=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4CFC33CB3
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jan 2020 05:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC05224682
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jan 2020 05:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgA1Fxj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:53:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgA1Fxj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Jan 2020 00:53:39 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 206307] AMD Ryzen CPU frequency monitoring subsystem is
 insufficient
Date:   Tue, 28 Jan 2020 05:53:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: trenn@suse.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-206307-137361-KwtVrZT1eX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206307-137361@https.bugzilla.kernel.org/>
References: <bug-206307-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206307

Thomas Renninger (trenn@suse.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |trenn@suse.de

--- Comment #2 from Thomas Renninger (trenn@suse.de) ---
This would need another cpufreq driver.
acpi_cpufreq is fixed in the amount of frequency states and the passed array is
not that big (not sure what max supported freqs with acpi_cpufreq is, it should
be fixed around 15-20).

A driver similar to intel_pstate driver is needed.
Who is going to write this one?

-- 
You are receiving this mail because:
You are the assignee for the bug.
