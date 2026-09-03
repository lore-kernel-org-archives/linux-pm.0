Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46B455618;
	Thu,  3 Sep 2026 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436625; cv=none; b=QhbkK9G8wrht3csE/tzN5YuJ4F5mi6bl6PHiNzHmNe3Mkux4nXHO1oZoJK8J+iSlJTnZhEhPbxrThcD+ezsK426rWK/nVspwpGZkusSIrq3Iyvq9U8jvoiUz3k5MlFytJT0m2NggGYzf1GRFavwAbHUMaDtQ2EbscPcgQhjvpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436625; c=relaxed/simple;
	bh=Bv9WcQB1oT6MsXEA5lnWHXubSs8k5jv2bQOWTKy5HC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqE0Pn+hTUlf85VqjXJizGHozbmDZHjwUi3o5+hMkWMatyx3zRswgRUWYYAFu8S3B3wr1ESRHZVeCtf03V3xZwQmTmIMp35q92KT5S5dlmHmmiGzTfcFdl4W49y+mJ5CK0kPsu7/l+R65kD2i8FH2cAHa9fTQd++63M4iBEAlU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF551F000E9;
	Thu,  3 Sep 2026 11:56:59 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: renesas: rcar: Make area arrays const
Date: Thu,  3 Sep 2026 13:56:56 +0200
Message-ID: <fbe8b4a4d90f0b555285cfb4ed18b6a2afc38b74.1788436280.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arrays of rcar_sysc_area and rcar_gen4_sysc_area items can be const,
unless they are modified by quirk handling.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/r8a7795-sysc.c  | 2 +-
 drivers/pmdomain/renesas/r8a779a0-sysc.c | 2 +-
 drivers/pmdomain/renesas/r8a779f0-sysc.c | 2 +-
 drivers/pmdomain/renesas/r8a779g0-sysc.c | 2 +-
 drivers/pmdomain/renesas/r8a779h0-sysc.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a7795-sysc.c b/drivers/pmdomain/renesas/r8a7795-sysc.c
index cbe1ff0fc58393e4..2ed377b58846628d 100644
--- a/drivers/pmdomain/renesas/r8a7795-sysc.c
+++ b/drivers/pmdomain/renesas/r8a7795-sysc.c
@@ -13,7 +13,7 @@
 
 #include "rcar-sysc.h"
 
-static struct rcar_sysc_area r8a7795_areas[] __initdata = {
+static const struct rcar_sysc_area r8a7795_areas[] __initconst = {
 	{ "always-on",	    0, 0, R8A7795_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
 	{ "ca57-scu",	0x1c0, 0, R8A7795_PD_CA57_SCU,	R8A7795_PD_ALWAYS_ON,
 	  PD_SCU },
diff --git a/drivers/pmdomain/renesas/r8a779a0-sysc.c b/drivers/pmdomain/renesas/r8a779a0-sysc.c
index 54cdf250f7c2d143..5f84b8d56a3282a7 100644
--- a/drivers/pmdomain/renesas/r8a779a0-sysc.c
+++ b/drivers/pmdomain/renesas/r8a779a0-sysc.c
@@ -11,7 +11,7 @@
 
 #include "rcar-gen4-sysc.h"
 
-static struct rcar_gen4_sysc_area r8a779a0_areas[] __initdata = {
+static const struct rcar_gen4_sysc_area r8a779a0_areas[] __initconst = {
 	{ "always-on",	R8A779A0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
 	{ "a3e0",	R8A779A0_PD_A3E0, R8A779A0_PD_ALWAYS_ON, PD_SCU },
 	{ "a3e1",	R8A779A0_PD_A3E1, R8A779A0_PD_ALWAYS_ON, PD_SCU },
diff --git a/drivers/pmdomain/renesas/r8a779f0-sysc.c b/drivers/pmdomain/renesas/r8a779f0-sysc.c
index 6ed13cd1cb249df5..d22cbc33a6048c9d 100644
--- a/drivers/pmdomain/renesas/r8a779f0-sysc.c
+++ b/drivers/pmdomain/renesas/r8a779f0-sysc.c
@@ -11,7 +11,7 @@
 
 #include "rcar-gen4-sysc.h"
 
-static struct rcar_gen4_sysc_area r8a779f0_areas[] __initdata = {
+static const struct rcar_gen4_sysc_area r8a779f0_areas[] __initconst = {
 	{ "always-on",	R8A779F0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
 	{ "a3e0",	R8A779F0_PD_A3E0, R8A779F0_PD_ALWAYS_ON, PD_SCU },
 	{ "a3e1",	R8A779F0_PD_A3E1, R8A779F0_PD_ALWAYS_ON, PD_SCU },
diff --git a/drivers/pmdomain/renesas/r8a779g0-sysc.c b/drivers/pmdomain/renesas/r8a779g0-sysc.c
index 249cf43af45b6445..96d39a3ac46056af 100644
--- a/drivers/pmdomain/renesas/r8a779g0-sysc.c
+++ b/drivers/pmdomain/renesas/r8a779g0-sysc.c
@@ -11,7 +11,7 @@
 
 #include "rcar-gen4-sysc.h"
 
-static struct rcar_gen4_sysc_area r8a779g0_areas[] __initdata = {
+static const struct rcar_gen4_sysc_area r8a779g0_areas[] __initconst = {
 	{ "always-on",	R8A779G0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
 	{ "a3e0",	R8A779G0_PD_A3E0, R8A779G0_PD_ALWAYS_ON, PD_SCU },
 	{ "a2e0d0",	R8A779G0_PD_A2E0D0, R8A779G0_PD_A3E0, PD_SCU },
diff --git a/drivers/pmdomain/renesas/r8a779h0-sysc.c b/drivers/pmdomain/renesas/r8a779h0-sysc.c
index e13372cb80eea857..3775735854f29fab 100644
--- a/drivers/pmdomain/renesas/r8a779h0-sysc.c
+++ b/drivers/pmdomain/renesas/r8a779h0-sysc.c
@@ -11,7 +11,7 @@
 
 #include "rcar-gen4-sysc.h"
 
-static struct rcar_gen4_sysc_area r8a779h0_areas[] __initdata = {
+static const struct rcar_gen4_sysc_area r8a779h0_areas[] __initconst = {
 	{ "always-on",	R8A779H0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
 	{ "c4",		R8A779H0_PD_C4, R8A779H0_PD_ALWAYS_ON },
 	{ "a2e0d0",	R8A779H0_PD_A2E0D0, R8A779H0_PD_C4, PD_SCU },
-- 
2.43.0

