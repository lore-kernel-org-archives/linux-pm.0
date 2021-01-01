Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5656C433E0
	for <linux-pm@archiver.kernel.org>; Fri,  1 Jan 2021 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7890F21E92
	for <linux-pm@archiver.kernel.org>; Fri,  1 Jan 2021 10:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhAAKM3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 Jan 2021 05:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbhAAKM3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Jan 2021 05:12:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EDC0321E92
        for <linux-pm@vger.kernel.org>; Fri,  1 Jan 2021 10:11:48 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 210993] New: Intel frequency scaling causes electrical noise on
 10th gen CPUs
Date:   Fri, 01 Jan 2021 10:11:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: karolherbst@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-210993-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210993

            Bug ID: 210993
           Summary: Intel frequency scaling causes electrical noise on
                    10th gen CPUs
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.9.16
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: enhancement
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: karolherbst@gmail.com
        Regression: No

One thing I noticed with my i7-10850H CPU is, that if there are cores with huge
differences in their frequencies (e.g. one at 900 MHz another at 4.9 GHz) some
electrical becomes noticable.

The noise can be reduced by limiting the available range the CPUs frequency can
be scaled to. Sadly the scaling_min_freq property is ignored outright and only
matters as long as the CPU stays idle, but as long as one core gets some load,
another one drops below scaling_min_freq, so I couldn't test if limiting the
lower bound even helps.

Putting one core at max load with stress -c 1 effectively eliminates all noise.

This issue is even more annoying on my laptop as it generally runs with the
fans turned off.

intel_pstate is used in active mode, but putting it in passive mode, disabling
HWP or even using the ACPI freq scaling didn't really change anything in this
regard. The powersave governor and default energy_performance_preference is
used.

Is there anything else which could be done to mitigate the problem? Just
putting a finger on the touchpad makes the noise quite noticeable as cores get
scaled to the max.

Thanks

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
