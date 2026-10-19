Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422180;
	b=hxHXt/bAng+djVCutyJMumgG2c5/u14SivXd6arAJfuF5LiOBmjxCHU9yPnesheFRZeC
	 L1e6oxkODaLMuud3MIeS7zj386npXCjZWG89+Mw8yuBj4H4IVDZA0lL3KlPp4dpnhjj2E
	 SBP3PIoywClm4O9ZNwSQAHdUapJGSs5VBsWgde9r9ALu1MUeC+lQ13ISg+rRLg7bAU8xA
	 FcAV5k6SxSzXdtNJjY+v08+ozNEFq6Jtfk4QnDWfaQgS1w2KyXfq9FhxXGAR2eLxaz8KR
	 P43tGq+MyI1i9HnE7mOJeOZ5pVZegDObiBGtsIlPUi0VCJG5goHOW9HTUgd0zJK8eZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422180;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=2pQ8AxY8E+u2SbfyetW0FlGfelXSM3YVH+JaPXCtuJU=;
	b=4DXPnIVZZ146q8Ano3XnFbqSU0usOL4aH7sMiCMWD4X+xqPiSZP5y8hw6SzaOL5go6RG
	 qw3GKDym+mJh7yph8TYiYbXmDMozpw8mq6VIuupWwVVgC2+jSKN1U6AZRRebHXp7LM+U7
	 3reKp+YptDSeaLjalCfQSTxiK8aB5GTF4bwe21yTXOIXqc4esdSPq2Uy9DCh+YY4eFUvB
	 v+TUCNIZ2ovgN24No/lu6//M9Dk2XsMrWoHmJ7vqEc8y1X7zA21xTXN0YVTWQ7HJ3RCjv
	 Ttt4bJ//TLOA9z5WoFa0z/s1K/NvGDOLHAmyUdZ09IrjcDgG3sZf+W4Nk0oKSTLAbxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fReZNlLO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5EA607D343
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fReZNlLO
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E16513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422180; cv=none; b=ZxSaz5L8ueaBc5VoIpwxNO12eijgqKelPaXqlZr5/J5Z+QKa77oiTLrkyUpa2KA952r7fxZqP60AvyM6zoL9RhpBwQo5BfClrHkpZlYTe1peQI+Ck1g8loPDJ1uQDCGaCwVe3Iiw0/t7nDcSTsRkNNAULFyiC7kxoJYPXTrTPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422180; c=relaxed/simple;
	bh=42FtbYw4JpzkFrhgdjDyuUnfrz2AQ8nBKl2emL+Tq6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGz65X0q9TONJcd+imkgDYgBkPivQNP6LfeDhS67GxlTF5IYOD8HiHMnxhvGLi1pbp/nJImUMKkxedm7VeZa3ilSPR3qryx6LzvhkQR1QKSevM5a/MfvLNcpyO5Tx61T5xW+WxH+GuIrF9Xw/Vp6Mqt/sOy/2zgGd1EKUn+J+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fReZNlLO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73031F000C5;
	Mon, 19 Oct 2026 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422179;
	bh=2pQ8AxY8E+u2SbfyetW0FlGfelXSM3YVH+JaPXCtuJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=fReZNlLOzcrPxw7D76bUij+4Cu+ISUgJp1I34QLracQVVwgrbCoUaVqTcRzli2+4s
	 PVYMbjv53Ll88Q1ZwWdjC+lX5WJ1ZfC9YDJn164raELUcCuR0Ca0eev8ueosaiOULO
	 4g8lbHLhDAEuP37cDeb0tI8yLtE8mPBJhx+it+QHjR4Uj7c5L7zAwHk4rqmISw/dqU
	 H08hbSPFEi76zCzm0lEx4jX0SeVzGMgsnHI+unIPwOubLyVkC6Z8Ni53sqt6du2Ra4
	 BJugpMprhk1l24u8dnqKd6UQReryq4QpAruVjhJ3Rn1XOLlPc2cPTgMzY67beU/NvT
	 cgAezZSf6L/qA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/23] tools/power turbostat: Cleanup add_counter declaration
Date: Mon, 19 Oct 2026 10:38:42 -0400
Message-ID: <12f841ec7b8943923f04fc438cb2883b9f9a773e.1792420722.git.len.brown@intel.com>
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

Declaration and definition parameter name mismatch was confusing.
Some params can be 'const'.

No functional change.

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c63aa2ec7426..a005ac6942b5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -590,8 +590,8 @@ struct gfx_sysfs_info {
 static struct gfx_sysfs_info gfx_info[GFX_MAX];
 
 int get_msr(int cpu, off_t offset, unsigned long long *msr);
-int add_counter(unsigned int msr_num, char *path, char *name,
-		unsigned int width, enum counter_scope scope, enum counter_type type, enum counter_format format, int flags, int package_num);
+int add_counter(unsigned int msr_num, const char *path, const char *name,
+		unsigned int width, enum counter_scope scope, enum counter_type type, enum counter_format format, int flags, int id);
 
 /* Model specific support Start */
 
@@ -10718,7 +10718,7 @@ void print_bootcmd(void)
 	fclose(fp);
 }
 
-struct msr_counter *find_msrp_by_name(struct msr_counter *head, char *name)
+struct msr_counter *find_msrp_by_name(struct msr_counter *head, const char *name)
 {
 	struct msr_counter *mp;
 
@@ -10731,7 +10731,7 @@ struct msr_counter *find_msrp_by_name(struct msr_counter *head, char *name)
 	return NULL;
 }
 
-int add_counter(unsigned int msr_num, char *path, char *name,
+int add_counter(unsigned int msr_num, const char *path, const char *name,
 		unsigned int width, enum counter_scope scope, enum counter_type type, enum counter_format format, int flags, int id)
 {
 	struct msr_counter *msrp;
-- 
2.45.2

