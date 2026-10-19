Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422184;
	b=kUW4FNhUoWuQDO5GXSEvjH9er3Nz/Kc1PFkYdGuTtEvUYvyU3ZUArpPqVD0PdpdhX8Wh
	 U2Gykzi+/6h+IO0i/MEHqQ0AJ5VcvQNQrNQ/1yqxiwp0y8KAirRM786YtBjLiAUqzl9aq
	 fdIlIZ1iCiVjRZLtr5jHaYdQ1mIohBfYF6qbXLq/m1hnp37R9ZzyPRE3cBBa+N787sHc6
	 tRwq8ZBRwGuB4FXsNOSXB5qcRW0ctdc4biTIlgNZ3TZ4CvOBhjhsUyR6ZplWwRtSIbZ9K
	 55qRzljEsk4uLfeb+6OWAOzDXSEyCEdHgG+nrQr75Ds/wFZ/YUZ3Lr0dZXDAoio7e7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422184;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=FlAomi5p4nwgiJjgChsy3DGk4ZldxjtnLAQ2SDvqB/0=;
	b=rkTLpQiPwmhaSSqQrBGZy6qzUSARMTrEDi7ljjydC0koo4TSShUhVDp3dG0LAunRjJDA
	 vDry/Fyov+XSV/kz/lw0Eae3kd0NrOLU7ZrNE3h+4IfZOSaodWvQLftlhhLk4EgAQ/w7M
	 jpxKlfe4RLMluaaMpjhRPyr3ZW91gPRdTNltALB2SdhtWEh2NWwXjq0H6mHWqIiPmEixR
	 cr0jIXFk2NRMb30LakZIqA17gN8I/qq38TcRa6LYUFbL8brQ+NOkaBcwH83lPQ3XJeaME
	 QNj7yMSfiIM64izdnxcabE/AB8RqZl4IAsG+p4eqLJzz+ZfBQm7gJ1NJCQsZmy9xDvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNAip8rU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24AE607BF3A
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNAip8rU
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A396513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422184; cv=none; b=sjD57STQMFJ/YNmQrEJ8nuI1cq1p/ecbxajV16ZMDyQeApLe4c3OzjK9U7+uZGjE3CMgg/BUxFquy3m6kFJYSj9atiEfD/LSYQrhvTHyN9rjUJ23VLwXknEs2bsPLix8qJbvQpubM5rNBWGov9om1YQ8aceZati2AjqvMnGl1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422184; c=relaxed/simple;
	bh=2dyu1IXTIS9JRYriyEQZOswPQKVyhnlR2u00gMpRVa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWsHiyYC9SJ9/Mp4dlON3CEhiYLWWmpELyw8rGcPGTuMMgwdTO9ug16ZZrm480pgWYms3YoWX84syUYtJOFAoa9OAg8i1rpPsbltThe7LHb7gel1NYwavQoVHISliNQCwSBac4KVvdQE6DrKqEbxPWkKzssbECOSGGQv7MiOSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNAip8rU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE8C1F000C4;
	Mon, 19 Oct 2026 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422183;
	bh=FlAomi5p4nwgiJjgChsy3DGk4ZldxjtnLAQ2SDvqB/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=MNAip8rUmVjyCftFScGmbnuZgyCFidHS7JxvB2ZDLFpQTzSLb1jToMXKPFO2QEGuL
	 +safT2priCNmRm9d6k08O2FieDVwzCNpFlmOk4ICuJMmv6GQgA6n8hY8I3Zd1sWNdY
	 2DKppDwzhUDcYYylluwxxBcEwxBOx+WWelBz7CrLyoqn4OtXkjoa9vfqHhsWraiYyu
	 8knhL36zlM6ZzldMz9LLSx7wAthNYakXJbaf4zxGh8jC/34MKA+2Tes+gytRAF7gim
	 in4cgVpPeKN9Ame1XNu46ZV9qv/NAVVR/yFx5uM51L/z650cPQrRTHI3THdzzBMYr4
	 1LZxgrt5xpyBQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 12/23] tools/power turbostat: Cleanup: bool force_load
Date: Mon, 19 Oct 2026 10:38:45 -0400
Message-ID: <e1708e514a368ca2cb05a5c6e122919005027bad.1792420722.git.len.brown@intel.com>
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

It is confusing to increment what is effectively a bool value.
Define force_load as bool, and access it accordingly.

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3248a6a60732..dbbaa737342d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -523,7 +523,7 @@ unsigned int valid_rapl_msrs;
 unsigned int summary_only;
 unsigned int list_header_only;
 unsigned int dump_only;
-unsigned int force_load;
+bool force_load;
 unsigned int cpuid_has_aperf_mperf;
 unsigned int cpuid_has_hv;
 unsigned int has_aperf_access;
@@ -1360,7 +1360,7 @@ void probe_platform_features(unsigned int family, unsigned int model)
 
 	if (authentic_amd || hygon_genuine) {
 		/* fallback to default features on unsupported models */
-		force_load++;
+		force_load = true;
 		if (max_extended_level >= 0x80000007) {
 			unsigned int eax, ebx, ecx, edx;
 
@@ -1383,7 +1383,7 @@ void probe_platform_features(unsigned int family, unsigned int model)
 	}
 
 end:
-	if (force_load && !platform) {
+	if ((force_load == true) && !platform) {
 		fprintf(outf, "Forced to run on unsupported platform!\n");
 		platform = &default_features;
 	}
@@ -11555,7 +11555,7 @@ void cmdline(int argc, char **argv)
 			bic_lookup(&bic_enabled, optarg, SHOW_LIST);
 			break;
 		case 'f':
-			force_load++;
+			force_load = true;
 			break;
 		case 'd':
 			debug++;
-- 
2.45.2

