Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15017CDB474
	for <linux-pm@archiver.kernel.org>; Tue, 17 Oct 2023 17:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjJQRMP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 Oct 2023 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjJQRMM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 13:12:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780FFB0
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 10:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FCCBC433C9
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697562731;
        bh=VWFx4FShPcY0dWNyb5q2KqEV5+VedYFgT/o9bRSc9wU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bO0Usu0knQ5BDTAaf+f5KOuza7yIBeKDgc98XVjsLU3XFUFomRowT5s9oLZnC9EGZ
         kk04SDYrJllPqtSmC7k164pya178qu7D5YkjLQ1YDwfOPjJYUHwdtIn0A1Pj1AHpRI
         FAjJ9+GgAw9FEqR/gmY46BjL06hAFwqJRjSgmdy0FXV5jd+VyW6Qd5xe2zkD/QYjni
         DXPZezREzEfDiYba4mh4ceIh9P44SR3q50Kl3R67vPiMW43Qmld4JRJSimGQZrMlNk
         8hFGmALmUvUgfYPLgp551pRGnMTnjPavLLpAACTtJsEt1BvoICmbFvhADAYy4ZOj8U
         QNpNSgc5jyq2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0E675C4332E; Tue, 17 Oct 2023 17:12:11 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Tue, 17 Oct 2023 17:12:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218022-137361-oJoHvwtVOE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218022-137361@https.bugzilla.kernel.org/>
References: <bug-218022-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218022

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |5.15.122

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
