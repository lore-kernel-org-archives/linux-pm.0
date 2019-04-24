Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC69BC10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24612148D
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfDXHoW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:44:22 -0400
Received: from shell.v3.sk ([90.176.6.54]:39465 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfDXHoW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Apr 2019 03:44:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BF0FB102E7D;
        Wed, 24 Apr 2019 09:44:16 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yRCO-58-N-WB; Wed, 24 Apr 2019 09:44:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C35A1102E46;
        Wed, 24 Apr 2019 09:44:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g2tevjlc7OYb; Wed, 24 Apr 2019 09:43:59 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3FEFD102D4D;
        Wed, 24 Apr 2019 09:43:59 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 0/10] Add support for OLPC XO 1.75 Embedded Controller
Date:   Wed, 24 Apr 2019 09:43:43 +0200
Message-Id: <20190424074353.458446-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello!

This is a sixth spin of the patch set that adds support for the Embedded
Controller on an OLPC XO 1.75 machine.

Compared to the previous version there are only some trivial-ish changes =
to
[06/10] and addition of Reviewd-by tags; as indicated in changelogs of
individual patches.

In my opinion the first seven patches are ready for merge as they are:

  [01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
  [02/10] Platform: OLPC: Remove an unused include
  [03/10] Platform: OLPC: Move EC-specific functionality out from
  [04/10] Platform: OLPC: Avoid a warning if the EC didn't
  [05/10] Platform: OLPC: Use BIT() and GENMASK() for event masks
  [06/10] Platform: OLPC: Add XO-1.75 EC driver
  [07/10] Platform: OLPC: Add a regulator for the DCON

The patch [08/10] relies on changes to the OLPC battery driver that have
recently landed in the power-supply tree (without them enabling
CONFIG_BATTERY_OLPC on ARM would break build):

  [08/10] power: supply: olpc_battery: Allow building the driver

Sebastian Reichel provided an signed tag of an immutable branch that has
the necessary bits and was merged into the power-supply tree for 5.2:

  git pull git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-=
supply.git psy-olpc-1.75-battery-signed

The patch [10/10] was split of from the rest because Russell King found t=
he
patch [09/10] it depends on possibly objectionable. They should not be
applied without further input from Russell:

  [09/10] ARM: export arm_pm_restart
  [10/10] Platform: OLPC: Add restart support to XO-1.75 EC

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

Lubo


