Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A2C433EF
	for <linux-pm@archiver.kernel.org>; Mon, 14 Feb 2022 06:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiBNGn7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 14 Feb 2022 01:43:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiBNGn7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 01:43:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C74D62F
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 22:43:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17F47B80B97
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 06:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB081C340EF
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 06:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644821025;
        bh=spCupgKGS2ypzXag3fKX3IgPgRyZGDJZjM2OrISbjhY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DelNXpf4Dvndvq8doPDCWplyVZbYskwXmpJ78cFlFFfDnrlt2nxEGcgw2x1uz6Gn/
         9eenCFEPaw/cdO/D+TM7Qiwg2HXzIdQlvLcWmCjLeGwtn8hHJnpQbQXDLCs1Hd2IB7
         MjMmWKikuatikf7sz3gGZ6EdadHLsVewTOolGVR0N6KY3qICDYRkFV0GJ9DuwaEj2p
         qy7M5PevwFwW2sm14teXS6HcMFXoPEmis9rRhQmSTOaZbT1JKbCk5q8U1OOfdFa/+H
         GBbna1lCorWNmW5UgeWaAC3RjovukgZ5itDwjvBjBsXvNoJICI7rDQZF/6KrA+NEvI
         svPAhI2KFICLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AB76BC05FF5; Mon, 14 Feb 2022 06:43:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTU1NzRdIEZyZXF1ZW5jeSBib29zdCBkaXNhYmxlZCBi?=
 =?UTF-8?B?eSBkZWZhdWx0IG9uIEFzdXMgUE41MCAtICBBTUQgUnl6ZW7ihKIgNDAwMCBT?=
 =?UTF-8?B?ZXJpZXMgUmVub2lyIE1vYmlsZSBQcm9jZXNzb3Igd2l0aCBSYWRlb27ihKIg?=
 =?UTF-8?B?VmVnYSA3IEdyYXBoaWNz?=
Date:   Mon, 14 Feb 2022 06:43:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rui.zhang@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc short_desc
Message-ID: <bug-215574-137361-odhE4DBZoG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215574-137361@https.bugzilla.kernel.org/>
References: <bug-215574-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215574

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rui.zhang@intel.com
            Summary|Frequency boost disabled by |Frequency boost disabled by
                   |default on Asus PN50        |default on Asus PN50 -  AMD
                   |                            |Ryzen=E2=84=A2 4000 Series=
 Renoir
                   |                            |Mobile Processor with
                   |                            |Radeon=E2=84=A2 Vega 7 Gra=
phics

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
