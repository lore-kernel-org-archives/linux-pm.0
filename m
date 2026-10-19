Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428747;
	b=qmH+b/T9eEamsl8bncBThSi5W+A8+YLxAYHZ9IzUt9Es/tMBE0CD4sOz2sSn3ISiPGnM
	 gDYb8t8StDnSZ5UZomIOKNtTw81B769P0MzQ0V3LLgnjL11mrsecNCM1g851ZQ1Tr5LOf
	 eu3R1x58GznsjHLw3P8dTJzp2TKt2tyC4KmM/TomkA2/IOGvVK4WSu958DZWVcqazO4w+
	 +3rjB+mBclgK7abHAK+xY0j02zMZiCcvZk5T/Sg27eBxYJ+uGBVtsEh8sp/EhYzlJVwnX
	 Gk5hLDMx3/I22674QmEtg91ifleoKakGKdJTv2gZ9M7DzAzpt+FBPrO0YKveilfzwhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=9QGJipQ9Pu143Wpdr9wFSwPEeSkoEWnU9PD1nCAoB74=;
	b=EkVZ9bS5w95rLrBMxZs3vQJQx+wYhy+VX+xzyssLzrSmZ+LSAWe6NHk+h/+sIrdsB7Rm
	 5BOmroWe36KEHEDPQ03lXzOtxs9EnKwpe5pJzVO7rKu0cT21Swv6YXlTRfelnU5vJr1Vk
	 XA+Su/oLCPkHWa57TQulehAYnZ4nkbSdMXVlGbDZeOHNeoD8eqkoYsI+Inv9EhkZv3JbO
	 UgIRF5aq/fAFRZxzGAl6NeDxD5fRAe6mM3Get68uyEqzWP8XdMRNCZLdaKUJJ2Ask92rR
	 ftALJrGW5ib+/eXXhiGcwXbSVflE2ZX1MxzxXawKyquU1LeBqI/ZWmk9zB3JehnycEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMUgPyUV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC2606A31B
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMUgPyUV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575411F000CF;
	Mon, 19 Oct 2026 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428746;
	bh=9QGJipQ9Pu143Wpdr9wFSwPEeSkoEWnU9PD1nCAoB74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=YMUgPyUV/EGoL6FlqeniF7yUzylzodCAt+/qXg4l8C4MqSXPC41Bp8mhSBT9Qa+Rv
	 BX7K3937R+DzIj00F8SEvLeGf5SsKp7CiU7fDi1YgnEWVNv0MfLfS9vaHq7Ryl3Y96
	 lfPOmYr9h8wtg/MI+eGnyn1W+riWj5+XDXRZQEtGNj8Xf8HB+6N9Mx+YHDwq+oKQo9
	 rmcPk/K6RyOf26H80c4EjH5gGNzQ2bbOYJohMFmriYJyIXSxss5AUugxtPcv2OXbzS
	 pdffTlakgXkal/ae7IvTdSYPl5O2bJ313Fvo65vNKaGjY7j4cohuir0VIaB1ZVoZ7P
	 9EaGOKan21eFA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Amarjeet <amarjeet@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 17/18] x86_energy_perf_policy: Fix write_sysfs() return type
Date: Mon, 19 Oct 2026 12:43:38 -0400
Message-ID: <777cbe6f740ab2e371df856c716ffe41117940a6.1792428130.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
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

From: Amarjeet <amarjeet@intel.com>

write_sysfs() returns an unsigned int even though it returns -1 when
write() fails. This converts the error to UINT_MAX and can cause callers
that treat a nonzero return value as success to miss the failure.

Use ssize_t to match write(), update the receiving variable accordingly,
and explicitly require a positive result in sysfs_write_string().

Signed-off-by: Amarjeet <amarjeet@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index f8ab9f4465ce..89850cbc6d90 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -897,7 +897,7 @@ static unsigned int read_sysfs(const char *path, char *buf, size_t buflen)
 	return (unsigned int)numread;
 }
 
-static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
+static ssize_t write_sysfs(const char *path, char *buf, size_t buflen)
 {
 	ssize_t numwritten;
 	int fd;
@@ -916,7 +916,7 @@ static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
 
 	close(fd);
 
-	return (unsigned int)numwritten;
+	return numwritten;
 }
 
 static int sysfs_read_string(const char *path, char *buf, size_t buflen)
@@ -941,7 +941,7 @@ static int sysfs_write_string(const char *path, const char *buf)
 	len = snprintf(tmp, sizeof(tmp), "%s\n", buf);
 	if (len < 0 || len >= (int)sizeof(tmp))
 		return -1;
-	return write_sysfs(path, tmp, (size_t)len + 1) ? 0 : -1;
+	return write_sysfs(path, tmp, (size_t)len + 1) > 0 ? 0 : -1;
 }
 
 void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
@@ -1047,7 +1047,7 @@ static int set_epb_sysfs(int cpu, int val)
 	char path[SYSFS_PATH_MAX];
 	char linebuf[3];
 	char *endp;
-	int ret;
+	ssize_t ret;
 
 	if (!has_epb)
 		return -1;
-- 
2.45.2

