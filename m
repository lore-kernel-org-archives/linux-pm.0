Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.12.242.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793524520;
	b=C5LSO1r5RkKY+6qyUZJekffnJ+5bctaTEXew5u9omOvaYtaxdYP9PD1hv24gPFhkRZbL
	 BWLBr5hLc83t7H+Nhxe2lcsi/QGl9lyEAsk+2bOSY50IiZl1/YvvRYwC42eB6TMCh4h+x
	 /Ut/Cd+xwP5nFpv76Gc8zP0xeXyGtz8aBL7iH0Sp1pod3MlV83YvmF4C9CRYejTO9wL83
	 UVBgz0GaWk0teySag1I8s95PLG3MrD+BhDgYxDFpsANWJKlqOy3I8i+eD7ei4lSCFBzVy
	 k/UlY/8PHn4tNH+8Jm5Ei2oJfGlleXjguNzvcBTsFx5aNma/UdBkfDBwzkaD1I6fVAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793524520;
	h=DMARC-Filter:Received:DKIM-Signature:X-ME-Helo:X-ME-Auth:X-ME-Date:
	 X-ME-IP:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hpAYGvjX3DPYXJqhuECAIb7VRmhCJAkGQrZ4pOyjybg=;
	b=Uigd/Wv4/gNLE2OFkUx5vLjvGiFSmaO4SsCcPhQwTM3F6MSQi8cODqTcuRM/Zp9YMDXt
	 hYiKtlGsHWLOoqrlTS4Udx2l0L5/ewQV5siJrGoCS9PGuQ316ZW5C3tUnywCcAsDmKHN2
	 FW6WPYw04DEZZTmhxllssqQW36oVmC21GeR++rzq57/oZT9q2wV7Km+If8UrtFF7m5G+S
	 if130L4m7paT4Bhqo+isMdvr6YXC1FpzwfyxlKrfeNjI3OnQIdmzVLFhXNe3f7coVrWpu
	 24x3BTwt6yHEhRIWfqGpC4Aht/thQ5wqEK/Ro+I9wn7G1B2u1OQ8n7fG82etn1nX3nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wanadoo.fr;
	spf=pass smtp.mailfrom=wanadoo.fr;
	dkim=pass header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=d7ywW8Tr;
	arc=none smtp.remote-ip=80.12.242.13
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F286606A324;
	Sun,  1 Nov 2026 09:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F286606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=d7ywW8Tr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id NRegxTj34LDKZNRehxO0lB; Sun, 01 Nov 2026 10:15:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1793524511;
	bh=hpAYGvjX3DPYXJqhuECAIb7VRmhCJAkGQrZ4pOyjybg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=d7ywW8TrPZ9b3rPZx6fzmwfoG/zazFagDyJsftf0yS5MI6jCc2vmAlLYKPt+LrNDl
	 dot0II+ClwEcsWr4AZy4Pg0hDEYRzvdLCzmeJ9r8KNiAnWhIRPn55BR3vaCssaf9FO
	 dYVek7MU0aBcUKFEhPaMijokzyFrWFmBn7a0zzwiAMrGLakO/x/JwzCBPKCbHKTr8J
	 cUhSKNhAYg3ydCq1QYZr7lRAOnqZPXRCwss/V3Er0ul1VI7AHaYyn1K90qOM1+KMBB
	 rNwt9LRrrSLKjH3Sjy4I45SYQkxl5AY92P8DW22Lry4lW1PJ1qsAE/zIB8EutpqhvS
	 mGr8Jv/p6tKdg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Nov 2026 10:15:11 +0100
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org
Subject: [PATCH] powercap: dtpm: Constify some structures
Date: Sun,  1 Nov 2026 10:15:06 +0100
Message-ID: <a4737f7c69e044d35348c1e9c7f69f229070d29b.1793524483.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct powercap_zone_constraint_ops', 'struct powercap_zone_ops' and the
'dtpm_node_callback_t' array are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  22049	   7736	    128	  29913	   74d9	drivers/powercap/dtpm.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  22273	   7512	    128	  29913	   74d9	drivers/powercap/dtpm.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/powercap/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b7a65e543f19..3413318401fc 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -296,7 +296,7 @@ static int get_max_power_uw(struct powercap_zone *pcz, int id, u64 *max_power)
 	return 0;
 }
 
-static struct powercap_zone_constraint_ops constraint_ops = {
+static const struct powercap_zone_constraint_ops constraint_ops = {
 	.set_power_limit_uw = set_power_limit_uw,
 	.get_power_limit_uw = get_power_limit_uw,
 	.set_time_window_us = set_time_window_us,
@@ -305,7 +305,7 @@ static struct powercap_zone_constraint_ops constraint_ops = {
 	.get_name = get_constraint_name,
 };
 
-static struct powercap_zone_ops zone_ops = {
+static const struct powercap_zone_ops zone_ops = {
 	.get_max_power_range_uw = get_max_power_range_uw,
 	.get_power_uw = get_power_uw,
 	.release = dtpm_release_zone,
@@ -470,7 +470,7 @@ static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
 
 typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
 
-static dtpm_node_callback_t dtpm_node_callback[] = {
+static const dtpm_node_callback_t dtpm_node_callback[] = {
 	[DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
 	[DTPM_NODE_DT] = dtpm_setup_dt,
 };
-- 
2.56.0

