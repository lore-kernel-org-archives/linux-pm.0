Return-Path: <SRS0=Ra4R=CJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CFCC433E2
	for <linux-pm@archiver.kernel.org>; Mon, 31 Aug 2020 06:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1568920738
	for <linux-pm@archiver.kernel.org>; Mon, 31 Aug 2020 06:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="mAOYD9hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHaGRw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:17:52 -0400
Received: from st43p00im-ztfb10061701.me.com ([17.58.63.172]:35013 "EHLO
        st43p00im-ztfb10061701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgHaGRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 02:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1598854273; bh=jSqA1xFOAUD+TvU762gDeCqD5FhoITDAzXme6KHer7M=;
        h=From:To:Subject:Date:Message-Id;
        b=mAOYD9hrwveXdGKn2YRbw7cyuI9uOPjWNCqCjytOo3A0ipQ0PRb8gSqHgNdLAzFK/
         ifBQFwZII0jUB+U7ThR+47J2VkGAiitzkJGb612/TW6hHI37XE8ZpolylVt+VQs6SD
         2OpkuxRYzrSkotrnhiHi1rjHQQFslTk3w8DuJfdiuPSH3jhL0wkSaerzpbgyCsfPXl
         GaXQeHPB+YbxoqEaJ2NauxVa4GUK806FKMTa0ZKS2pvivt6pOYeewX6H6mG2XA4F7G
         8uDexGJ97yIi04EzKUzzaDiEa6wj8fICydmF8n2oQj8OEM/yyTZnVz1Gse9K1zQyEx
         FaNoms7IBHxIw==
Received: from localhost (unknown [80.214.144.204])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id A4AD3AC036A;
        Mon, 31 Aug 2020 06:11:13 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 0/3] Enable CPUFreq for STi stih418 SoC.
Date:   Mon, 31 Aug 2020 08:10:10 +0200
Message-Id: <20200831061013.4327-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_01:2020-08-28,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=789 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008310043
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This serie enables cpufreq for the STi stih418 SoC.

Alain Volmat (3):
  cpufreq: sti-cpufreq: add stih418 support
  cpufreq: dt-platdev: Blacklist st,stih418 SoC
  cpufreq: arm: Kconfig: add CPUFREQ_DT depend for STI CPUFREQ

 drivers/cpufreq/Kconfig.arm          | 2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/sti-cpufreq.c        | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)


