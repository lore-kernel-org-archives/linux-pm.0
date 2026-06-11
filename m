Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69858233921;
	Thu, 11 Jun 2026 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179459; cv=none; b=AdkGWkCDOcvqfS0Z+WH3/+J5XdhE9uR1HTVRKxDB/AUTXS1Yjh9eKs6LpU0lbJqPm6eBzt8IeJLzpt3oLSg9KTXAYuGl+pRSChdOzunjzZiGUloVJt9JK7tkGEHCBIZuOPMZT+9C66pPHGkjI+iv//CodwOsT0WuXNWS4PHgRoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179459; c=relaxed/simple;
	bh=3kwtV54NM4YrZL2Q2PXOZIZmUTXBVQJ8RpM7LTyOgpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROXgJ080NJshrIRJ/JqZxW2slUsexH1nUX2btKFb9obR+QeF8L9iMRWMqUqZB0hw61SnQcuSOiDxjBDRTZMQ99ZCLVUQh+8u/oPoygeMuARteKvHL5NKWbExi2NBoR6axa0+oj6/oAkfDatQCCDeCepmu5TDK/OV1kcmYvcOs0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgKXrYwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgKXrYwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014F01F00898;
	Thu, 11 Jun 2026 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781179456;
	bh=oxERmxQN5cIxHWERRxvduzje+7MaL71qDVMZ0umHZHg=;
	h=From:To:Cc:Subject:Date;
	b=cgKXrYwe9SbezrApuBwydFVa9xWParEnSeLbgqsQc2O3u1SPfuDpo/iJdGl/LkfKf
	 8hATuLHvjunJxqLG1H1AzqEH8Wenu2EVz3qQb6bg+2ANh56MGcoih6zq4pOKo3YQ5i
	 L4Joas2FO5kGfPpsaHxoFJocS0SpElZ7DWSKyjk75dEo9uNWgSLaAFva5oBIP7CLar
	 C7QHhas1gJN5wYaxahPdGvXiGGKWEQtvpywOMBvkIxFl6Z0MAUgnMAOIS0iVFFBXxe
	 2F8rKF1/xgBDsKZAyqPmogL3Cs68A4r/b4PIbFc5Iv1Qk6LhuVu+5rLRI+TrjlGivm
	 q8H6DxTYVZBAw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wXe8r-000000021zW-39cz;
	Thu, 11 Jun 2026 14:04:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pmdomains: fix unused variable warning with !PM_GENERIC_DOMAINS_OF
Date: Thu, 11 Jun 2026 14:03:45 +0200
Message-ID: <20260611120345.484283-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The genpd provider bus is really only used when
CONFIG_PM_GENERIC_DOMAINS_OF is enabled, and since the recent deferred
initialisation of domain parent devices, the root device pointer is
otherwise unused.

Fix the unused variable warning by moving the definition of the root
device pointer inside the corresponding ifdef.

Fixes: ea1ca7623281 ("pmdomain: fix early domain registration")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606111746.kAxaAbwg-lkp@intel.com/
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/pmdomain/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 19eaee1819c8..f60eac6aa2ca 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -32,9 +32,6 @@ static const struct bus_type genpd_provider_bus_type = {
 	.name		= "genpd_provider",
 };
 
-/* The parent for genpd_provider devices. */
-static struct device *genpd_provider_bus;
-
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
@@ -2566,6 +2563,10 @@ struct of_genpd_provider {
 static LIST_HEAD(of_genpd_providers);
 /* Mutex to protect the list above. */
 static DEFINE_MUTEX(of_genpd_mutex);
+
+/* The parent for genpd_provider devices. */
+static struct device *genpd_provider_bus;
+
 /* Used to prevent registering devices before the bus. */
 static bool genpd_bus_registered;
 
-- 
2.53.0

