Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516A1CCCBF;
	Fri, 28 Jun 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596683; cv=none; b=CfIhdRNNBYtAbYOb5S+O9ewjmXQUDxTmWZg7CW+sJ61/JTxbyO1T4KcsQgjvQ65tirJFrzkaAsXbX+zjcNanV1PLveSxdM2NJX4dubI6avOwjuFLpzA1NDNzg1CX3LMtPy61c4ETeqeybgYrFa70ZUH6zLF+eUU62v9Jg0q+vBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596683; c=relaxed/simple;
	bh=iNkUfxlYovNR0cv33dnHDIK5HssQmmjk4QDhJwt9Ntw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOcXzibhBbflXx6utubV+lqH9c1iPnyJX1zAq6SOUry4W2spProDIvFGevQTXBh73QICOWgeCtnlDss9qSvFzfxxoCpv6TMQf2eYXrPo9+BJ8VSj14a5IqSKaHaX/ohCo5YLYx703zxUs2xD1lbkBKt3bwtV0vUvLLTEOa2VhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=P5clS6VO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="P5clS6VO"
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719596678; bh=iNkUfxlYovNR0cv33dnHDIK5HssQmmjk4QDhJwt9Ntw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5clS6VOUz5/2pQ7Lf410GsDb7Szq1SlcgwIY50CDR+gHpyUZBXI73pc484vTE2oh
	 3PR0ICVQNmm8yIFMiViM0RJBkDugKPszjzpDxlzUpg6gEqbmb6BsAJwBbiSrSnXlG4
	 p7F2fFZe7NEUKXfg8WzQ0Twt83JLOsB3yEXbZyQ6lL4aps1K9+ZeT2N67lIoWrv89k
	 qzu6o3Qbb2mWSYoCa7NQYcEFELRPWFlvh1CmjKvB9YAmIr1Octd4Dxu7I6NpxcgudC
	 +LXHYO4X+a900mniTeQTGPjMCz09u1nn5Pg0CsYgWBv0xCpbPItT3TG0hZMV71Xaa6
	 cWL6szCBWothw==
To: shuah@kernel.org,
	trenn@suse.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hejduk <danielhejduk@disroot.org>
Subject: [PATCH 3/3] Adding changelog for cpupower
Date: Fri, 28 Jun 2024 19:44:18 +0200
Message-ID: <20240628174420.5370-4-danielhejduk@disroot.org>
In-Reply-To: <20240628174420.5370-1-danielhejduk@disroot.org>
References: <ba4d74fd-6762-4e9d-8346-5f3384cb60ce@linuxfoundation.org>
 <20240628174420.5370-1-danielhejduk@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am also writing about the Czech translation change into the Changelog

Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>
---
 tools/power/cpupower/ChangeLog | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/power/cpupower/ChangeLog

diff --git a/tools/power/cpupower/ChangeLog b/tools/power/cpupower/ChangeLog
new file mode 100644
index 000000000..d8f16e469
--- /dev/null
+++ b/tools/power/cpupower/ChangeLog
@@ -0,0 +1,3 @@
+Version 6.10.0-rc5 (2024-06-28)
+==========
+* Corrected needs work strings and added new in Czech Translation
-- 
2.45.2

