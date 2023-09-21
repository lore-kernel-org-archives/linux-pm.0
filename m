Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E36E7D0A6
	for <linux-pm@archiver.kernel.org>; Thu, 21 Sep 2023 20:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjIUURv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjIUUR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 16:17:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87341D3DDD
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 11:24:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31497C433C8
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695320662;
        bh=jsukAhtxH0F2DDgoxvyjirmFefdwBtVXOV8HQZ5M9aA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BQqJIdiNgtIWSanYWS+6vakG8uu+RzzQY5DnjSZSnxq+YYGxlnvzuERaS+9hBjBwr
         MLndsZ8hV7Lm7UwXZUcwJtiLyK+O+qFBjDnC86/fnYHML+nvc53WHh38yZih3Gs23e
         kp9roL4ywhQyF+7dAEbFlA3U743OrcZd7E/rr/ZcrRmxUAIHmEnz1YFfbyFjuTuF3Z
         mMQbKJmgh74AGqR2eMtg7na0w6SvWBMTcAbNzONHl3n+wuMOFLf6IYMbcqxiWcnlLO
         5eibg2sqnPgQVqZXoGLS5OpE+4PREZ9hJlzk/I7CqteaEsXvMlq0EwPxi4ahYeKA8Y
         jbTyjfF9isYow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1EB7EC4332E; Thu, 21 Sep 2023 18:24:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date:   Thu, 21 Sep 2023 18:24:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: hej@hot.ee
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217931-137361-8qPKUic4SK@https.bugzilla.kernel.org/>
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

hej@hot.ee changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hej@hot.ee

--- Comment #7 from hej@hot.ee ---
I'm also looking for a way to contol min/max frequency. I tried active, pas=
sive
and guided modes and was surprised none obeyed scaling_max_freq.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
