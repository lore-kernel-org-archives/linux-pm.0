Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B40C433DB
	for <linux-pm@archiver.kernel.org>; Wed, 27 Jan 2021 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A86560C3E
	for <linux-pm@archiver.kernel.org>; Wed, 27 Jan 2021 21:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhA0VS6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Jan 2021 16:18:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234046AbhA0VS5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 16:18:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B3B7964DBD
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 21:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611782296;
        bh=TzdhVay1S3fLpodW5VHYj8yauypBbknm+iylOJ1ihLE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u4jepmnoigYwI+knipeHGJWQT7t4H8YkpxduIftHnEaQkbwuVqPvMPWXaL+Crr7CA
         B8YSabHBjiRXiIWuuZbvC2lUbA/G2EVhcHkA6wKfYIu+rHUUpLnfM54EizQp3JCdNX
         IhyY9F6phxKCz8cbQfkVtmf9/OAehhdV50yoAG/nniNoUlo87vRY+lu5hDOEQsmkF3
         KR203FODzHqDoHjRzT/mtaFLCwfXTN4+VrWgJLC9lijUF44LRH8jdTc+2bqQVasJbh
         BLJwqK/yVzca9VE2X8VDuoHHSul44UIPhrr9HskEnl4d+j/D8O8v2MOwVQ2/LEcbTq
         DcDe4CAkxkfRA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 211305] schedutil selects low P-States on AMD EPYC with
 frequency invariance
Date:   Wed, 27 Jan 2021 21:18:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ggherdovich@suse.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211305-137361-4z3OufyC2O@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211305-137361@https.bugzilla.kernel.org/>
References: <bug-211305-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211305

--- Comment #5 from Giovanni Gherdovich (ggherdovich@suse.cz) ---
A candidate fix for this problem has been posted to LKML:

https://lore.kernel.org/lkml/20210122204038.3238-1-ggherdovich@suse.cz

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
