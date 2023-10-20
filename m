Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E2CDB47E
	for <linux-pm@archiver.kernel.org>; Fri, 20 Oct 2023 05:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjJTFig (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 20 Oct 2023 01:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjJTFif (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2023 01:38:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E81119
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 22:38:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCA7FC433C8
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 05:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697780313;
        bh=noQgPPA00aNEUvvlxgKmXKUrTQSfqb6mM+G+S1O8Is8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CRSIf2tsOYF+T3KANhZaS0tuwZppSZ4zwJTSfj5rpu8C6QettLDRs7o4cO9IZy5se
         UuMVqlhYLppPYJlaAiIxrSP4djWUd6Su9s9QiH1wOkXJAJKk52Wu1wIy688SBIYjoy
         MD0OdNUHmNi5ESXQdPYUUur16YTBgojjgsvVbjzNhckkBg7Ms38rzcyWMQxztp9Yjp
         Yau7n4tyIzSMN9jXaHQZZkHShzTyLoLOVjQapfvwQ6vRkjrcGkJhZKGj9BzXnYGOa+
         DRromFufs2YxHhQxLd/f7ZTECncQo4Xi3TBET+YmFHLpll3OfGvuVqT+j5hTHyx4vR
         XDgw7tCVc7qVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C327BC53BD2; Fri, 20 Oct 2023 05:38:33 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Fri, 20 Oct 2023 05:38:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218022-137361-Gem5G59lsw@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
