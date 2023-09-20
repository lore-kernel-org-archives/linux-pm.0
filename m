Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A82CE79D0
	for <linux-pm@archiver.kernel.org>; Wed, 20 Sep 2023 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjITN2w (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjITN2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 09:28:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3F8AB
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 06:28:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D326BC433CA
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216525;
        bh=mL+8J8YRgeSGPZu2tuzQ4MqCWyRTe6hkr0LhE7dy2aQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gTxagcWCZy8Ryu1e40hykX+1/VQUhyRmq06xGZqoMu/Ah4ZXeJg+kZyNfu1wGi9aU
         XlUILpyx2se/p5hm5mgDS5c+3orf9bTg8Y+Oio5H9muKBovUOds2dkJto8NWv+cl/G
         YzHWYF3G7FlBYxXPnshfxJDL19GgYhK3QPKNNFLJjKtWZyKadUAi9P6A5CeGU6vfux
         M2TQRaq0UNrwqPmarUgCGEti7YFyIzuyh1PyD3bp2+I+l9OUxNRP87TGrtowg6RcPL
         0qdlHfFAJoP5LrckqSaY+xPLs86e9fZZimJmRzaCL8ytVO6vJQUoLObX9By6vR4S10
         AVsV8eGkSyAhA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B8EE7C53BD0; Wed, 20 Sep 2023 13:28:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Wed, 20 Sep 2023 13:28:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-th7FSsu4Yz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
> ondemand, conservative, performance?

(Intel|AMD) CPU pstate drivers work differently and those are ignored:

https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html
https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_pstate.html
https://wiki.archlinux.org/title/CPU_frequency_scaling

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
