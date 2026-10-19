Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422171;
	b=C4vHZKWAtnFOanWfUqZ6CsizsjCxzscUaCbcwM0SoOQhOHJxMnTQWqDVfmf16Nshk6Q9
	 P3f7pH5EhoqtSxA9TyDr83mNLC+ifdbt+Ww3hWJ2zj9yHdjOA5ROiFV3lWVxR0GCTL6kK
	 CIiiu6CPE/m8muILWpK6lrRK5OFmWrfDg0gnDxzqwWEmd4xoDSCIvbUnpz2FITlSPfV8k
	 WnHpoIAAxNmuXlNMW5rObmNCCnOx9VaPg4tTJna5aXf+lovX2r/R3vnitVaHOG67TvRcd
	 gSL1jebsqAKGFlv6YjrflGlNG24EU623gKt7l8pqvs3Z4pCG8k3FqMGFbhwHbwf9Z8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422171;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=FZAVhJV2TBrhzQPuVcc7/6fw1pIgf9F2bAceGvhL3B0=;
	b=BnMHjeyhF6VIcmH4WHoBmrqxq2aEDFcSqGs6b1WKcRzI2WF7IhYqxJza1nahzqwUjjuL
	 +zdJ012998hVwJVjLgdKEEZ0+AM3PkPXrLyUOic/7x96CC2Tu4ax8k3PcvfKxmwKrkVHR
	 QUo7F645hHdbYnDiYG6DSJ2kiJ5Zb7QSELoJ1xH+urbbKc2xJqpg4LO26IgqDV7rQns78
	 rosWtVcGgPANWQhW9NI24lRAOApLJFzF9gk6oZ4dfE/Oc185Qh77JrE8AJDBx7S6+Kza7
	 A4MEzY8jTl2UsonRTJuasCWnM7RQ7C+YHLpYH/5aeZXAYhVMf+XKIodIt90kkVcQVZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uqy1nfR2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC2607BF23
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uqy1nfR2
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B46513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422171; cv=none; b=EM37ufgoPmZiy0abw2tKu0Ez6EaNuSHGQx4S5huZRqawfPfUe+cD2dPPoUmvTsDDTf86KR02Y1q4KZujzSGoP3zZl72u1zj1lsV/NG6Rnekv2vEaUNo0+27/vy5Myy4jPdYQeWl0ZXiU82AysZhmdhfN8xQrz6aGj9Bg3zzXCcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422171; c=relaxed/simple;
	bh=qFLIVy0yp4AcAeZpPv+YA5X7t9jrsMu5JKYRyAvEQPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjQuJWfaWGDtmRsTnVX0ZlRfqwlelgL5jXdjvjk9DRZMsRa/bQvDxVECSNcvR3lnsVa0N1AHWWwerbJFZzaBX7UGPZtfA3PFit6rXG2lcoRJO2bX/qByB0MpfArFpi5R2LgYJnEHdHgK8yyyOTLKXLiFztepq39j6y8FsEZVedY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqy1nfR2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF8D1F000C4;
	Mon, 19 Oct 2026 15:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422170;
	bh=FZAVhJV2TBrhzQPuVcc7/6fw1pIgf9F2bAceGvhL3B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Uqy1nfR2UP2UUO88MEbd/FAM7mFrn1E3C04ZWD/ZcqwfYaYPrXJMeETY3x86h/vrM
	 Ucs6Pn9vTO2IqiaDM2bCCbSA5nuas1HGdHYH/jhPDHg8EyVl7rthN6I/kMadTkQbux
	 cyS4PBxhrX1GmIuWmRAhtyi0yMQmGmEnoezkr3WePfc37B+aKs6rFs6Il2fSpQSVHo
	 CvGY0V7NHze8ER9iqBlSi5o1NSsi5KS8qijk2wCws37PNc5OGXGGQLl54XeGYjGRtX
	 nHO+rB/IKCahn23/93/5fhl8gPF4KGdR1tkxkQ3zmKAdLm0rtLoG4pjwLxkZldkhnQ
	 y+mjfoVmxWoJA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/23] tools/power turbostat: Cleanup: Delete unused flags
Date: Mon, 19 Oct 2026 10:38:35 -0400
Message-ID: <acadea13ed2f8ade79b3f1813b008ed89fab7abe.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
References: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

No functional change.

Assisted-by: Claude:claude-haiku-4-5
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4a16d12dc842..8054716207b0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -138,8 +138,6 @@ struct msr_counter {
 	enum counter_format format;
 	struct msr_counter *next;
 	unsigned int flags;
-#define	FLAGS_HIDE	(1 << 0)
-#define	FLAGS_SHOW	(1 << 1)
 #define	SYSFS_PERCPU	(1 << 1)
 };
 static int use_android_msr_path;
-- 
2.45.2

