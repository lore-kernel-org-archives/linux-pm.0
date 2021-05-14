Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E6CC433ED
	for <linux-pm@archiver.kernel.org>; Fri, 14 May 2021 02:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA486143F
	for <linux-pm@archiver.kernel.org>; Fri, 14 May 2021 02:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhENC3B (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 May 2021 22:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhENC3B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 22:29:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C36286143F
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 02:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620959270;
        bh=mJ94wVE6TVH5yjMt5fOJa1cu6nSG1nFydbItKBPLRDo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IarLyqTuHjGiEsa2FSYWx3FjvFZFgOvXr7VADFPaVh0IE1AjiZfeF1Rt8ZGDlGcH5
         /ogh9NNJ/EHAeOlgTK5POguFtBgTP8RhZ0FjCkYxyGJkq4YvYtZbMcUmGLP2JmI/0o
         SSBDv4OdzormPCJsjZGZTRbAuWQVMAbKQHWPEsSCuTPXTx3mUUo6F32y0q9HbQ0jrT
         vZ634zhrkS4FzJtiwXJhC1YgIS/2A85tdDBfHIR+F823lvzVJIS52CJTOoYyhCrmAa
         kh4bTN/vx8Nm/Jjf3LfRJOhExwh1oaViRp0dqZl1CkxLzqKdZ6yCz2a0wBTaksd8A0
         hUHL+48rG+Dzg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211791] AMD CPU /proc/cpuinfo reported max potential boost
 frequency instead of actual operating frequency
Date:   Fri, 14 May 2021 02:27:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: huangrui@mail.ustc.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211791-137361-PSFs0YI46D@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211791-137361@https.bugzilla.kernel.org/>
References: <bug-211791-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211791

--- Comment #6 from Huang Rui (huangrui@mail.ustc.edu.cn) ---
Fix patch is merged into tip branch:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dsch=
ed/urgent&id=3D3743d55b289c203d8f77b7cd47c24926b9d186ae

Thanks,
Ray

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
