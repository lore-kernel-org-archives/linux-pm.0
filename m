From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 3/3] thermal: tegra: Combine two seq_printf() calls into one
 in regs_show()
Date: Sun, 7 May 2017 11:53:54 +0200
Message-ID: <7933cca2-2ec4-7b53-a935-6b4c66bee23d@users.sourceforge.net>
References: <b0795133-ebb9-56b3-567d-b3773f298789@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b0795133-ebb9-56b3-567d-b3773f298789-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Sun, 7 May 2017 11:08:42 +0200

A bit of data was put into a sequence by two separate function calls.
Print the same data by a single function call instead.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/thermal/tegra/soctherm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 1b3915588bce..3024c4294131 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -655,8 +655,6 @@ static int regs_show(struct seq_file *s, void *data)
 	for (i = 0; i < ts->soc->num_tsensors; i++) {
 		r = readl(ts->regs + tsensors[i].base + SENSOR_CONFIG1);
 		state = REG_GET_MASK(r, SENSOR_CONFIG1_TEMP_ENABLE);
-
-		seq_printf(s, "%s: ", tsensors[i].name);
-		seq_printf(s, "En(%d) ", state);
+		seq_printf(s, "%s: En(%d) ", tsensors[i].name, state);
 
 		if (!state) {
-- 
2.12.2
