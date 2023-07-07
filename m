Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C878EB64D9
	for <linux-pm@archiver.kernel.org>; Fri,  7 Jul 2023 15:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGGPX6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGGPX5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 11:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDBAF
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 08:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B360619EC
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 15:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD8D2C433CA
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688743435;
        bh=uZfwXRPek/o2wNOqWrmVvNMnpjP3RzuCvVr5RB0+8C0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GFJmqLD87ewPaXB7ioxF0XjV0rbm67HCZCJRyS4UCoJwjaHZfcddO1Vz9ney7oQCh
         Lw093J0j7WxpUgQ113zPvme1+EYXQTLLyvBqfgR9QO6ggdafuNA7fvapk9t+Gtaxns
         7yg+DJYcybXgVsfdrZAo0kVreH/k8AxJKGegda0t/R5/2qPbR5Gbc9Zumwl+aw/f6g
         KQiwazZ2UYCMLoB1CzgLYsS2O6yKH6novM7VdHUczIZhGFHpmZWdcXAgXLwKYsyOSx
         m9hBBZpNARUyLlI68iXzAx+V4aT7KO6bgf6qOCs2lSWbcmKRRycwSfRCa0WG2mZ0I7
         lFG6QxJ7OqeGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C159BC4332E; Fri,  7 Jul 2023 15:23:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Fri, 07 Jul 2023 15:23:55 +0000
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
Message-ID: <bug-215800-137361-30B9ImeF7B@https.bugzilla.kernel.org/>
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

--- Comment #30 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> It's a little bit confusing though, as in Windows I can perfectly set min=
imum
> and maximum CPU frequencies and I totally expected this driver to actually
> allow that.

I suppose I'm confused as well.  Windows should be using EPP as well, and
various software constructs like the power slider will be changing that bia=
s.

Maybe you can better explain exactly what you do in Windows and exactly wha=
t is
happening.

> Lastly the documentation mentions: energy_performance_available_preferenc=
es,
> the file that I don't have.

Eh?  Didn't your above comment show this:

/sys/devices/system/cpu/cpufreq/policy0 $ grep -r .=20
energy_performance_available_preferences:default performance
balance_performance balance_power power=20

> Lastly there's no boost configuration support which is available both for
> acpi-cpufreq and Intel's native CPPC driver.

Something seems quite wrong if you're not getting boost support.
It registers for boost, see
https://github.com/torvalds/linux/blob/v6.4/drivers/cpufreq/amd-pstate.c#L1=
121

> It's worse than acpi-cpufreq from seemingly any PoV. Maybe there are some
> advantages for APUs but on my desktop I only see major disadvantages

I /suspect/ what you'll want to do is change the scaling_governor from
'powersave' to 'performance' for your desktop use case.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
