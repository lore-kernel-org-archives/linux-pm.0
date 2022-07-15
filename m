Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB2CC43334
	for <linux-pm@archiver.kernel.org>; Fri, 15 Jul 2022 17:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGORcu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGORct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 13:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706A982FAE
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE12622A0
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 17:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 671B9C341CD
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657906368;
        bh=R9Gpc85l4nGZSW5tbzbNbY4CUgNp5j/mQNgemttGU04=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U3xUjp48jZjK56dT3jYM730FmrggoDA490ONLTfyaouErFsmsQ24q2igWPYcVcv/7
         2R+pXVSGmwb1+MS4A+K6SlNmpAceH5oy5ykde2R9w6Hxbh54/j98bD0SGM5m1osQJK
         vBoWYhaVeK+KSGmP2Ao007E2Drh6yLbwhEvEUMPqlyGJqcfHY3mrJLgWpZmuT1b+gm
         Fv176IMkYYCXXrEPPIVAxy/CsOBXrHnUN2GBZqqTLRu+lQHMTKt+9TuX5bJb2OxJCU
         lo9ilSqdxJLzjdgRfwXaL0uTJuDOT/FPBPuDRgbkKVrgPuFRnrbjQKg4tFw03vsVK6
         pBWLyBCn71Jrg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4AF36CC13BB; Fri, 15 Jul 2022 17:32:48 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 17:32:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-drpoQpMHVg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #17 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
*I mean 5.18.12*

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
