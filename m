Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017230;
	b=AnPjV+GC3WXcWS2JesyNuQbdZtvrOUkZQ2t59rFRSY/hh0xZDw4xSGhLv5Svn2APAXL+
	 YYR0eo//BtuACbZcMrujSGk4KbvaVT4dFa47CRfkgP7esmBLT8AxLbra+sTgOXstz9InT
	 tVYgrYX0msPt7Ztjk1SzRLzGxDidMb5QjA+GcaV8FSccblaAVcRNb4gfv3oJ3opL5ZeXe
	 Wkriqpmrr+nbMTsEhfDWajf538hSzs8LUCPQAh/z/y67HTxjomYv6MwQDjIpGHXKay3Bi
	 x1wwXKVLZ8oQH82oCGqv0UpyQ2MRnPJyNjo9Vzfc0qouO92eev5EQGjgabZWboLtBCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017230;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ATsBvPQeZ+0DWGOQXf47upSNBvw/9e4Viq5CdLJoK8k=;
	b=DGr/SvqqqD8aE5uXSm7qQ0/UHM6JccCWU9L1nCZoyuVeEAh+jMNdeIVWx4Om0yMeMBXD
	 D92WY9Pg0/fQfIVM43u7Pq3IGzarZCHW3tGGkF2gn3mhzIza5txYY/OTi7Pfw0UO9RCth
	 rR3QSpv6Q8UGGyhi9L5NHBv4BR1dH2MVFroc+V+I8K1Ntrla+iqnH8vfgXqafvsZ1t1GX
	 3iAzTrCp2KfmE0UfiVw4assue6DpyGFAWu0dCW1YBJzCWAjW+1LDznJo6+EOug0NNNfz0
	 1g7rqP/QDRpD4xWlQ0JatC2VVRf6Q8DnYE+LXeyYKWVfZbFmH8ZwuKZnD29Etse39Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=Pa5sOIv0;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DD606A325;
	Wed, 18 Nov 2026 15:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC0DD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=Pa5sOIv0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1795017222;
	bh=0xCKQAQ/uxlRRF3Jf6jbviGNyLZtmwjhQVBX3NEIr4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Pa5sOIv0LrylxYm1yf74SFYPVPpDFm++v/AEtoR6ffl+DNnt1HfjGOMfYucL9DApJ
	 l0j+aepLtJXP/Z3Td3YgqkdQAR2WKcX/+8/PH5CydkAFtXUQs8YAGmgCvpYtuFLRSQ
	 Wvwp6mJiG+VZNuY+trZQrmbBmTkniqjqhSlHi79ZbvjH/kY7/ZmWnooKP+0ke8WEJL
	 iWhnDJ8Onb5UbCAX9ERJqLoscS+sPnWo47BYBl7lcRkrk1mSqZ3x0ZVUAIHtNR8V7s
	 9y+z9ArT5xip6oJvjQPWpooIcecwsl+ot1YXYim75SLj2WUv5pq49cK2O0jy6WRGE8
	 YHqAyjfDPkArw==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id D63C081A5F; Wed, 18 Nov 2026 15:53:42 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Jean Delvare <jdelvare@suse.de>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: intel_pch_thermal: Add 200 series PCH-H device ID
Date: Wed, 18 Nov 2026 12:53:13 -0300
Message-ID: <20261118155313.2067857-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PCH thermal sensor on 200 series boards (Z270, Z370, X299, ...) is
8086:a2b1 and it's not in the ID table, so these boards, including mine,
get no PCH temperature at all. The 100 series (Skylake) and 300 series
(Cannon Lake) are there, Kaby belongs perfectly in between, I see no
reason to not have it there.

It's the same sensor. Intel's own datasheet (335193, chapter 21.2) has
the register layout the driver already uses, so just add the ID and
point it at PCH_BOARD_SKL like a131.

Tested on an ASRock X299 Taichi, Kernel @ 7.4-rc3 with this patch. The
driver loads by itself and the BIOS already turns the sensor on, so it
just reads it. The zone shows 66°C / 115°C Crit, the readings look
correct.

Adding the ID has one more effect. I am not going to call it a side
effect but more, an intended effect? AFAICS these boards were just
missing the s2idle cooling delay that the 100 and 300 series already
have, and now they get it. X299 usually runs above the 50 C threshold,
it would wait the full 60s. Meaning that the wait *WILL* be present.

The reason I am saying it *WILL* be present, is that I could not put
this specific box to suspend, due to the GPU not allowing it under Linux
and X299 not having onboard GPU on the CPU. But I manually followed the
path (intel_pch_thermal_suspend_noirq()) and it seems to be precisely
what will happen.

I am not the first to notice this. Henry Bent put a patch in bugzilla
back in 2024, and Jean Delvare asked about it on linux-pm last year.

Link: https://cdrdv2-public.intel.com/335193/200-series-chipset-pch-datasheet-vol-2.pdf
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219197
Link: https://lore.kernel.org/linux-pm/20251222154444.496284d9@endymion/
Signed-off-by: Magnus Leatti <magnusleatti@kernelriot.com>
---

Thanks,
Magnus

 drivers/thermal/intel/intel_pch_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 074bc8ca5f0f..7d8803608486 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -24,6 +24,7 @@
 #define PCH_THERMAL_DID_WPT	0x9CA4 /* Wildcat Point */
 #define PCH_THERMAL_DID_SKL	0x9D31 /* Skylake PCH */
 #define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100 series */
+#define PCH_THERMAL_DID_KBL_H	0xA2B1 /* Kaby Lake PCH 200 series */
 #define PCH_THERMAL_DID_CNL	0x9Df9 /* CNL PCH */
 #define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
 #define PCH_THERMAL_DID_CNL_LP	0x02F9 /* CNL-LP PCH */
@@ -372,6 +373,8 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
 		.driver_data = PCH_BOARD_SKL, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_SKL_H),
 		.driver_data = PCH_BOARD_SKL, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_KBL_H),
+		.driver_data = PCH_BOARD_SKL, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL),
 		.driver_data = PCH_BOARD_CNL, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1

