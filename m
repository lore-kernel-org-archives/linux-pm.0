Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A845C43334
	for <linux-pm@archiver.kernel.org>; Fri, 15 Jul 2022 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiGOJgA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGOJgA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 05:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469E7E80A
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 02:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43FFB621A8
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 09:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1838C341C6
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657877758;
        bh=znnugMjFlCS75fEEMOxiGowh+ml+P/gSJUbc5P+aNg4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cnSnv0FDVmstYzGxQt2M3xDMzwuv1tK2vIwuSPG2XceFoUqGR2+UykvYv/cxBFlkp
         YWe5tQiRJt2zCGtWz/8akRlMCimkAO43NykIkcUDZugKnD/xqecJLUdwDBsokSfkMd
         xGKIA1D+SYXm3qpsIO2uJLErWs9sAeFvce85ckuT3FNKPO9Eg0DJc+Oa71DicZ8ysA
         hjhSg9AAfZEffKFfh5SAnGW60093fLwzNovT4bl4WiadKRwnZb/cq+u0VA5FJVIql7
         brfIF5xr6Yr42WEXPMJ71vIboPjDOYeyIO4ZsTvg41WZffBEwqqoPuuzgV5+T29Cmv
         gM3uBhmJg4Smg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8C256CC13B0; Fri, 15 Jul 2022 09:35:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 09:35:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.description
Message-ID: <bug-216248-137361-30j1IQRuEj@https.bugzilla.kernel.org/>
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

Arek Ru=C5=9Bniak (arek.rusi@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #301434|more debug stuff            |dmesg with more debug stuff
        description|                            |

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
