Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C155CD80CA
	for <linux-pm@archiver.kernel.org>; Tue, 10 Oct 2023 12:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjJJM5N (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJM5N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 08:57:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636B91
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 05:57:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E1D4C433C7
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696942630;
        bh=obVvDhqmX1/iLVJp32W8HabOhb0KZAiky0JRn/bIzDs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SAtr9JKg/JqzEY/OivAuP/NHqumMnyYg+EfXXgphNYeXNHEBI4IH+z2okzH3h7684
         xRNgGWr/24mekyrbLzMn6IcqX7qGoEt41bY2Nk1GrBTqYYRqsVm5pTtjnzRolbooR9
         uGKxs3CIOVB8dedGXC3G+Wbn4YumSjeiHig+HhmicfZwdmbfQ9dPm6L5GIByBRrDxx
         DKkn6OiMQC5yoyBuIkaxjiMbxo2uwPjCriCf3kh3r+4fUPNKgT5FtSU8LSsDZ790+F
         AVCMRt4OTj5/Bk7ScfriRxFE1IzJu6Mj9TIBd9tGJkO2oLkn0He+5jaLAfteFx3RtD
         +DIEx75yksPww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 42219C53BCD; Tue, 10 Oct 2023 12:57:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Tue, 10 Oct 2023 12:57:09 +0000
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
Message-ID: <bug-217931-137361-dxZLOiWZC8@https.bugzilla.kernel.org/>
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

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
Mario, it would be great if AMD devoted some resources to adding these
features.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
