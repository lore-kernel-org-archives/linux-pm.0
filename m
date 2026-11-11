Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400674;
	b=r4sIHJFpGViVuUakZfeW6f/2vWVXytI2HGOe1Nbtfvgam0EKfUkzIOXfZJ7fu8iGk2IJ
	 xkyHCUorzPwms8VKW9zoLNKIrQjTUVI8YxfeB172ZnulOYgreRFX4JtH7ohcaW2T8mi7v
	 NNtyWg/RDCg8sfFFa+8Ioi9d3k9vm8rGUmT3dKx3opBIVKtq0q+YeIxXSKg8TV+rqCzj3
	 7SIU5tczqiyfWiiuEQ+I3FDPdlTcp6U1sD8tsYS5gs4zs0kl9hkAeaQ7UxBTix2Kg/ATK
	 caWDLu4E+AxC8v4xUP+h6wSsS9M3Jxzz74HAhPce1VOATKxU97EBVw8Fp3OvnvIZ0LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400674;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GAkR0kxOIXcDYLz4ek1cUwuwcK1YZkKSlz3Tcs1vE5Y=;
	b=QCW/EehHCc9Qo2actzbY8SlNzt0RPN0lBQQHiFhRn8yTTrbKoXTKRGYo55JmtpQgitY3
	 Y7kUGRDTWjjZ104ofK5EmVosK3aBPNJikgDKIBMgOLcqGh3elR1jFGP0A5SZXWlGEs7mx
	 sTtacKt7Gj/s3a1uL0LuyiTz9K09/vAO3sqA+K8bmZ1UdCIWr8yhVRBYHc374dV54yJTy
	 QbpVI14ua/HMESQslzMh+mu8wIUwKiPuFcjV6qIKZMCLfNkoykw/4L4MKZkB/fq8OwiiI
	 tQN/Gtq33HpxQXRUNplz3gC20Q1eWxKNIfsdndUJW+XqR6sSzQ35JWefJ8SQf11ytSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=HNNhkmEu;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE5606A321;
	Wed, 11 Nov 2026 12:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBE5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=HNNhkmEu
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 2674ecea-6cf3-4276-b723-5d0048207e9a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1794400671;
	bh=QAw++WnhVqSoSyxZtr0vJHR5UhwudT33ov1FuSdr6nU=;
	h=From:To:Cc:Subject:Date:From;
	b=HNNhkmEupb2WTdpr+F9fVWyfHu3hVDZjzS3cLen/BhZXMM1gltTNLaOUSnUiH4psp
	 Iwsq44eUSjDa8UDyCDC07RClyhLRN4O/g35cLGSN/oJOGL6VrrRGjRVTfeHZJhs9hF
	 JUiYoVnvyaS+Xud3W12lza7NqoEZWyJx18fuonSCbAoEZR563LaP9LsINATVDlOO6N
	 8aZRsNtxXXlOBePJxNQtbkkNkFx7wahjVIPVeyIQebSqTk1t44R8h+/bLapcsWpzBd
	 +E6XD+PufkY1YOT44mDc4LXL8Dv6rPAk+FK6799Rt68t/Kfsj9/YRHLtc5HyJYrrh4
	 3P+/pZTLzjd2g==
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	lukas@wunner.de,
	yu.c.chen@intel.com,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH] x86/cache: Restore AP cache state while bringing CPUs online on resume
Date: Wed, 11 Nov 2026 13:37:47 +0100
Message-ID: <20261111123747.49446-1-dev@deq.rocks>
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

Some platform firmware, including that of Intel Macs, leaves the APs
with an invalid MTRR state after resume. x86 delays the AP cache
initialization until all APs are online, so an affected AP runs
uncached through its bring-up. On a Core i9 MacBook Pro a resume can
take up to a minute.

Drop the x86 thaw hooks so that cache_ap_online() restores the MTRR and
PAT state of each AP as it comes online, as on CPU hotplug. The APs then
come online right away. Boot keeps the delayed initialization.

Tested on a MacBookAir9,1, MacBookPro15,1 and MacBookPro16,1.

Link: https://lore.kernel.org/all/20180319041843.28218-1-yu.c.chen@intel.com/
Link: https://lore.kernel.org/all/aoCJGj8HixmJ9oaZ@wunner.de/
Suggested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 arch/x86/kernel/smpboot.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index dcbaf3f27..bb3fc9a7c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1251,16 +1251,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	snp_set_wakeup_secondary_cpu();
 }
 
-void arch_thaw_secondary_cpus_begin(void)
-{
-	set_cache_aps_delayed_init(true);
-}
-
-void arch_thaw_secondary_cpus_end(void)
-{
-	cache_aps_init();
-}
-
 /*
  * Early setup to make printk work.
  */

base-commit: c6279551a44c06f4cb1f7b1df2fb8e0d6d6e54cd
