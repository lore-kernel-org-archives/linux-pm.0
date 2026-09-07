Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561A416875
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763675; cv=none; b=u854plzy/R4PFMQzI+j/QAU89grvLmf2CS/Om34ayTb+1uiWETGSU45ImveSIGtK6RrpRk/eT50yaChgoUQ0hf6+PIPtVXJnVShWBKY5jY80qFhMnlB47OW5+W/gf9+N2Hmb+m4qGaNr+mZdpN3F9+mxrnaf6UlbskTAnQFHI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763675; c=relaxed/simple;
	bh=p91ao2AKO1u40gx02a/XDSpFyO2CsKWUxeRtlMlap68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrfHvGziQ16bHqsPi5htpZz1plpx8Cv/egV4c/VBnGUYoOZ5e9LefsRCCUOtP4KI5DFySMcmiBpptiF231ZD8S5y2ePKkFjTcP6Z/P3BQJiFuMGDu4WysSQksZDWeM9ec/Ruumb4/quCQWLN/AxE1Ax7KTFMyfr3SdBogVmIWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEjHzrbw; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEjHzrbw"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so2443059a12.3
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763672; x=1789368472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIBBvWrmpup+w6AcHGzaJw3qF8lt2RTeR72Ssm270eo=;
        b=kEjHzrbwtRg1hg4bzJm7knqJe2KFnNf1OSbeA8WSAnrjQM2zPStzHl92eMayZ67S2f
         Rh3Qb/Cwmct/oY3uD10q1HnmJ4CIXqOTZqyf4nuPfpS0AL4ozel78IbL0krJo4eFKhGR
         QT5VibDE5/FrGVkkHOgobYfuNQ4R8+vk5F+HNgP8mvDBg880XowBvwtu7uzvGzP188qn
         zNCTOT2hqZSE2Lftix4aIHtVV+WxDT9oI1uKe9T7x54funPrKbh+50+pMZD8SnvUo/i3
         dbCR//vBRDmMpMSaPvaWvkCTWpkaJxCqhJDUqjOOE7c69mjWG1kIqATi6JwhadcZ9OUA
         xMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763672; x=1789368472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIBBvWrmpup+w6AcHGzaJw3qF8lt2RTeR72Ssm270eo=;
        b=i/BrJF0/b+QAj6WisXV8Wz6Xi7RziTUs16eiIg3D6Iaj9qs2TnuPwDtpzmx7ZX9pxf
         Me42b4lBC8Jup0UzP7xbwhzTRlUbe/LAPF3btk520tvEVmLd4+fkhVG9DE8k5TuAShwg
         V9prrIi6+ZqP25urWL4S8DoPoHxbFsL4/dWYaHyeKCyT4g70SvoSgFY7ey8vv8NZUiGW
         W4mLikdJO89vosIZd+DXNug8rbcaXu6RyqyH4f/Ceazns9s3CMCdceJ70dyUllQrNRyh
         4QrrRcnMr4KkSs6oszttI9fCjqYKYT1ASm33YILrJA7A3/I2AUWhEEIP5pC2PZyoMoSX
         iiog==
X-Gm-Message-State: AFuF++kwB4+9GMd10/u1Z+D58dgPfR4JfKPXwDe1TyWV6eI1UMMVhFb2
	0H2pHou0cSSItqusF98waCxUzHtguEtAwlen+bsHl5UMg+/NVp3zkW2w
X-Gm-Gg: AYBFou3vNL0SVMdmdwb8UaL2L722E6qEdbHNP4XbkWkilWLt7WvjWIXLOqVxIJZR1uT
	2Hf8DM8N/D0phE9FYV0hYrXeA3ZO8GBvM9iIEfwUD9AmsoSxvihe7GcsBhcRWY1joy28T1oasTS
	QkXrGXanCfj/wt2hoK777c6ArNxeBIdi6m44niDNBixTxCSqiphbuw2KfRSctwEqF0emJpKBDzj
	JqYSd6YEvgWmU1HiDaJhI63WvWzZejOkg2/f9sZ1XkPdBkE065A6ib8NBbbwsq++XY5MQfk+FWh
	dvgc9gQ2vVsA8vnvS30nHHBq5uBmQBxQLJpUIFYQiBQ0wB1EgV/XXwWxtX5z8Am3T9hYFKeitSU
	3XE11HehMltFamzyAnwMXLroK/NKm0cDVZMqQE+Kx14vhNSlvKN0c5G5eM90Cd1Mgu4N3ctJYjJ
	2FN/tPzZC+2oIP/V7TmAPESAbcCMk6J7RU9Vyps2jFT1NE7HIgoiOYbvuF0Sf71GMWB5Tm1xHGA
	GYUgfwx7HZjVQ==
X-Received: by 2002:a17:90a:d2c6:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-39b260d2f07mr32517136a91.3.1788763672025;
        Sun, 06 Sep 2026 23:47:52 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm24811158eec.9.2026.09.06.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:47:51 -0700 (PDT)
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
Subject: [PATCH 3/5] tools/thermal: fix typo "binded" in comments
Date: Mon,  7 Sep 2026 12:17:23 +0530
Message-ID: <20260907064725.10686-4-hemanth.selam@gmail.com>
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

Correct "binded" to "bound", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/thermal/tmon/sysfs.c | 2 +-
 tools/thermal/tmon/tmon.h  | 2 +-
 tools/thermal/tmon/tui.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
index cb1108bc9249..5d64aff12a86 100644
--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -225,7 +225,7 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_name,
 				cdev_name, cdev_name_linked, cdev_id);
 			tzi->cdev_binding |= (1 << cdev_id);
 
-			/* find the trip point in which the cdev is binded to
+			/* find the trip point in which the cdev is bound to
 			 * in this tzone
 			 */
 			snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d778f04..f347efb47c96 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -77,7 +77,7 @@ struct tz_info {
 	char type[256]; /* e.g. acpitz */
 	int instance;
 	int passive; /* active zone has passive node to force passive mode */
-	int nr_cdev; /* number of cooling device binded */
+	int nr_cdev; /* number of cooling device bound */
 	int nr_trip_pts;
 	struct trip_point tp[MAX_NR_TRIP];
 	unsigned long cdev_binding; /* bitmap for attached cdevs */
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 7f5dd2b87f15..b982c1d77402 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -238,7 +238,7 @@ void show_cooling_device(void)
 				unsigned long trip_binding =
 					ptdata.tzi[i].trip_binding[cdev_inst];
 				int k = 0; /* per zone trip point id that
-					    * binded to this cdev, one to
+					    * bound to this cdev, one to
 					    * many possible based on the
 					    * binding bitmask.
 					    */
-- 
2.48.1

