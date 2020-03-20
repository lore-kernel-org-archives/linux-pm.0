Return-Path: <SRS0=cFiq=5F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9307CC4332B
	for <linux-pm@archiver.kernel.org>; Fri, 20 Mar 2020 05:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680DC20739
	for <linux-pm@archiver.kernel.org>; Fri, 20 Mar 2020 05:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584681787;
	bh=jCbKyDvPkRjAJ5wIbIVJ1XEuYLYi0Oq1HtRDnKFD0n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=zVuqr2JAK0IYP9b71kMacKjoEB0br+5bNf3CBeTCFEhOYjPLhr8sce3EEYs62VzON
	 ft3WRSEu/jn3swm6iSPReUenDXq3I0o9t93PxSgkemIM6lqIGkDasaoerW1RDGuonm
	 WvWl6NGji6d5yvnNShvE4ydwkyMS9fXMmxUlRa7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCTFXH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:23:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38321 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTFXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so5736349qke.5
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=Kgy3nHrtHVFvpakh6OjnW7F1z3CYkEhOyxCVAShYdjg=;
        b=e0n1xEUzdPjZTRB0TcJcomo5xZZP/p+B11xKgKqa2zMetz6DjW2kJfHgo38cbbR3Ai
         nS5xqP3T+Rgudk2szMZslfOr7OgX4DjOrIOBs6g2HCXbeCxGJMdmRIVf7dDJSS4ZEaLB
         dBRfWMKTLNCdrHQGDzZ6o2VqJrQ4KxYEYa4m8kb9NsBziXCmR0LsL7ioQSiZUnY+j2Ez
         5wWc2oc8cTFlrcrUSUiTWW+Pmi05JEYm5x7pR1TQLj7XbNmY6F848HTPfWVJ6Qr5UpBL
         ZmO1QAW69cNmyta10O/C2vx0LHJiI8siVGX01a4TOEP9KqNttm+DGlrGyMjGefdgCCOH
         PANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=Kgy3nHrtHVFvpakh6OjnW7F1z3CYkEhOyxCVAShYdjg=;
        b=Z/gF1qT+Woq45eo37rfwXsIZef1/hWab/xdFPDaYPtztInf2KcjgsJ0+YTaPfZOnJx
         u3yMJhw8BKb5LD5FnjmxM5m2OXwvnRnr2u8ygAbNCAuz3s/zKQn7kVpxSHMlrhGPHrHt
         BAMXILyBs6pkg4AsW2XJDtL7UeIJUasbkG4nT5DVQHzMcckhPoWTE6pE/Jj4ZEp7bhLd
         Unk/LHW9uQKWNKP1HWaoa9SoBkAwvfc4Bs3v5P4IuK+pngIQy3CiopnWahmeG0EgIb6l
         g/oKWsBlKaIioDr/ZiJya4cjRVqQkqruGtQlPgO/mcghWIWazzJPwNh9JrDcwADc3Qg1
         KAMA==
X-Gm-Message-State: ANhLgQ2S6rXpdrEMYdE0QN8xdJQRPIt7UUt3MA+Z2TpZGIZqPb+nFFMa
        9olnM5BNz7vid13aCJr4MjC1r/P7
X-Google-Smtp-Source: ADFU+vtjs5v0lzb374hBRkTxq64Dl7tWMXBjTe3hnQxHmdoys6sdvRHHHiWcTxY7codDo+K1aG19tg==
X-Received: by 2002:a37:aec3:: with SMTP id x186mr6253704qke.419.1584681785628;
        Thu, 19 Mar 2020 22:23:05 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:05 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>
Subject: [PATCH 05/10] tools/power turbostat: Support Jasper Lake
Date:   Fri, 20 Mar 2020 01:22:43 -0400
Message-Id: <d7814c3098ddb2780bb66e787aa3949110dd4a41.1584679387.git.len.brown@intel.com>
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

From: Chen Yu <yu.c.chen@intel.com>

Jasper Lake, like Elkhart Lake, uses a Tremont CPU.
So reuse the code.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 26088b2a27cc..e953afb2e7a1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4623,6 +4623,9 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_ATOM_TREMONT_D:
 		return INTEL_FAM6_ATOM_GOLDMONT_D;
 
+	case INTEL_FAM6_ATOM_TREMONT_L:
+		return INTEL_FAM6_ATOM_TREMONT;
+
 	case INTEL_FAM6_ICELAKE_X:
 		return INTEL_FAM6_SKYLAKE_X;
 	}
-- 
2.20.1

