Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704383C455A
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219656; cv=none; b=b0hKsYJckspOz4bNyzfHs82RfPp8jY29SDokEJ6oOqVQPbJq/3nv0krfcTQB1JrIg6nPdV4ccwkiGAfgIki7xzxeTSciWeFl7FVh1grRx3cbltyQEeQGfPNuwDa4zlmg9yUrP3vLbFph2nNGVNyv1i8cUFGk1G187Ctfk4JIRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219656; c=relaxed/simple;
	bh=fZ8tdTeizGt02LP+rR+XyURRvk5T1uFqQj5y81ICip8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ7c2vBnHBBgjLEygMiL9ljRMbj/tff/lxTilRIpPE6eFt3mx3fMGpu3Dx3eHai05BH8aq15M7LCj9Agw27fdOIw73HO86k86a729jA0QPQ3G7Vxw0RFgKOzL5Q7dcq7hMkEYu6YpTcRZxgQcpP/xgwRQJiKtOaWtpbbOCh0fSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcIRjExS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcIRjExS"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a3f6da741so39974861fa.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219647; x=1773824447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B26x9D4rmMI9CX49m9y1XNTPxPFBFXUEgtS3/Xb4L7Y=;
        b=KcIRjExSOlCAj9RUifMoj5gisq3G4Fk6I6yLqcMNYBBUuOS/mcQnlLjM/VQSFlzP5d
         zXLpyJLTaCvpuPzZk6+Jjfu6Yk1o7b/pbVueMyC7UVTn6D2alhUr4t344z61bSHakwRX
         NJ3zAWoFiQFjXdGnGY4+n8yxsy9QgtX//KJRORkcaMT64NkMxijT8atJAPzS1yjaL1E6
         fY/XR2epoIL6WpXtF3zlIFuUFsxTBbjKtqA1ZnYoIFuUXdz4d45d+fxwoQU2pSk3nORy
         /+VWcRwqDRDWwCPcygaEdVsmTisIBDEgVcn9OOBvixkAsPFZzjop+X3JMWmx+i7dhWEG
         9iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219647; x=1773824447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B26x9D4rmMI9CX49m9y1XNTPxPFBFXUEgtS3/Xb4L7Y=;
        b=LSCCOCBHj8ryL9yoX6vzk8W6DzxWXRa2wrabpwnTI1l5xZBxp3hK7MXyn+LehFII+f
         uAxokKJlfDTRTU7QAJ0QSo8y+7uOqJAXsZRughs8f4G9ciVN2dYAFyKbAch9oCZL0Ren
         0rq0lOaHTx+FbBxpaHt2T2gdRJn46WRiv/SUnIMC12dpRMUn6xXib84547fKdJMaEf2E
         74fPqwgT2eDQFfKSLiZxNVbh8/KRIcGweJJ+g6fb9uJ7NBX3rxECZdVDzgHhdXsIb47K
         Ivsi5VqnVzkK/qlLWoC5BwsikDPyKX8j+qyivIU+P0KFhpY3WgM58uGkqoh2dJwWBWJz
         aRGg==
X-Gm-Message-State: AOJu0Yz6rQC/zhk/aPLfgrQsx+d8MNTUGgAVwL0RRnqZkFUR2nRdc9IH
	FvPRAzzEoR/YO+XeTT8BW3bQCuAC2O+y0qy64Y68/e2aasTep0+J/OD1lEDI4769
X-Gm-Gg: ATEYQzw1Der9m/wgaQ2Yg/rgvcxNYEwYdo/CMlLlFodRVpabDmzyC4SpazkB+qQL1ny
	PNhU5iJo8q0dOfXxecos6yGkcUuOw4M3dspQ4mb6bXobaAunkirL2/f0HApe4gwT34ebnv6Js6B
	zBxgFjrQH307NmxUKTod1gP1GVvJneCH0i94TiNxNCfwnl4QaermJVcmE20vaMzbVbodnSHoIt0
	/aiBnm61lPF0M666AsaqnkjJXpnuTL1g6qlCRPXjHpTXX6CoyQgVPhqUTz+tENI+QIL5hMEhBae
	L5pEx0v3O/AZwAynRp2yvxLhP3FAXDz/i90QrbxDbJSiVzkqENjLUfTh1MTvBN3YnfTlyv4P2ul
	tvDD0v7DpIdNl3L95s6srD1SYyRr/YSEvf8jQNmYVWLHFjyCE2Ev3Q0AtboAzesp85BNb2KoZXi
	C28kQavKMsjAaF/JAUwICJvbHIwIyzWUQJ068Y5vcR7bw/elpcJtZq8FGuVy27
X-Received: by 2002:a05:651c:210a:b0:383:213c:fc41 with SMTP id 38308e7fff4ca-38a67d6353emr7769441fa.7.1773219646959;
        Wed, 11 Mar 2026 02:00:46 -0700 (PDT)
Received: from abityuts-desk (176-93-227-108.bb.dnainternet.fi. [176.93.227.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed41sm2645041fa.25.2026.03.11.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:00:46 -0700 (PDT)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Len Brown <lenb@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 1/5] tools/power turbostat: add missing print_float_value()
Date: Wed, 11 Mar 2026 11:00:31 +0200
Message-ID: <20260311090035.169539-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311090035.169539-1-dedekind1@gmail.com>
References: <20260311090035.169539-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

In the core and package cases, all PMT counter prints use
print_float_value(). But the thread case uses sprintf(), which is not
a bug, but inconsistent. Most probably just an oversight.

Address the inconsistency by using print_float_value() in the thread
case too.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b985bce69142f..9744f9caac9af 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3489,12 +3489,12 @@ int format_counters(PER_THREAD_PARAMS)
 
 		case PMT_TYPE_XTAL_TIME:
 			value_converted = pct(value_raw / crystal_hz, interval_float);
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			outp += print_float_value(&printed, delim, value_converted);
 			break;
 
 		case PMT_TYPE_TCORE_CLOCK:
 			value_converted = pct(value_raw / tcore_clock_freq_hz, interval_float);
-			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
+			outp += print_float_value(&printed, delim, value_converted);
 		}
 	}
 
-- 
2.53.0

