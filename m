Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB84EB64D7
	for <linux-pm@archiver.kernel.org>; Mon, 26 Jun 2023 17:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFZRdA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Jun 2023 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZRdA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 13:33:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B3C2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 10:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A0D60EF4
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 17:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65F58C433C9
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800778;
        bh=DrykSvCzp190fTSspB9kfF+PX8N5VEZ4kOuu4FZZkEQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AD5f8KFIsLtihSPMcHfsswYcTr2uiWevkWtmv8daGY+hSSlAD2MYLDaKjztY+iox0
         ka0F9F4nUr7CvLtjL+RDznAynPsfCvTjbqJkjCd5EBPpH8smdV3moOlOf9lhzVQjp/
         SbFBEdQQ5vgnulC50sT56YD7d+5Nd7PjMYS33gaZ0NspUth7VHSK7HxNO8NpYmncTI
         G2DgtrJWHpAgH83bjrk5DK9zi4jIK48PkiyTUPVc2zJwqo+ys3hTufOOdrMbD5wT0T
         TDR/ABy58GcFTRuQfzMs6jgaDARZl8Iterp54Yst59jdKVoU6y0VEBtqozqyqBZ3lj
         laviYXl4qKQkg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4B933C53BD0; Mon, 26 Jun 2023 17:32:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Mon, 26 Jun 2023 17:32:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bjackson0971@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217589-137361-xG6QlAGJ2Q@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

--- Comment #9 from Brad  Jackson (bjackson0971@gmail.com) ---
Before:
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
1112c46
10d1a2c
10d1a2c
10d1a2c
10d1a2c
10d1a2c
10d1a2c
10d1a2c
10d1a2c

After:
10b2c44
10b2c44
10b2c44
10b2c44
10b2c44
10b2c44
10b2c44
10b2c44
10b2c45
10b2c45
10b2c45
10b2c45
10b2c44
10b2c44
10b2c44
10b2c44
1081a2a
1081a2a
1081a2a
1081a2a
1081a2a
1081a2a
1081a2a
1081a2a

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
