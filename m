Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532209;
	b=cScaKOmyI1r3EUXBWJuvpsij2pYM8bUbDj7k8kvCdtXmQu5TnsJwo+RJMyuH4HKpL2vD
	 TqqzEhSCBbv4FyhfUyDX68XrLP4eu0vjrQNmabPr/MMQWzzq1qb7W0d3k44bYpCMi3Qas
	 /g8Uq0DHUufgWubbdeO0Bji52STc3DJrZO7kuHfMDj2+Mv22CacQ4Yo5O/9vBfQvARuai
	 ulbtpJj7MxavY7sWvMdyCKY0LAw2xl4B7UczhTRZaMIik81ntegwXEX0PzdcHV6CDNB9m
	 44thsYr/mtcYo5o9yOPlLegoufMTjmkYvoh8IkzAWxuFllC2n0EBw/DJjX03jQTIdCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L4IbR2w7U7160WkS4Yv7iABO81bcXNtx1OMFPwxU9YY=;
	b=x6U23DMaP2k7gu+VjWCCfyPmSAm9aIpaoNqqsG/PBpAa04IdRnuAbbOJ50okwpa4Oqix
	 m5ca1nDekC4/mJX9QBTeME+rSuyr0IkjPVwHzZxiurPUVbzXv0+LytnhBGKt2r+s1Z9K5
	 pTUtNUcryzqtEYIawCBSzLP40hON/hFzOIKnLZSmTcl35fv4sTXYBV9WNUkO5pu8X7Im7
	 NIDXUWO7QirskZPwbqJ5S8lG0bKgWfkIeCr61nrwfKqDofaqhypq6thT3UMzNIiC0YT7C
	 ZE2R7nRMjSdV1ZsvTS4pNlFK/aF9QUiZ/0kHGSNKAmX9qYEEXm9tOd97wKtiXsTwfTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBBhasd6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A6606A32C;
	Tue, 24 Nov 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBBhasd6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1590C1F000E0;
	Tue, 24 Nov 2026 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795532209;
	bh=L4IbR2w7U7160WkS4Yv7iABO81bcXNtx1OMFPwxU9YY=;
	h=From:To:Cc:Subject:Date;
	b=LBBhasd6kfXqD8HYRiP2SjDSZDUtRpll/VrYEISj2+9Q4NjCW0GaStJodF92fxUTb
	 HkHlKjXqGrf55Ro0/1ueu3jLp5GmkM8+Xe+X9+WAR/bE58JZDBBApEV3NoULvqegnF
	 pSUly3ot1poEwT9a1gYAjWtXI6ycMxB3jNSbVY+CbpBigfh6QzxEwE0WY2nem6yK/q
	 sZsWADnWiogeGdnO6/aZvbqz9PIiDP53SCQDFtkZEEH4Ashk4rHeF/k5WEl9rIKTtO
	 KjHtm/uGCP0+1jg1xJeyefILBCrdQISu8vBay/FKLCcQEsBPxtq2uMdrx2/Ghcze7R
	 nkt2sxLDa+iuA==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jez Ng <jez@sfcompute.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Juergen Gross <jgross@suse.com>,
	Ingo Molnar <mingo@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: semantic conflict between the pm and tip trees
Date: Tue, 24 Nov 2026 09:56:46 -0500
Message-ID: <20261124145646.3655959-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Hi Mark,

The current pm tree has a semantic conflict with the tip tree that
breaks the x86 build:

  drivers/thermal/intel/intel_hfi.c:407:38: error: too many arguments to function call, expected single argument 'msr', have 2 arguments

437ce3015e51 ("thermal: intel: hfi: Disable HFI on shutdown and kexec")
in the pm tree uses rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val), and
e7f9f17e0013 ("treewide: Convert rdmsrq() from a macro to an inline
function") in the tip tree makes rdmsrq() take only the MSR and return
the value.

The fix for the merge:

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -404,7 +404,7 @@ static bool hfi_disable_if_enabled(void)
 {
 	u64 msr_val;

-	rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	msr_val = rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG);
 	if (!(msr_val & HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT))
 		return false;


-- 
Thanks,
Sasha
