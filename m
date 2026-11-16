Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831476;
	b=WGdKQZ3smJVCjOBqS+M21J3ZLIGJcdVXgNc9VRYudAIeBfY3+JFvUiWu2o5zR4bUbcpO
	 l6k7fSL0Mvr/7w4FQ/BcsvTY3XdhXJZfhR1ukhMP9uzcDN62wKOyPn5zrGOAXk7RAzrLq
	 mjxljFpH4u6S0KiucooYd+fBP3kjRG+Yd31x9Rei6o9blBybT+OXFiiziXUK2pwu48k0W
	 l4HVYq880HEdf6KCMYyWFxa3MH5QnZqsdHsrwWJ1fN6D+MxkB3lw9bRmDR0wXm5EBRZz5
	 G2/FxQZo82hjjXIY3ks0G0xYichRMmnerdawNHKIcLUgXJ487gE49gDH4WrprSeOCqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=eSbZJBt3/vkvkuWd/qi3gg4Wzu+1ElEya82cmyVHQ0M=;
	b=xp7W8vJDm3ollwKjdikm/MaVuaNsF+7tbb7at3oc8GCWMsvPEzjPgXzXIlwIg1RFgd2Y
	 PfIhS0WxCwJjQ4o5vaR2Lu3nSjH1p3OFPht4baL/g+RC7tNiuwcOM/JjvSGa+uMC1fvhs
	 QrjFEdXSih3nlPIYmvejBafcGH2nHCpfLI42vq+/8lQ/Dzyo990NUycXuQv7dfhI/IU9W
	 j4o5slBPf/0yEtxe6OOpsE+Zb4XIQgn94mCht5PXe7MAfo1fMgmUDqho3Em27FuKaLzqo
	 oPO/hhts5Jd+KBnrIjyUXg+YYpOiuthKlFYlzVi3C1INb0QVaH4NftGdjAOghS4bUhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQVAzJGi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B23606A31C;
	Mon, 16 Nov 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQVAzJGi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5DA1F000C4;
	Mon, 16 Nov 2026 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831475;
	bh=eSbZJBt3/vkvkuWd/qi3gg4Wzu+1ElEya82cmyVHQ0M=;
	h=From:To:Cc:Subject:Date;
	b=IQVAzJGizvnofVCbY4udSG/qttomOrukZoGREqBQppn3rXKBAd23xzUZvUjCVJtWu
	 U8Hw8Hni6V5PAiPCfktLxM4h6Vx/+TEVk+Ydp1yWNy4uWDZBN5YcKd/7S8sNiToxqn
	 lQdA1qCgy9zU2T6vK5l7Ao/xvyyYD+OGuQcHk7R50zvd4B8sXiU2xVCmtO5rtQVsEQ
	 JfpyJv1ZReTV2aKf6i1uSlxb2cEVongSisj9PvANmQ8B2WhYWGizVOktIuWC/rrkiw
	 9pmA/30TEPRnF2IVMKY8St+zZSAE+XbF7tWENT9T64soD7lEt4sWhY7whFO2PJCJp+
	 1l925KZP3oPFA==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Juergen Gross <jgross@suse.com>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Thorsten Blum <blum@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: Use clamp() in pkg_temp_thermal_device_add()
Date: Mon, 16 Nov 2026 13:17:20 +0100
Message-ID: <20261116121723.342798-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=blum@kernel.org; h=from:subject; bh=2p0e0IC50gsVcW6lSRM6rMhOjxuHGMv78UYoOZZZAVE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFm/vgTPZphit+MdJ8cSdj/etSlhP07qz74h7i1z9ovO/ c4fdR8OdZSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEjHMY/oevrF3j8/QKZ+q3 BmGJk9ncFoeX/2Nc9kZi2YNdj13PT+Jn+B/It9828Jl9TN3kgn+vLpSvqjvvFFc8b83xbj7j55x 6NSwA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use the simpler clamp() macro since the values are compatible.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 43fd5bdf1d8d..2b6265b80fe1 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -327,7 +327,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	if (!thres_count)
 		return -ENODEV;
 
-	thres_count = clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
+	thres_count = clamp(thres_count, 0, MAX_NUMBER_OF_TRIPS);
 
 	tj_max = intel_tcc_get_tjmax(cpu);
 	if (tj_max < 0)
