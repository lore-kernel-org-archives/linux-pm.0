Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BE8EB64D9
	for <linux-pm@archiver.kernel.org>; Fri,  7 Jul 2023 14:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGGOv7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 7 Jul 2023 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGGOv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880941FD7
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D462619C4
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 14:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C0BC433C7
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688741514;
        bh=OMVwRopbxuuI2S8t7eNuyHinIW4UrDt/WlkBRSB08vc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YrxFpsUYZxeREx7Kb41CFRZzgJHB/TEnz+T/cR5gic6GAq52fEMjjTjLcGzcJZI3G
         5ADVvUX5gZSbgHpg9AUq/S/YRexucyeVEvcxqVNC0h8Qy57haiKyhD1oOmYXZrz0wI
         COYBdIZLIbRn7aUKE/4QAtjdP/10Rkupi/l2sR0oYib7/gP0QcQDb15AGB6tyZvjh7
         DE7C2TzACN8OXHtbkA8YGdWk7Qja8mkGaAGwW6Bps9eW5mPLCrDehgVLr67TzVNZD4
         Mxk/8V4DggBm2e0UNEddt7bVKqArw6S0vI0vh42QzEDMMmvYObRIF+NiTQlNam0C/J
         pIIxo1C5qzrOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 63A26C53BD3; Fri,  7 Jul 2023 14:51:54 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Fri, 07 Jul 2023 14:51:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215800-137361-3oTN9it7zM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #28 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
When you're using active mode (EPP), the hardware is choosing frequencies a=
nd
software only provides a hint to set bias.

You can read a little bit more about active mode at
https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html

What you should be doing isn't trying to set specific frequency targets, but
rather you should change the values of 'energy_performance_preference' to m=
eet
the needs for your workload.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
