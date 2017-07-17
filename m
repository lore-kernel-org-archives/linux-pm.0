From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 196263] powersave broken
Date: Mon, 17 Jul 2017 01:42:50 +0000
Message-ID: <bug-196263-137361-lSF12Sem0Z@https.bugzilla.kernel.org/>
References: <bug-196263-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:55530 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751221AbdGQBmw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 21:42:52 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 517A927DA4
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 01:42:52 +0000 (UTC)
In-Reply-To: <bug-196263-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=196263

Huaisheng (yehs1@lenovo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |yehs1@lenovo.com

--- Comment #4 from Huaisheng (yehs1@lenovo.com) ---
intel_pstate belongs to SETPOLICY implementation, acpi-cpufreq belongs to
classical TARGET. To some degree intel_pstate's powersave is similar as
acpi-cpufreq's ondemand.

Personally I prefer intel_pstate which offers better experience.

If reporter doesn't intend to disable intel_pstate, perhaps reporter could
consider to modify max_perf_pct to minimal value as min_perf_pct.
/sys/devices/system/cpu/intel_pstate/max_perf_pct

-- 
You are receiving this mail because:
You are the assignee for the bug.
