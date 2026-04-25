Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A872C027C;
	Sat, 25 Apr 2026 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142870; cv=none; b=I09stoqZxSFEE0Skw06JuqMFXiYdI3XCtEBse2lQ3lZ5pc7Q0EkV5EB8Uv5UbiojvHx8VexL8RUz3pDlufT6O0dP9mO++GMnfzImuvFwecZWIjUsd1YL8gEnFDvweDJux9yleTW2UPgIlDL9SjF1A9We35SencYBFnHUZnxiUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142870; c=relaxed/simple;
	bh=KaIQqqv4t6H6eOPgEVlosiOLW+Q4Db8dXq18eoY7qxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJiciS2ijRB4YwVGRb7Sch46vQMefYd0c85SHf/0t/8nmpasI0DO+rAm//YYuaun1nMgwt8CJogJxB71YVgy1hhamOUFGKw0ptPsSnfw5hEUcE7gc2qbkW9m6O72XeixTLn2Dt+Ccl5lE+YvE9F1bRxpYSkL7fpAuwzR0yEocx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udbym+eu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udbym+eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998E3C2BCB0;
	Sat, 25 Apr 2026 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142870;
	bh=KaIQqqv4t6H6eOPgEVlosiOLW+Q4Db8dXq18eoY7qxs=;
	h=From:To:Cc:Subject:Date:From;
	b=udbym+eu4hKLObOPm8+uHjXUNVVWLTbDEeqVZooVO1nBY1IKUtqDiWdDVI8EpL93R
	 sLfWiS2aI6BM8ve46QCu+OcfhwvimP7ayLrzbjGiMBK1mTWDfeKnCFGs3eHdq8YRFp
	 tvllW0ZpPrqKCIA4YZYGzXvhHFT06ePlz+AWhD6diE/hb1DawVf51drMvs3MtoK4Rf
	 Qml9f9ScJz0FMdOsImx/uFVM4mvTicdiwSPsdPnI5W8+X/U4Mrh97g7tZKM2TJNO+a
	 3uVjJBYEecfHmssK4tR0hBQ5UHj3bRlVijvGDira4D3IjJYof4ROtIJHZzqpmQvQSF
	 aND9Vtt0Td9zw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/13] Power Utilities update for Linux-7.1
Date: Sat, 25 Apr 2026 14:42:03 -0400
Message-ID: <20260425184746.1053835-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches update Linux with the latest turbostat
and x86_energy_perf_policy utilities.

tools/power x86_energy_perf_policy: v2026.04.25

	Since v2025.11.22:

	Initial SoC Slider support

tools/power turbostat: v2026.04.21

	Since v2026.02.14

	Display HT siblings in cpu# order.
	Add Module-ID column.
	Print Core-ID and APIC-ID in hex.
	Fix misc bugs.

Please let me know if you seen any troubles with them.

thanks!
Len Brown
Intel Open Source Technology Center

[PATCH 01/13] tools/power/x86: Add SOC slider and platform profile
[PATCH 02/13] tools/power turbostat: Fix AMD RAPL regression on big
[PATCH 03/13] tools/power turbostat: Fix unrecognized option '-P'
[PATCH 04/13] tools/power turbostat: Fix --cpu-set 0 regression on HT
[PATCH 05/13] tools/power turbostat: Fix --cpu-set 1 regression on HT
[PATCH 06/13] tools/power turbostat: Cleanup print helper functions
[PATCH 07/13] tools/power turbostat: Print core_id and apic_id in hex
[PATCH 08/13] tools/power turbostat: Show module_id column
[PATCH 09/13] tools/power turbostat: Process HT siblings in CPU order
[PATCH 10/13] tools/power turbostat: v2026.04.21
[PATCH 11/13] tools/power x86_energy_perf_policy: Enhances SoC Slider
[PATCH 12/13] tools/power x86_energy_perf_policy.8: Document SoC
[PATCH 13/13] tools/power x86_energy_perf_policy: Version 2026.04.25

