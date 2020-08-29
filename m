Return-Path: <SRS0=y3pC=CH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1431AC433E6
	for <linux-pm@archiver.kernel.org>; Sat, 29 Aug 2020 17:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A6520714
	for <linux-pm@archiver.kernel.org>; Sat, 29 Aug 2020 17:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgH2RZP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgH2RZO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 Aug 2020 13:25:14 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 209069] CPU stuck at 800 MHz at any load
Date:   Sat, 29 Aug 2020 17:25:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dsmythies@telus.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209069-137361-SYEBdmkuYh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209069-137361@https.bugzilla.kernel.org/>
References: <bug-209069-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209069

Doug Smythies (dsmythies@telus.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dsmythies@telus.net

--- Comment #6 from Doug Smythies (dsmythies@telus.net) ---
intel_cpufreq CPU frequency driver (intel_pstate in passive mode), userspace
governor with a setspeed of 0.8GHz. So, you are getting what you asked for.

-- 
You are receiving this mail because:
You are the assignee for the bug.
