Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB897C4167D
	for <linux-pm@archiver.kernel.org>; Fri,  3 Nov 2023 19:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjKCTeC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 3 Nov 2023 15:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjKCTd4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2023 15:33:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE371BD;
        Fri,  3 Nov 2023 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1699040026; bh=sFZn0NahGo+twcgbeOgB0GpkgC56iWuB39KBcaq2Kks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eJ4SRb6g134BOCaarbNbQicZ0+G38s29pUpYZG2CAPwcgF5pbVb3KwcP2RSW4EYLh
         nWhT0CaP2OocHTEFmAnrKGtkNH0i7ZmUOPujuGTW+jxaXIUHNK/cgP+XBQ84mcpbya
         irsIYfJPDRVUGh48HEf7D9fbg5syroQPZBWvwPs8=
Date:   Fri, 3 Nov 2023 20:33:45 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>, sre@kernel.org,
        Shyam-sundar.S-k@amd.com, mario.limonciello@amd.com,
        hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Backport of commit "power: supply: core: Use
 blocking_notifier_call_chain to avoid RCU complaint")
Message-ID: <ff242a4c-8c84-485f-a100-0317eaa1544b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913033233.602986-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear stable team,

I would like to propose the commit
bbaa6ffa5b6c ("power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint")
from mainline for inclusion into the stable kernels.

The commit fixes a RCU violation as indicated in its commit message.

Thanks,
Thomas
