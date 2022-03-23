Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5120C433EF
	for <linux-pm@archiver.kernel.org>; Wed, 23 Mar 2022 16:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbiCWQFn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiCWQFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2022 12:05:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C98414094
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 09:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A959D617EA
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 16:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A7D6C340EE
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648051452;
        bh=SbOt6EF3kJm0POVpukXp2YHHYQFLqnRNYFv6og6x5Cc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AY88MjtHNDjHRnvKUzoZN2WMlTe0+Mu9xGA3E7cDkdACTeb0s8nWthpR9koP4Obc0
         dZVWx5UhvLtvwBX1XdWMxiUpDeY+d4xOyudYt8P9r+hUoa9xiiRPbimkoLJFgr1fMl
         tL9/AltJLlU6zovbqLQIqDF1QWdcvCB6FQxjgC/M7sCLCZe4dYWANQ7NGQtcDiG6io
         4rPS0fBLuIwGz9AVS4zRqR2rrikfSkwWRe6S3xJWFNB1JqmnyxDrYZGQ8acJPimG25
         BIT4BsO1qs2mWEuLI6EWEH3DUKFRI2ga8nN5i/Q1HTlnHGiGWvOdQamlA08KZrYbVv
         6U8O1DnQ763nQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DD821CAC6E2; Wed, 23 Mar 2022 16:04:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Wed, 23 Mar 2022 16:04:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215729-137361-yksT1W44e7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
The conservative governor idles around 21W which is good but this governor =
is
very undesirable for a desktop system: it's too slow to react to instantane=
ous
spikes in workload and it makes e.g. web browsing far from comfortable.

So, with amd-pstate in idle:

Powersave and performance (!) governors ~ 20W.
Conservative ~ 21W.
Ondemand ~ 23.5W.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
