Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6A544D54;
	Tue, 29 Sep 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695109; cv=none; b=i2Q6OE5eJXXbU2qsvDDjUAez2XdXrz/EDYulBRKa1i2TyVyjyWEX2STNdJjPrpeYkMuXl6VotARvrMJ5OZRuIRxxGsGlyvZULL6cLp46q4c5o/GZR38qEt7insCq4UNlLc6Pk1wsQ4rXE2KhaOFY0/AV/GSoJVSq1kNsWItGb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695109; c=relaxed/simple;
	bh=RAUK1pCLVoj7jJQFVNs6VVMK5DAwfBx1QVh/MAhNOsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qyqsnZlJoZNYhgJAKzdoRFpEXk/eva3E4CUQx1l8jWY9R9PQ+hNDXMNJjToBf2SasMUcFd91hbCzuDFMJmNfVwiIHwtRr4jQV6DfbbITpWfX7vWEmKZY7jcVQlKs9ZQrZcfw1U0hdrDvDCIAbvk4/NNUAs3J4N25IWUDK/t/2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wC3kT6q1rtq7gFHAQ--.1867S3;
	Tue, 29 Sep 2026 23:18:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgBX96Gq1rtqGs0kAA--.13860S2;
	Tue, 29 Sep 2026 23:18:02 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	songl@zju.edu.cn
Subject: Re: [PATCH] thermal: intel: int340x: Fix use-after-free in proc_thermal_pci
Date: Tue, 29 Sep 2026 15:15:07 +0000
Message-Id: <20260929151507.23642-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0i6W1QX97vuNvenqQ3QDv-fzStCff3LtyJTXWnheTCRSQ@mail.gmail.com>
References: <20260923072730.487900-1-fanwu01@zju.edu.cn> <CAJZ5v0i6W1QX97vuNvenqQ3QDv-fzStCff3LtyJTXWnheTCRSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBX96Gq1rtqGs0kAA--.13860S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?KLDbHQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnbfYAegEspJ+qccDMUwRutumZ+rtUisQoys6vxdWRvHRj6CvSRL/fwIHGWMgAG3mPXwD
	xCOjex6281u21YU+Mdup9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj9xXoWruryxZr47Jr4DZF18Zry7Jwc_yoW3Awb_WF
	yvqry7Gw1rJF4SyanIkr1SyF4I9FWxuryUJr48Gw1jqryUJr4kurZrAr4Yv34xGw4DtFs3
	Wr13tFWSv3W3CosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbT8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU2EoXUUUUU

Hi Rafael,

thanks for the pointer. I agree with all three High findings.

The v2 I am posting separately closes the remaining issues:

 - it applies the final threshold interrupt mask after work cancellation
   and thermal-zone unregister;
 - it removes the power-floor and workload-hint sysfs control planes
   before disabling their interrupt sources and freeing the IRQs, and
   disables both workload-hint prediction bits; and
 - it routes partial MSI setup failures through the same masked teardown
   path instead of freeing requested IRQs inside setup_msi().

The workload-hint helper is shared with the legacy int340x driver, so
the reordering fixes the same teardown gap there too.

Srinivas, your Acked-by was for v1; a re-ack for v2 would be welcome.

Thanks!
Fan Wu

