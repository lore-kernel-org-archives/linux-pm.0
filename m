Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED3415F2B
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763688; cv=none; b=gDhwnNuqwN91bcjVz6q1NHpwoQKfHufRRbTw+SDGabLBPQQ89+jfOktllbfYYFNf3hj131bpc2jA8cMf3KcTThRUn94v/JG+Thz8oQm+iK9KahRgNzcCsXLMdO0v+RZ05Dm1Oohg7xu2qvPNoHSLO6wDJr1RmBXRi7bBucgbpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763688; c=relaxed/simple;
	bh=NySkzWKGvAVQrs22Wj3YGugY/Vl4ZuUmyHXC/e0Qdz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4pSKpGxEG/J3K+ATjSST2y3KfV317j7lwgf4TGh+sS1quOSnGlF1xZy71xOnSLHwAXGGgjYzY9KUyzMwA3qucDUnqtZKjj/JR9CsjBJr0Y2mgjcl0/SjCqR04iHl/oJxjXlM3q00jCBZUwI3LwqS6pGV8eo+D8EJJNURg22glE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcmxg0Qd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcmxg0Qd"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2392604a91.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763684; x=1789368484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp3Y74c4rqp4LQw7mbFodFzkhcskiP8CvJ8q4Odm34Y=;
        b=pcmxg0QdhaGNJULz7S3WvjNFTMfgKEnfQ1lTzIJKt7RAkiFS2bIbnccWhd7edV+msg
         eZW1TE/UXd3aAnYa/UbJ/Vh/YnJGXPkczE/i+KPtxwS9xsYnDMNyY3aRoWwpt5AbZOYF
         U/T14xjPplnfMUBMcMmR2EJZizqH2g3dNQ+2nh9Pfz2nZ+NVypi8s/7kPnQLeLS+588U
         ineD/9arkUWnWG+W6H9J35qKfU1zihcCS4IAqodFNKl7dpagHbzrjd53C0/z+zAnieK2
         0VLOTRj1DFtJ7T3Hy7nQEJlsOF2C8RQYtrRwVhtGqnmHgHRAYUuBv1hNhIlmk3eLpQdN
         dbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763684; x=1789368484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sp3Y74c4rqp4LQw7mbFodFzkhcskiP8CvJ8q4Odm34Y=;
        b=KfFgKuCppxu0F0Jh8Mbv9f5TzMfxmhbVqXmcuy3UdCjvKY0tuE0P6vNZaHNiKG5CXA
         jMSiQlmSDyefAv5HdslTRlcHVyfNwS/xT0RmcB8+Ux2Z3xN1fgGKQu/pjS6b579KTOHr
         ZsWJ9UTsz0qA4i1BZC6eTG0kJ4veiMb4AiFQfIyQOxiSMBF1fOzQGVpc38Zif5004rAn
         aGxaYot5ujITwyGTQODEGq20ejOOWVXrdNMvg6+SfQ+NXGuHl3Vf+iben65OmwkMgbYN
         1RmgkFm6j34XlkntpXlpM7LWfteiiwVrI0JrmSajkvbOUG5Cxowt+4moOuUJrt6+xdkY
         La5A==
X-Gm-Message-State: AFuF++mVDqZ8fgz6sWwXQHUjVmVn4Bcxwkmaq3js56g4dU7C62TO8d5z
	CoLGIc6zRRU18RkfoCHqpL+TnVGrkCcgWEzRcswxH/2SG07rR4zReS68
X-Gm-Gg: AYBFou1YmvAvEeozW5HkTz5rLhMpjw+C3fCwA464LbOEKrx0Xt3kXro88VnR2oVhkMQ
	NZK0pkGWDvLkh9ZF3iYuLaEMo4KQpfu2Wj+EYeX36jfSrdTvgiZR7yTUyRaNE+ljRT3EIAfy/TJ
	yvkJB0J8nrdg7gf9UPdkGGA7xYWR2GUWZaY8TN9cMON5xf7Tun/2vnE9RxtySnUAbBXMgRFQkKT
	4MsLLmx8R0Jmqag+o6Bwx38oOLCpaOgPnUb1lcGhC0xQfrse/2AMfGqua2DkzNQygKw5Q1vxu/Q
	s96cunimLH9A7ks4PLuNxdTULxVnZJNiZKzg9h9RmjE44G+A3FASCL4rSUAb4yv7t20KdqsljDD
	q91VcU1YH0NZTNHHDtMrdTHOYIWalGJB50pEawm9YTI+IYTjJKAdOeJ8bDGiZlE+ytuIhL+Mxfb
	ku4wqBBs5tzDExD5nxQe4iJCHN2Z3+PjBMykz59J9POniiBuufCY8DIL4Md2U9RnDIQmawJVs6H
	ivnTh1jJ1U2gdjgvhdtzBAQ
X-Received: by 2002:a17:90b:3804:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39b25f4397emr32259222a91.0.1788763684190;
        Sun, 06 Sep 2026 23:48:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:48:03 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 5/5] ACPI: NUMA: fix typo in log message
Date: Mon,  7 Sep 2026 12:17:25 +0530
Message-ID: <20260907064725.10686-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064725.10686-1-hemanth.selam@gmail.com>
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the misspelling in a message the user sees, reported by
scripts/checkpatch.pl using the list in scripts/spelling.txt.

Only the message text changes, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 5c407dc6401e..f5616830f5a9 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -111,7 +111,7 @@ int __init fix_pxm_node_maps(int max_nid)
 			for (j = 0; j <= max_nid; j++) {
 				if ((emu_nid_to_phys[j] == i) &&
 				    WARN(node_to_pxm_map_copy[j] != PXM_INVAL,
-					 "Node %d is already binded to PXM %d\n",
+					 "Node %d is already bound to PXM %d\n",
 					 j, node_to_pxm_map_copy[j]))
 					return -1;
 				if (emu_nid_to_phys[j] == i) {
-- 
2.48.1

