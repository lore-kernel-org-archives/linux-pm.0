Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B436CC43334
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jun 2022 15:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbiFIPA5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 Jun 2022 11:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbiFIPA4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 11:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1054039
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 08:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9E3061D9D
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 15:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53253C34115
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654786854;
        bh=gHeok0R8n4/Q35t8c6QcDbx5Ab8nPLEAtlhHZSmNqrY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dj678LFdjrPNn1EaXvznfn69n6nCCXdkqUymgcctSb8z/HHtEcUESViJHyozhqEM0
         hEJzO8cxdxNU1xR5MIjb5Ri25EnhTmdse2A0ld4OdSRbUFj+CFu1IJ0yq3+BsVgoK8
         c43QxlnQHUjCucjmNSWlXx8zc4++fnhs5vSH8/lgkeD/ZvGlAmprMCTyozMiSi4tec
         969mFyhT8vzQVVG1AIP2z/jqm6KlJ8Y+SrZ9IAX31P11R9yS7+fz40R7qp2rIqOsYs
         kwdQB+kLptvwdPg2NvgDNGWYffZ6VGAo6LKwtGlTsl62hdhXE75ekaacPdI64NhSO7
         v+CYNrDze54Tg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3FB2CCC13B0; Thu,  9 Jun 2022 15:00:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Thu, 09 Jun 2022 15:00:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dev@alexmaras.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-NeEwDMY5YA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #10 from Alex Maras (dev@alexmaras.com) ---
Note - in the most recent test, I was limiting to 1gHz instead of 1.4 - res=
ults
are the same, successfully stating at 1gHz prior to sleeping, unbound after
waking from sleep.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
