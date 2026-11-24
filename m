Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490852;
	b=aZa+IKXBxicxjfVjdFpxG9jU0Zj/a9ZRqKrCmU/P5rTgXrZQXJ/69NaTkE2Iu+oeagLw
	 vMVhw85ANkcqbfMYv465ZUMQ0CFTyV3kNQxPExSRHda47mabAatKFBDYo062x83fPp4m7
	 C9JR33nKWIiDPH/eLdB8bmXLC2C7w7CTd8Db3gFVO5ak9Yq8RYv6c+7+kV3gZANdIAvDt
	 Op01hWJ+43ByaRNoL0UkV1prfho7Z/9qhUYv5PoCxARsTLUPcSK9kKIG17ITyzverGM/1
	 dCiwByLAv3FZpobuDYbD4K+PJzjrHPz9W4QCL7BZ7c517khAdkEfuqQvmB3YlLEdwoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490852;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i32/WIECDdzZJobfpNFsejowRh01fSlLpweq1fGkEXA=;
	b=GnY0ub0wlrQD6neH2If0E2xfvaEPBtraDqiFpv8E6Ime8el6kwIoryoLe5kMpNthwa7V
	 PYUDio786xkVePwTQjQfDZBwXc6Oz0Voi+Jh3a19Lux/G17W13/HY18T9XEwBcG8Ldorj
	 zoAbwZmBDEc1ILyk682NMEKSY0GxfwcmLvV0HCvVlScqxPwnFwADjSdTSA4RvOBGINAht
	 aGhLSoXPUKjO4AEeSlHDUdhUdWY8P/2as8QTiqD0OQq+GN7R8jgCAk4m16WFdxD6ZYpvj
	 GPCWWBbYRRO8JiFkNhcgIS7Bac8m5Mj/8xFxROV42E9zsIEMvdUGRpyNlfK35gmqB1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qhbacvkR;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45404606A321;
	Tue, 24 Nov 2026 03:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45404606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qhbacvkR
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795490847; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=i32/WIECDdzZJobfpNFsejowRh01fSlLpweq1fGkEXA=;
	b=qhbacvkRhutyIBbks1UTwn4G6X4RJ7CiMn5oGLqwwiYPSoik5sismYU/sadLiGJcoMQG/BP1/V+iS93r3oNfC/OP5KjbZY4EeESqeFYFmANyAtBoTtdxGLIApDZ7l7HfJHrEWovkMhhzAyuYWWihnuV/S9XkvUzhw3G4FTFhGJU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XFN2ida_1795490846;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XFN2ida_1795490846 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 11:27:27 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: lenb@kernel.org
Cc: michael.hebenstreit@intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xlpang@linux.alibaba.com,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH 2/3] tools/power turbostat: Restore u32 truncation for raw counters
Date: Tue, 24 Nov 2026 11:27:22 +0800
Message-ID: <20261124032723.157254-3-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
References: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The u32 size option truncates raw counter values to 32 bits for display.
However, print_hex_value() now prints the full value even when the width
is 32 bits. For example, 0x000000edc994ba0d is printed as edc994ba0d
instead of c994ba0d.

The print helper cleanup replaced %08x and the unsigned int cast with
%08llx. The field width is a minimum, so it does not truncate values
that need more than eight hexadecimal digits. The cast was needed to
discard the upper 32 bits.

Restore the cast and %08x for raw counters up to 32 bits wide. Leave
64-bit raw values and decimal counter formatting unchanged.

Fixes: 092b76a3253f ("tools/power turbostat: Cleanup print helper functions")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4e7eba8d8752..d0f0b4af6094 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2906,7 +2906,7 @@ static inline int print_hex_value(int width, int *printed, char *delim, unsigned
 	char *sep = (*printed)++ ? delim : "";
 
 	if (width <= 32)
-		return sprintf(outp, "%s%08llx", sep, value);
+		return sprintf(outp, "%s%08x", sep, (unsigned int)value);
 	else
 		return sprintf(outp, "%s%016llx", sep, value);
 }
-- 
2.55.0

