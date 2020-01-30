Return-Path: <SRS0=mkYT=3T=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEADC35246
	for <linux-pm@archiver.kernel.org>; Thu, 30 Jan 2020 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FFC214AF
	for <linux-pm@archiver.kernel.org>; Thu, 30 Jan 2020 14:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgA3Orm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:47:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51265 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgA3Orl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 09:47:41 -0500
Received: from 79.184.253.19.ipv4.supernova.orange.pl (79.184.253.19) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 41d897d1c2f42d75; Thu, 30 Jan 2020 15:47:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH 0/2] intel_idle: Two new module parameters
Date:   Thu, 30 Jan 2020 15:44:40 +0100
Message-ID: <1720216.0Jr2BLnqKp@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

This series adds to module parameters to intel_idle (on top of the material
already in the mainline since Monday), one to make it use ACPI even if that
is not enabled for the processor model present in the system and the other
one to allow passing a list of idle states to disable by default to it.

Details in the patch changelogs.

Thanks,
Rafael



