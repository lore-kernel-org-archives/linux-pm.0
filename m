Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422198;
	b=yuTCdDba+ROPKusJb9Y4q5m206shXeOu1OInK8Le1Weuif6R9V13y/1laMGhWJAK23UR
	 vX1qdfR0a0kWtyC4tojT37ZnhI6GV3UJAbMBMowKboris/RUCNI8QyrCjtqSpXms5FaeT
	 CwnZXjQwmyGUh1SyNrv6r/Lk203kAgnN/TPZCKOhoLOBfSVtRtZ2f2pBV4Lz1SxD0Ueum
	 37a0/jvT76byuyMj7+L8yTUza1X/6Kk0SAtrYIUO4o9FOGGkdAJEeI+vDFwqCEju0eucS
	 HIz/uLY9usStNH90byV5c3n0FU7yI1X1wBl6MFs4hNxc4F+hGM7pCbImCZFL6X8zM/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422198;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=ATcGqIZEZmjuua2vS35oV9apckVXwlbPsQPRnLN9RkY=;
	b=mIWzWf05NC+JuZQkp4nTin4u8vWmr3I84Lop0bVcZFpKNpLyrKkj28c/2M01kNZdwcdA
	 w+Z6+0+ns0pM+xuH3zR2ho0BDtsgS+ZAB2iFv1AM7e0Aa9WYINauW/iiyI+ys0lgohH+d
	 /rmB6uOXZr13CIyLlCKTeH50V8SoJ7slVX7pWS08YLsgdH7TnAVd6bioQdG4RqTaw8UtB
	 tMKwPs1yMgABpF9hErMlfBRdiM0r/rp1/u7zSQgcEObY69V5O7EX17e1Ylk5MRQIWssRH
	 Oy2XR35DDmGmEZPTaxOl82xWoVAHexKgLWWp2SnDricCjC0A1beL+D1OaXkQvsFOj2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVd6j1Q5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B36607D37A
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVd6j1Q5
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A266513C3
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422198; cv=none; b=cJnmHR6cFWuELeqe7sLjFG2wx0Doq/hcO03z0uF0sHJOMs281Q1G1wDmG7xw2/a9V0w0yEPZD3VpqI1GOOUMSgsKVbJJKlzY7uPxayyKwVLCho62aPdwt15Cehb9OCueAApYhp+AHyouZ7U4X/BiQpQHD7IT8g/VwN2gwO7UhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422198; c=relaxed/simple;
	bh=7n7nbF4OuAJ3nd2TIYVoMWvqCFru47vDXshA7Sg5Vnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/V04Oeatw5tI9VUUWGezsPy65FwOWftWzf/2OeMw7v8DcnFdbaJlx7c+DksDwt720705IG/xgocIfFOjliavOuSChx4Jz2MNf06S01Nvqj/S3sWuagdvjwEF7M4BUmQkf+LClKKyMtq3GAgcvowDqW448inbKzUGSJS1Vm8rsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVd6j1Q5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0021F000C4;
	Mon, 19 Oct 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422197;
	bh=ATcGqIZEZmjuua2vS35oV9apckVXwlbPsQPRnLN9RkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=MVd6j1Q5Xm34vs6IcbanXikaJwW/L3Smcqgwm1xi1hlOGF03tk8hYc6t1GLNicVh2
	 COviOX6vrFr4duuROl0QQ9TaeCdn3XlklqNlG0dU5AMkSTFLFwlIO4IJ+Rs+U+F4VQ
	 uHy9O9FvkErliaRM2ucDrrepXCQA9QDSHtV/KvNiPCMmmjbzJRLlnVvEUOJmMv2PEt
	 9OevKNs4PR1VezcKefVVRkTeoTGhPUkGf39znySjQwp7y8ukc/iR2Ub9BHvTJTVALl
	 V8M5eTQ4u7KIy4aU+TEbjl/gWUak2FAzQQnVcds7r/JlBtXOSHEjqnXIyreMNvEE0S
	 vqTTYmBNlPH8w==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 22/23] tools/power turbostat: Fix --Joules when used with --show power
Date: Mon, 19 Oct 2026 10:38:55 -0400
Message-ID: <5061b264259a6d5b50ad438ed649970be36b5345.1792420722.git.len.brown@intel.com>
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

The "--Joules" option displays energy in Joules,
replacing the same metrics displayed as power in Watts.

But when used with --show power, it deletes the power
metrics without replacing them with their energy counterparts:

$ sudo ./turbostat -q --list --show power --Joules
CoreTmp,PkgTmp,RAM_J,PKG_%,RAM_%

Fix it thus:

$ sudo ./turbostat -q --list --show power --Joules
CoreTmp,PkgTmp,Pkg_J,Cor_J,GFX_J,RAM_J,PKG_%,RAM_%,Sys_J

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c8215c9fadca..89a71f44431b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -399,6 +399,11 @@ static void bic_groups_init(void)
 	SET_BIC(BIC_CorWatt, &bic_group_thermal_pwr);
 	SET_BIC(BIC_GFXWatt, &bic_group_thermal_pwr);
 	SET_BIC(BIC_RAMWatt, &bic_group_thermal_pwr);
+	SET_BIC(BIC_Pkg_J, &bic_group_thermal_pwr);
+	SET_BIC(BIC_Cor_J, &bic_group_thermal_pwr);
+	SET_BIC(BIC_GFX_J, &bic_group_thermal_pwr);
+	SET_BIC(BIC_RAM_J, &bic_group_thermal_pwr);
+	SET_BIC(BIC_Sys_J, &bic_group_thermal_pwr);
 	SET_BIC(BIC_PKG__, &bic_group_thermal_pwr);
 	SET_BIC(BIC_RAM__, &bic_group_thermal_pwr);
 	SET_BIC(BIC_SysWatt, &bic_group_thermal_pwr);
-- 
2.45.2

