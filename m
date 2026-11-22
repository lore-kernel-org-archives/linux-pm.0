Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795324347;
	b=I/9Mu8ABz74VRU894WON9dvEjLpLSjh/drDTLXaAfjoj+H+dC0Webnv0t+SZW7YXN7Z3
	 wZfm9yJDDgyG4xlDH5SHEpv02xH+bNJmsSu44AU/en1/LkPziCnEnaJorDPYtnXonz5BA
	 a/CKuxYgC4+btlKa2YSX26u8CU6PnNuahh8LJI7sgGb0IWvK8FbzBsFW7GOIXPBEOUx4Z
	 08tuVgj7oVYrxb109UV+CAX5eBkM3Qyfu3o0CpPwXjHRs5qwiI/8BEyQkGpazLli3jQ2a
	 LRybnIQgfK2YgtYt9zG9jOqD9Pajv0l7YIK1xCd+DS5PmV2nVqYfX7PIdsbVna3TRug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324347;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Piq2v6sl+foYU5A7C8grQ+SWm5mTDQbyIxGWQh7Zb84=;
	b=H0waFXxXVzwyMaRLV2YH8gPB2CFXN5tdZqxY/ddS2K1ZhoEe6+wOUsqYwHmttD/QoyjL
	 tk4NyfJuYL5qNQZY5Y+GurEd9w5kSWf+bgF8mfSlscQz5GEQJadamPrIs3BmYP8EfN5Ub
	 ms1CcOeJ9vaLTUSSPHHYXVeUeO9Yt7tOkzeHoxDmVNsjgNO0pGWDjoWTHJIiEeWbZWsIX
	 YwTd3YAZAi0tKHJ747/1XcnuyDC5F8CXHQCL2jvMAz8e42AQsLBxfaylAB66mJEDLDT2s
	 CkRu5ElzQKlVaAslmguYSUiB9ePotkVBjQzunM/r/rXhFqRaw1gEOrqY16tnzAEU4MQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YZfZG9G/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DF606A32A;
	Sun, 22 Nov 2026 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZfZG9G/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795324346;
	b=ri6qWwLcDTPg007lRvcqv2XCRwUbzm1sIg4U7mBQEoonP4gkcvVyn+f0X1g35u+AEQ4F
	 j3nhBQ3lwM6WgyC+hYZQeDvjZikdHxTwQVAFe7IGyNW9fDxHlI43SL0dn9543pYavEJJ1
	 V6ekOWHRJHqfm1VifQhfBlPjy8rNS9rmgmgx6Abt3ZQjBDrCiAXQaw04CaUX0oZKc4LIM
	 VcWE70iRGzC0yXWn4P/6QS8rfZgMahnrkuq6w/qKZv02Qh5Y2yteXJpZvoCY44SZ111G2
	 qKOgYSvq2UByI5j8BmnEHjErfGzfg2RlJHaVU57HGyZqkDaaaP9iiwydUpNb8PNvC6g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795324346;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Piq2v6sl+foYU5A7C8grQ+SWm5mTDQbyIxGWQh7Zb84=;
	b=RENT02wpf1zIuGWsnikL46jli3QVtzpXHzGew6e997H666QpUW/lJ/NIvGWQ2DkaMlZS
	 wGsGjOSDiBelSvGH+JiAXbhIgLku1adTMvw5pdktO0Gy1QYV0i71ZHgtjVDUUeQSiT70g
	 SNU2UwczvoSQkJUoWLHY7YVt6V0AfA0WBBjmQUxfCa2IA8mupvEuwEFmN4Wm4FK7Tlybj
	 80f02Bqiq4XfVxs7FijqwTtat+Fi2AbivKiOA+axLJm41b8tSriCDN7eMxa1o5rCDx9xd
	 EQOsI2blMht/8FGA4gGbGvcBs4LHZG/RfId3UTkd3px55NVjp2ni+sozZVIlysB1mLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6D9071F000C0;
	Sun, 22 Nov 2026 05:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324346;
	bh=Piq2v6sl+foYU5A7C8grQ+SWm5mTDQbyIxGWQh7Zb84=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=YZfZG9G/MrZRWEnuqVZsv8Hp9gTp+CnrT/MxVWH/Ob8h+b7ECB4J8IuI8Yh+JujVC
	 5RBupNNru6u7xCV6+WNqMlCzcpPjH+lQBj0+MkgQKZ/PkUndPi7eAMt/vceoPppXSw
	 vhM5VCzMNY2e0GuNNXzxPLPMpqV+6gRNrq94VUJOdBCiOJhsjuqBIkF75QT4B75PH3
	 95KTV6Y5EVoNT2QUdn68agsrPzgk9xoE1iiRn+uI5hrWt1gQMptBTSqKJqX9mkAWyn
	 Wkda+X4zfUpl9XJAYY5oL+LJr9OrbuJV7hB7u6HfSPcXdsDIZOqZp4Gd1oe2SKXyNk
	 WS9xqmg4OzHpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F25E14BEEE;
	Sun, 22 Nov 2026 05:12:25 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:12:24 +0000
Subject: [PATCH] thermal/drivers/tegra: Sign-extend the extracted
 shifted_cp
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-tegra-soctherm-shifted-cp-v1-1-528e3621226c@enser.io>
X-B4-Tracking: v=1; b=H4sIALd5AmsC/yXMywrCMBCF4Vcps3bUxJKCryJd5DJpItiWmViE0
 nc30eV3OPw7CHEmgXu3A9OWJS9zhTp14JOdJ8IcqkFftVFKa3Q9FprYoiy+JOIXSsqxUEC/or0
 5PURjTFQBamJlivnzyz/Gv+XtnuRLa7aHs0Lo2M4+tanxsg3nHtlrOI4v6YOPbaAAAAA=
X-Change-ID: 20261122-b4-tegra-soctherm-shifted-cp-a3b27f666f1d
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Wei Ni <wni@nvidia.com>, 
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324344; l=2716;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=1sMu9mVDGd6aaArtCRb7zlONQ4RxQR24b0aSqbo+xiA=;
 b=tCR53qlWrAmq3smR2lCgPWXmohcgdE0R0LYNquoih7cWfLPWnmIgJ/N9R0EuV6bUy2Iq9r7gk
 CwCh6fupDOjC+FrD3wpnc5VmhROGZOGrveWGP1F0qokku9JRTVRxAYF
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
Reply-To: emcp@enser.io
Content-Transfer-Encoding: 7bit

From: EMCP333 <emcp@enser.io>

tegra_calc_shared_calib() extracts shifted_cp from its mask and shift,
then throws that value away on the next line and sign-extends the raw
fuse word instead:

	shifted_cp = (val & tfuse->fuse_shift_cp_mask) >>
		     tfuse->fuse_shift_cp_shift;
	shifted_cp = sign_extend32(val, 5);

shifted_ft, two lines above, is sign-extended from the extracted value,
which shows the intent.

This was harmless while every supported SoC placed the field at bit 0:
tegra124, tegra132 and tegra210 all have fuse_shift_cp_shift = 0, so the
masked extraction and sign_extend32(val, 5) name the same bits. Tegra114
has fuse_shift_cp_mask = 0x3f << 10 and fuse_shift_cp_shift = 10, so it
reads bits [5:0] of FUSE_VSENSOR_CALIB instead, which belong to base_cp.
actual_temp_cp, and with it the THERMA/THERMB coefficients programmed into
SENSOR_CONFIG2, come out wrong. The hardware then flags most conversions
as overflowed and never publishes them.

On a Tegra Note 7 (Tegra114) seven of the eight sensors report an
overflow with TEMP_VALID = 0, their thermctl group registers stay at
zero, and cpu-thermal, gpu-thermal and pllx-thermal read 0 in sysfs. Only
mem-thermal reads a temperature. cpu-thermal carries the passive trip and
the cpufreq cooling device, so software throttling never engages. The
hardware thermtrip compares against the sensors directly and is not
affected.

With this change all four zones read plausible, distinct and moving
temperatures (cpu 32.5-33.5, gpu 30.5-31, pllx 34-35.5, mem 31-31.5 C on
an idle unit).

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Fixes: 65b6d57c24ed ("thermal: tegra: split tegra_soctherm driver")
Signed-off-by: EMCP333 <emcp@enser.io>
---
 drivers/thermal/tegra/soctherm-fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegra/soctherm-fuse.c
index 8d37cd8c91..2de1d0cb67 100644
--- a/drivers/thermal/tegra/soctherm-fuse.c
+++ b/drivers/thermal/tegra/soctherm-fuse.c
@@ -102,7 +102,7 @@ int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
 
 	shifted_cp = (val & tfuse->fuse_shift_cp_mask) >>
 		     tfuse->fuse_shift_cp_shift;
-	shifted_cp = sign_extend32(val, 5);
+	shifted_cp = sign_extend32(shifted_cp, 5);
 
 	shared->actual_temp_cp = 2 * NOMINAL_CALIB_CP + shifted_cp;
 	shared->actual_temp_ft = 2 * tfuse->nominal_calib_ft + shifted_ft;

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261122-b4-tegra-soctherm-shifted-cp-a3b27f666f1d

Best regards,
--  
EMCP333 <emcp@enser.io>


