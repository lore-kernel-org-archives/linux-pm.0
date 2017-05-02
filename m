From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>, MSI X99A
 SLI PLUS i7-5820K,  MSI i7-5930K, MSI X99A Raider i7-5820K
Date: Tue, 02 May 2017 15:54:42 +0000
Message-ID: <bug-176411-137361-8tNxypFtVS@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:57806 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750770AbdEBPyr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 May 2017 11:54:47 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id ABB6628387
        for <linux-pm@vger.kernel.org>; Tue,  2 May 2017 15:54:46 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #35 from Mike Lui (mike.d.lui@gmail.com) ---
(In reply to Len Brown from comment #30)
> Mike Lui : 
> 
>   - disabled on-board OC'ing
>   - disabled intel c-states
>   - enabled turbo-boost
> 
>     After this the issues in comment #1 are no longer present.
> 
> @ Mike Lui
>     Can you verify that there is no problem when you use SETUP DEFAULTs?
>     or at least return C-states to their default ENABLED setting)

I got caught up with work recently and just reviewed the comments, since my
last comment.
The problem appears to be fixed, for me. Unfortunately (or fortunately), the
solution was a simple UEFI BIOS update. This points to a problem in the
firmware, for my situation, which explains the intermittent nature of the
problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.
