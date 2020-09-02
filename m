Return-Path: <SRS0=6wxd=CL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62325C433E7
	for <linux-pm@archiver.kernel.org>; Wed,  2 Sep 2020 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CF920C56
	for <linux-pm@archiver.kernel.org>; Wed,  2 Sep 2020 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIBSgM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgIBSgM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 14:36:12 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 209069] CPU stuck at 800 MHz at any load
Date:   Wed, 02 Sep 2020 18:36:11 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209069-137361-eHpC01T6l9@https.bugzilla.kernel.org/>
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

--- Comment #8 from Doug Smythies (dsmythies@telus.net) ---
My best guess is that with kernel 5.4.48 you were running with the intel_pstate
CPU frequency scaling driver in active mode, and that you are now running in
passive mode. As of kernel 5.8-rc1 by default processors without HWP will
default to passive mode. If you still have kernel 5.4.48, you could check.

Your Skylake system has HWP, and wouldn't default to passive mode.

However, you also mentioned Sandy Bridge and Westmere systems being unaffected.
Sandy Bridge doesn't have HWP, and Westmere might even pre-date the pstate
driver, I don't know. Anyway, this seems inconsistent with my "best guess"
above. Suggest you check them, with those same instructions from comment 1.

If you think, or conclude, that you used to run in active mode you can either
force active mode or force the schedutil governor in passive mode via the grub
command line to get out of your locked low frequency state.

-- 
You are receiving this mail because:
You are the assignee for the bug.
