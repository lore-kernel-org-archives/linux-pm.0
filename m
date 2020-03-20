Return-Path: <SRS0=cFiq=5F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B3C4332D
	for <linux-pm@archiver.kernel.org>; Fri, 20 Mar 2020 05:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E461620739
	for <linux-pm@archiver.kernel.org>; Fri, 20 Mar 2020 05:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584681794;
	bh=TTNs+Ru/uaT7SXBXiRLtBYGfdD1Z0v0hoYEMtuiFoTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Y/FbrZ+3Xiqy7XxdO3Mbr0ylxEX5ZmmnfAPDy8Uaqj9RsPnQp5GdVs0iXrCwMIpUQ
	 w4o6mlcQeo48HPSsw9evDZbkE3xZ/toQN6/RR9Ugd/lubnAC/VFdWySFNEUIs+izMJ
	 hjdATQ7QuT2QAZZc8+OUwPDsa2/J6y4FJlptcWD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgCTFXN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:23:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35292 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgCTFXN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id d8so5764763qka.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=QnlRKFwb6riwoS45t1kwNYmNbBxnCagIRb1lQuIyqno=;
        b=PLaMcinLzMdgtH+ixV2oIxXQ1ZTqyBNyptoc5To7KwuCm+LKJY6OSFIt8z1LX5XE84
         +7U260xQbjvw8ZH2SoD4X/VHVzPfRfW1G4Jp+KhRD5AoN5jc6mBhNJJ00eSH0YhAC71n
         mxqaMyjCl44LN4/CWt7aKa+8SsCBshC7YaFSqRcjGhF+sh9QuJGxrv6E2qkgcG5QXoIs
         /SwqbsiMetRT+rVJbs3f3HMPWDiegYAw/dp6H54pzARWrba3WyYdXdukDAx/X1eMi96O
         jj+sutBUrNYjDOwSsYs4tIOKGYtX9goOhA3WN+WLps0lZH+B9+LkRqrTEmJhve/IKgcA
         Wfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=QnlRKFwb6riwoS45t1kwNYmNbBxnCagIRb1lQuIyqno=;
        b=ED1p5stpeul7QHv38YGdxy4FSO5xXL93/DbPdAtlFC2FVdbLRNPPsk9K8kJGHJXJ1w
         0HV776giEuYvpZG0+3URS3ywm8UrlmTVj+z8ce9Ntg9ohZY2WIHGFdwv9lFjAQ/18u5k
         /DjAOr1TNPoUp8BplHURwiqWK3GdLyhO39ZFklV6/1djycilpuUMiMpNtIbHW3q4f/w+
         nhgaw0fZS7FSNfWtj4HnUhhcQXpk8qBZcM1vWQLan0WKcuqJiOaC6QuFKB1rgYnRLVXN
         cJ8BnLT5ICH+HbrdJN3t/P+LiukTpFzJU/vqUfO1ZUsUa2azjVzTswxLkGYPyMGFPxL8
         B7hw==
X-Gm-Message-State: ANhLgQ3J4hIOQfE7tFYCSIjf4h4rBOXeixvC9H2Pg4srgrC27r0ZSkhS
        FPY8qGa4HtF8X4QE0DaMsPhlQdeF
X-Google-Smtp-Source: ADFU+vuRKhpPOOvXNA8xLTQIFiz+iOWawg0I6rbUVNcDz4U8lKrN3dT+9wGpfy7kyiFEjKo2Dsztdg==
X-Received: by 2002:a37:64d6:: with SMTP id y205mr6445652qkb.346.1584681791770;
        Thu, 19 Mar 2020 22:23:11 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:11 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>
Subject: [PATCH 10/10] turbostat: update version
Date:   Fri, 20 Mar 2020 01:22:48 -0400
Message-Id: <aa8a1afd103becda28dced0385bdaf9b6065e0bf.1584679387.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

A stitch in time saves nine.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c9e299e99c2f..399b2c3b095c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5394,7 +5394,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 19.08.31"
+	fprintf(outf, "turbostat version 20.03.19"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.20.1

