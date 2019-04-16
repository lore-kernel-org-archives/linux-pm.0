Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9DDC282DA
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DE420880
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDZVaeNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfDPRob (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:44:31 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38759 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:44:31 -0400
Received: by mail-pf1-f182.google.com with SMTP id 10so10765030pfo.5;
        Tue, 16 Apr 2019 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kcerwDv9rfydLuyPfDFuOzevVHw43iM/CZvB7OrlnWg=;
        b=cDZVaeNxL2lYGxLNLJRLXzaeJDDGUe0j5N7Rgk13qs8q61EoC3coJ02CBy18Gf4yMG
         c9krFkPbVqGjJLpBQVliG/iSWtYvjSgjlKJmKaQz8hTNtZxrtvCrWy9IHTipTAQeZ5YO
         XJ5W7aMxzJCCvp6kG/FogeuMzPROgP4JnLnE2zijiUDXswJbkEt1IrgCi5RCvust25+3
         1PHxm6AGT1r1zsk2iy7YpsXjVCHZuGtKCTxD91TWgizA6XsoAarDmBW1MPLx67lwlqDY
         jVKs1XYGmZMArzy291qC/AIU30eQPPrItc+ORXPSaNffuIaGRtdbzE/2ZisRutyzHDlG
         CmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kcerwDv9rfydLuyPfDFuOzevVHw43iM/CZvB7OrlnWg=;
        b=fFg4ljH4wgk357XkEkJ2FdRgXcIgDqgDPfMcuW16Rsx411rGQdr+Hcp//svzY1n1gu
         0S09KKG1I/yJAHYD23SvaGJBQqV0i+xDU31gFKaNDoAn9iHyfg97uiRRUVsBPVYbsQUA
         jpOkYhxLQGiW7ZLPdULYpZ40EFld95DzFo0zunkDSJNqrSLXqUPF6TaoeqLvK7pDB7oC
         gqDBEMX3DnKVaOKNmYfYTYnWXHU5jC5VjVX4HJrRmqOdPO+G3SXurSxWFQyO9Vo6Wb06
         y4jQ1kvWRnfTWjLT5dV5Sh/cHWtc96/xO3jALbaZyFDE3q9T19DvLqkio5Mz3Nde2Pky
         GsfQ==
X-Gm-Message-State: APjAAAVnzxR7CfrI+7rgARw1vkl5yLf7hWcX4ZZDUlxLmSeTpy/EDKCh
        Uk+Q6QNmc7bs5MPOnUZJoxg8ISiG
X-Google-Smtp-Source: APXvYqw4YBmU3AXGgw91ygZBKywbojYBJ7Ac3b98j1lsYE5jHk6hmenK99uUu4Hq+Y4jcSSOxVIqXA==
X-Received: by 2002:a62:14c3:: with SMTP id 186mr85205839pfu.21.1555436670691;
        Tue, 16 Apr 2019 10:44:30 -0700 (PDT)
Received: from localhost.localdomain (KD118155013174.ppp-bb.dion.ne.jp. [118.155.13.174])
        by smtp.gmail.com with ESMTPSA id f20sm39763791pff.176.2019.04.16.10.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 10:44:29 -0700 (PDT)
From:   Yoshihiro Kaneko <ykaneko0929@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFT v2 0/3] thermal: rcar_gen3_thermal: Update calculation formula due to HW evaluation
Date:   Wed, 17 Apr 2019 02:44:12 +0900
Message-Id: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series was inspired by a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

This series is based on the master branch of Linus Torvalds's linux tree.

v2 [Yoshihiro Kaneko]
* As suggested by Simon Horman
- split into three patches
- avoid global variables
- marked thcode const

Yoshihiro Kaneko (3):
  thermal: rcar_gen3_thermal: Update value of Tj_1
  thermal: rcar_gen3_thermal: Update calculation formula of IRQTEMP
  thermal: rcar_gen3_thermal: Update temperature conversion method

 drivers/thermal/rcar_gen3_thermal.c | 93 ++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 32 deletions(-)

-- 
1.9.1

