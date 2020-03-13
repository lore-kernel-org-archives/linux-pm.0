Return-Path: <SRS0=GPgV=46=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C66DC10DCE
	for <linux-pm@archiver.kernel.org>; Fri, 13 Mar 2020 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7C5206EB
	for <linux-pm@archiver.kernel.org>; Fri, 13 Mar 2020 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584122250;
	bh=scJcWT2vJcl91+Z4McFhqKmdpOAJU7p9JnspO5sOidU=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=13iKXbcqppFX2zX2dBENVYedyk3y++/fYMJRjnOESaU/PUDB4IARsqOgQcSHPbkd9
	 w7EMD/51ilLWrFxHKdgGcga8Y0J37DpKvWmuLrrRIWNF5p3JxEhZetOeM5IXA6kTMf
	 sQ3Menp86d5ztY15sq7wqWIJvcvz820cDg1khVP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCMR5a (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:57:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41772 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCMR5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 13:57:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id s15so11004979otq.8;
        Fri, 13 Mar 2020 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kLdCsylq7ymvsLWW1Tomdsn2gQzxTDWi2whnqygK6E8=;
        b=crn+EoBRDxNCs4yLokjdGnB0IF8CdtJr8HtGcg/pFU4+oLyV0mR+33cE0+XvB5Ev0+
         VNqcW9LtUXfexaMhb38N42qH2/E2HyZm6jlPp/ZsoqXZmqNWxTuB2E2wmQfrobZ3i/fP
         l7dPjC1UPolNLWfkGXgkzc/QcipQ3ypXdFv5BNIKCphDoCtupgtCILdkvOTETGGwFTDx
         cvSIdgD2mBqsManudZ8/evRvBIwmTeF8F0dLNCgpVZRo+LYoBR4fKkQm0SJ4/xkGQ1bo
         vXAlXoiiAKPOcSGX+lWmybgwROgZIGEnycGnX2VUtMxZGCijjcBC2kLiXlb9AnBIG1px
         TZXA==
X-Gm-Message-State: ANhLgQ1rJZFMAE1S7LXqfbvEp9KFD9AOwhaItfm+tIVcCW52KiAB/gco
        UAxNhy1lVchSUi8ALU0d+SdQUx+3jbk/me1ZBUcKyUfu
X-Google-Smtp-Source: ADFU+vtweMgXIzJn2iPLwZF3jGereyWgy3X44S6BAEkg8nTVJYfPgZLH6IbraHsv5pyOvDW7Ro+68vaNw/6kklmhv3g=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr11654242otl.118.1584122249475;
 Fri, 13 Mar 2020 10:57:29 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Mar 2020 18:57:18 +0100
Message-ID: <CAJZ5v0jcZsixVWpfb=OkWNPD8Q=DC-Q-gvEzLh7vkCksT3a0HA@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.6-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.6-rc6

with top-most commit bce74b1feb01accc6654a1f3e37958478d3a4fbc

 Merge tag 'linux-cpupower-5.6-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux

on top of commit 2c523b344dfa65a3738e7039832044aa133c75fb

 Linux 5.6-rc5

to receive a power management fix for 5.6-rc6.

This fixes cpupower utility build failures with -fno-common
enabled (Mike Gilbert).

Thanks!


---------------

Mike Gilbert (1):
      cpupower: avoid multiple definition with gcc -fno-common

---------------

 tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c  | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c    | 2 +-
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)
