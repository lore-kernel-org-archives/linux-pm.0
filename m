Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422172;
	b=mPdd9OoH63f0//WdEWK37ifOuxiwGZIkYD3risr9ib590R+cf5j9o6hCEa7gRZytmcJ9
	 9QBm/qmfIeJ9T0+1Ca/rdhMaY0AeNbF3zkAl3Or4ZF/KUEqzM/MgTG+Ut0bvzAsI5NpEf
	 5X6jyHpug0pBk+CoyANfDiDm+Fgl6qwFNM3KMYTD5VqRjpkyKml31VkvUK9dTg076WQf3
	 7RSE98sQryRE0WkDxsGhDbruqOaA4swFYV+qob2nXR3/ZhsEsHcsvycN+5mrhwDBF4GOl
	 wvbReEmDL3MsRqXdSO2fLzz4pn2XHJO1slvFaSkpqoMSdlYphLu7rm4504tr70UjhXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422172;
	h=Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=cEbvoxcKS/0pIj9ECSa5Hcsu/33mnBcjQ5671nz9eWU=;
	b=rPdv9XpSIDLYUDsxPH5E0o9ODbUdmRab66FUkSLMHQOHboFufVonIu9Uq4Siph4TYqat
	 dxm+zVfdNnbJcePxlckbA2kYf5uGwDZZMcUExOYuEiBYWCjyO61f8g7fjQdh2n8CtNhIY
	 DHc84lQEeeI6iyTi+5y0j6yw2rgT4SjDQC3tdcqFIcBcpx6qrNOv7xz4HiIHLUon57KjA
	 t90h3K28or1T4IUx2C+QKIYu9dFIuUdEZMaFG4lUpKDtg0TzBlxKe0SzO6UbT9HZuUHT3
	 JAJJl0jl0GPUR3s8eQv7dMoCw+ZKlFaAKU1NrRUZrg0BbVAREAzvsXW5LYWwnrDptzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihX4XA48;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA70E607BF2B
	for <linux-pm.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihX4XA48
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF006513D0
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422172; cv=none; b=bk7iC+pI50WiT0GY08J1XeUekAoCm2fzWhHcsCS7KvNOy+HdYQeqNTSqk1d2DaHboC76SR1ZgWMG+uWDi76yLKk77V/vBJs7CSXad+RKQk9Z0/0gdrW7HC6G1hmX8Dm/UxcEKVwbQgGjyCrI3C9z+0abC6p3zfazVznfsnFpoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422172; c=relaxed/simple;
	bh=FzpgoMyNMMxW2b6zvewguJGTnMhh+wuiOABzLArzlto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvkl+wNlSJqqmb7gV/LIv2JAdWesamXUijkFlKhBHviZM5TVQtv0zWoHxTGgBhxPHgPLmlkz2asY/r6z8jz0YnlVSBHxDy+Qc/5sFKj6RLdpxHZxoDQG1rrH8vPuECiDpxZYLbttYydppG3L6mv0Ry/eh22PRCZIg7F0eYOA6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihX4XA48; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B875D1F000C5;
	Mon, 19 Oct 2026 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422171;
	bh=cEbvoxcKS/0pIj9ECSa5Hcsu/33mnBcjQ5671nz9eWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=ihX4XA48Hm2619zc4ceyrPD727ZS3AVlMwG2HSlJ0digGeO3KzOv/+NAQYJLz5aeF
	 9qOmOKSzU10posx/Ji/32VGprIItS/Fv0isy5oZut+NE9V7F2zKUIMcN9UfiVfpmOJ
	 iMo9ziRLvFpHdAw5EEfhfaQWZWqkTg6g6mqBmqGoAgGNBpkvKNve2GsGvDBN7Xm5k/
	 LvAJp0tsOOjfcLhik5uQzBunwtOe/oaaX4T/35Vl/nxRw49wHv+NOxLsVEaxK9KiT/
	 j/VTAh0mrS0WgBA3sDRkHoNOPPULeW9ylhWPqLzk5/UkOdeCPdGk66OgN5BFTbFfj/
	 plqH5jk1P6KYg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 03/23] tools/power turbostat: Rename: Differentiate counter and CPU sets
Date: Mon, 19 Oct 2026 10:38:36 -0400
Message-ID: <afa7b0f63a7bf59c0db0abc91df5c11544a6ab91.1792420722.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
References: <962d0202306072651ef459abf1f7240c73afaee1.1792420722.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Sets of Built-In-Counters (BICs) are implemented using cpu_set_t.
Since cpu_set_t is also used for sets of CPUs, invent
the name "bic_set_t" to make it more clear which is which.

typedef is discouraged by kernel coding checkers,
but is appropriate here -- and better than #define.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 34 ++++++++++++++-------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8054716207b0..b4403b4ed2c8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -290,7 +290,9 @@ enum bic_names {
 	MAX_BIC
 };
 
-void print_bic_set(char *s, cpu_set_t *set)
+typedef cpu_set_t bic_set_t;	/* implement bic_set_t using cpu_set_t */
+
+void print_bic_set(char *s, bic_set_t *set)
 {
 	int i;
 
@@ -306,17 +308,17 @@ void print_bic_set(char *s, cpu_set_t *set)
 	putchar('\n');
 }
 
-static cpu_set_t bic_group_topology;
-static cpu_set_t bic_group_thermal_pwr;
-static cpu_set_t bic_group_frequency;
-static cpu_set_t bic_group_hw_idle;
-static cpu_set_t bic_group_sw_idle;
-static cpu_set_t bic_group_idle;
-static cpu_set_t bic_group_cache;
-static cpu_set_t bic_group_other;
-static cpu_set_t bic_group_disabled_by_default;
-static cpu_set_t bic_enabled;
-static cpu_set_t bic_present;
+static bic_set_t bic_group_topology;
+static bic_set_t bic_group_thermal_pwr;
+static bic_set_t bic_group_frequency;
+static bic_set_t bic_group_hw_idle;
+static bic_set_t bic_group_sw_idle;
+static bic_set_t bic_group_idle;
+static bic_set_t bic_group_cache;
+static bic_set_t bic_group_other;
+static bic_set_t bic_group_disabled_by_default;
+static bic_set_t bic_enabled;
+static bic_set_t bic_present;
 
 /* modify */
 #define BIC_INIT(set) CPU_ZERO(set)
@@ -332,7 +334,7 @@ static cpu_set_t bic_present;
 #define DO_BIC_READ(COUNTER_NUMBER) CPU_ISSET(COUNTER_NUMBER, &bic_present)
 #define DO_BIC(COUNTER_NUMBER) (CPU_ISSET(COUNTER_NUMBER, &bic_enabled) && CPU_ISSET(COUNTER_NUMBER, &bic_present))
 
-static void bic_set_all(cpu_set_t *set)
+static void bic_set_all(bic_set_t *set)
 {
 	int i;
 
@@ -346,7 +348,7 @@ static void bic_set_all(cpu_set_t *set)
  * bic_clear_bits()
  * clear all the bits from "clr" in "dst"
  */
-static void bic_clear_bits(cpu_set_t *dst, cpu_set_t *clr)
+static void bic_clear_bits(bic_set_t *dst, bic_set_t *clr)
 {
 	int i;
 
@@ -2783,7 +2785,7 @@ void help(void)
  * for all the strings in comma separate name_list,
  * set the approprate bit in return value.
  */
-void bic_lookup(cpu_set_t *ret_set, char *name_list, enum show_hide_mode mode)
+void bic_lookup(bic_set_t *ret_set, char *name_list, enum show_hide_mode mode)
 {
 	unsigned int i;
 
@@ -11620,7 +11622,7 @@ void cmdline(int argc, char **argv)
 			 *  multiple invocations simply clear more bits in enabled mask
 			 */
 			{
-				cpu_set_t bic_group_hide;
+				bic_set_t bic_group_hide;
 
 				BIC_INIT(&bic_group_hide);
 
-- 
2.45.2

