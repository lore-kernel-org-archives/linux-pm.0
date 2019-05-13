Return-Path: <SRS0=BJcq=TN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A19C04AB1
	for <linux-pm@archiver.kernel.org>; Mon, 13 May 2019 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F3920B7C
	for <linux-pm@archiver.kernel.org>; Mon, 13 May 2019 07:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfEMH5F (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 May 2019 03:57:05 -0400
Received: from shell.v3.sk ([90.176.6.54]:58973 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfEMH5F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 03:57:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 140B31041D5;
        Mon, 13 May 2019 09:57:00 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id l_tv8hpnCrVG; Mon, 13 May 2019 09:56:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 780911041D4;
        Mon, 13 May 2019 09:56:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OSSsoosaKfwr; Mon, 13 May 2019 09:56:43 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id F36101041BC;
        Mon, 13 May 2019 09:56:42 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v7 00/10] Add support for OLPC XO 1.75 Embedded Controller
Date:   Mon, 13 May 2019 09:56:31 +0200
Message-Id: <20190513075641.1277716-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello!=20
=20
This is a seventh spin of the patch set that adds support for the Embedde=
d=20
Controller on an OLPC XO 1.75 machine.=20

The only patch that changed since v6 is [06/10]: there are fixes for
problems reported by Julia Lawall and the kbuild test robot.

The patch set depends on changes to the OLPC battery driver that have=20
landed in the power-supply tree. Sebastian Reichel provided an signed
tag of an immutable branch that has the necessary bits and was merged
into the power-supply tree for 5.2:=20
=20
  git pull git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-=
supply.git psy-olpc-1.75-battery-signed=20

The patch [10/10] was split of from the rest because Russell King found t=
he=20
patch [09/10] it depends on possibly objectionable. They should not be=20
applied without further input from Russell.

Thank you,=20
Lubo=20


