Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C693148D3
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256828; cv=none; b=pYcrnxQE/umoq1h8dWDlAoPoSrYjCGQdjvfuPQZckFgVxnaueLEl19LveT3qHSgYjx6DNtNfLbN3/ogWc9mvK30xbZcK81hc3s8SnbKe/l2vJ+tiUD2BQ6wQU/wSpV1AnRJ6i7UuhLCbnIIS6Mq12hFfd9IK6f7SLFnfNSTMnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256828; c=relaxed/simple;
	bh=uoTukmt3c6bQodpjqqimT9k0Ozk82n+jr+lELyu/I2U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZFh+F5Sf7gM4deNZQUGBfGre3HQ/I4cWzIOlj6DmafqgcjRbJzx87CFpiM0yHKKgj68VagfqDvfp39E/ajU8m/50BAT8T67Lac97E2+Wrmr0vG4AvqUVS1tGz0XlCNo1J/hKF0IaZWfMsnzSa0Q686DPV4etmIEH7sWJYZHWPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=jGwPvmaT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="jGwPvmaT"
Date: Wed, 11 Mar 2026 20:20:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773256823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=hddFARcv2xsXdLFH6w0fCLWKlVQmfiyFys9Um1niyhQ=;
	b=jGwPvmaTFHs6qrYb9Cqy7RsmZ1YsaIWQQX1W0IrV05w8axwfb9dHDjFc3FZ1O42DG9MjQp
	QP8DjXJGUwuHvuL5zTUuRd37397sXwCtqQn7cJG8oeiBt7zDtu/is/7dFBAxzMafTvjXfW
	8eE7v6m3AWNGHEDRmzFwm+l+cbrEvSysbXF7t3gLBF8H4ndkxscq7To0F6g25ouyZ7zOGT
	P6MuIdTgVXtDxsMQb6w95XMoi6hEySDywCrI9xSdMZq/ZdfzmZKbO2m/M9D8JNDx0v7Qj5
	bZEqT/RegNFQpIhhebLG/z0nTDGOHgIOOC/Bad0Tur9V3zEFdjgpOkyuCAKGug==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cpupower-frequency-info.1: fix long option name
Message-ID: <abHAdH-ggaxUugCy@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The long version of the option is --performance, not --perf.

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 47fdd7218748..1173d4f31e69 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -53,7 +53,7 @@ human\-readable output for the \-f, \-w, \-s and \-y parameters.
 \fB\-n\fR \fB\-\-no-rounding\fR
 Output frequencies and latencies without rounding off values.
 .TP  
-\fB\-c\fR \fB\-\-perf\fR
+\fB\-c\fR \fB\-\-performance\fR
 Get performances and frequencies capabilities of CPPC, by reading it from hardware (only available on the hardware with CPPC).
 .TP
 .SH "REMARKS"
-- 
2.53.0

