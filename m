Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706303;
	b=2OjPuVM8eyZiZAaRaA3wkK+aj+MRn93/3IeoIcPpc13ILroiHPj3dOzlaqtD5+P59mGK
	 rJvgLrUO2fVGGPLRAs57kmd8BHSbFWx1rD1sL6AklUuhGXl8Nc6jw7+ovhpGxMl7mmDC6
	 WNLhuAln+qm0oL4Mq7uc9XTtpuhQbCcvzDvvW3K2pp1RJwyda0J7t62bjfTuuOYR8gD8Z
	 hCMiKTMpgtz7i3h1icRjGogciB0wMF31OjxE/GCxAuJLxMx1KAMn7QvhDasc7gOoZODTt
	 Wpe9yv73GRIk24651b/Ll8fr/lZW8f9Hv+1t91LGIOwjVse3HfJzUTodE/VR2OaNh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706303;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=wPT08thmwzscXCqobTlnpl0ujnuiyp9w2Kh7Oa5VAsw=;
	b=2Bu29Z8zcCiuNpnpzUxvTSoE+VT5ZOVLjHYWVQdTSEz9IqPv2s4aVMWG8LoNgnXISQLc
	 UxyecAueo0KOAutCD/Wuv0fq+Te1pxtrf0FlzySQABAQo4VNmvXOn2tENtaAkHSgDz4NW
	 yMj12xFr3aIqEOs9DJClHcqi+AshLU4ic0pJ5s96x9ndG3xTOPN1e4/qy1lwUI0f/wZWF
	 /IY3ADTsluVlHTXOXZBeQfYqOYkx5J4HbUXRAqyRnT6bIfwD+LdLMqU9WIG7KaxREbAku
	 Rfuh5HTj54NcxSq6KapLNpc3La/n44lVqMBOZeFKDSjU7DEaqK21RRYBAeZXqJEszBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=JECCWLns;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFF606D818;
	Tue,  3 Nov 2026 11:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BAFF606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=JECCWLns
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1793706072;
	bh=wPT08thmwzscXCqobTlnpl0ujnuiyp9w2Kh7Oa5VAsw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=JECCWLns0c85GYQygxijd4Kb4hJDMC1gFpBfhTt26QAcI2ycdhwEGAB8JcUR3mEYM
	 8kFT5yF+2l9g2M5PxqzmdOEmd/0odC3xrA33E1T0Iidh5kLq7yIMTxgRv/AXX1Seq+
	 Q8kVZ6JBHpLwIRj+FmamsAkpGKAzU6GK8eG8hgzY=
X-QQ-mid: zesmtpip4t1793706071t7df616d2
X-QQ-Originating-IP: YQ06AG7Nz8u6dMNsigInxc0UsGo452kvNDmllCue7T4=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Nov 2026 19:41:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8851204744377218603
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Matthew Garrett <mjg@redhat.com>,
	Dave Jones <davej@redhat.com>,
	Thomas Renninger <trenn@suse.de>,
	Naga Chumbalkar <nagananda.chumbalkar@hp.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: pcc-cpufreq: validate the ACPI interface data
Date: Tue,  3 Nov 2026 19:41:09 +0800
Message-Id: <20261103114109.74400-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NvH2zBBgt3uTycSlvtz0OSpS0J1yrNy4NkzAzgdvAS45glXupgZ/stlj
	gbOkZQYanHJ8+Az1OtANh74l7XnUdCwxZUknCVeI9ReUgHhw+/HUaWuB0wNzro5qrIk59ad
	rqqpQmstLW9KGAn1ZsBlOCadhK2AVOcwVMojkFsrf2VTJpQy8ZfDhCp9pT0Cw6P5XTV55Ww
	nI/bs7cazM/BuhzivzTVu4fJICQ1+f8mpZqgMw2uDeZRqs0cdqNKgAUeexb4is9PRlBpD2P
	KM27SQq8m5Pjoa/Ya/OVC1KGkxB8nMq7II24WFshlbAmjd/5KhLLGmHqpKL8WSBF1izoI34
	VHmht6Fz/oJkc9yB6H+Sj7pjpi2Xybb1e41GdQKdEXEzB1JuZRFISIADibXZUCHPdIkYS9n
	qbvy0GG3zelRfOm9uk/PTQuP9XbebG+q1pTJglTOocjtkorYeIv+ZP0WPl+8qxsLo+jNYPF
	w+88VJ/fWLRvq/qSOsIMrpwg/uS2gNde+n3F3sLPQiIf1j3LpP3+d9cjfMLC0k1sG7jsdW0
	r+iBbGXwX8wU0c5mCBNyFNtbbI4xkPjxvsv8lOJwv24eL+ngcZKMKN2NjW0C08XOb3HZF1B
	3vIhgVHWkr67udu3qia+El/Ph4CT3oBVjXKGKZB+OWjCF9yX6XoINaXUkfCSdVXQ685hfIi
	9CwUqwvzM1UMGtiCcRVmdJrH84K57rgUSQJxfJWd15wfRXZ/RadsLlninYRbldmJMQjQ9Xz
	zp98yIyvf6YyyRYTbcd+C62DDaAUVY5o2sBNiBfUm3pmS9O3aNaQLBRgax0Aotanhn2wZJI
	5sxbuTs1uCRD08Qr4UmJshxRPm7PWjEozGWUu2azndfvZzON3FlOkfMmHwKgmJmeKw6uZQ7
	Ydl6KUnLK6qv1z+RRG5PwlXAtjVoQgNKYltmoD0d/HJnG6eSr1mJIarF+/zV3sreN65EnM2
	1V5VE3+4EyYiE9LYK7MB5ZJbHS5T89DyaQNzI1PYDRQlZD1RLpue2ghYoyXejBHq/Hx+hoh
	FsS1bZYjlOAbIhbDSB/hva/xKTarC4wXHHeXbJStOh/M54s/VB
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

pcc_get_offset() reads elements[0] and elements[1] from the PCCP
package without checking that the package has two elements.  A
zero-length package dereferences elements[0] out of bounds, and a
one-element package reads elements[1] out of bounds.

It also uses the returned 64-bit values as byte offsets into the
ioremap()ed PCCH region after truncating them to u32, without checking
the mapping size.  A firmware-provided PCCP method can therefore make
the driver clear or program an address outside the mapping.

The PCCH and _OSC replies have the same problem: pcc_cpufreq_evaluate()
reads elements[0..3] of the PCCH package and casts its two buffer
elements without checking the package count or the buffer lengths, and
pcc_cpufreq_do_osc() reads two u32 values from an _OSC buffer without
checking that it is at least eight bytes long.  A short or malformed
reply makes the driver read past the ACPI allocation.

Require a two-element PCCP package, keep the offsets in u64 while
validating them against the mapping size, and only then store the u32
values.  Also validate the PCCH package count, the two resource buffer
lengths, the minimum PCCH mapping size, and the _OSC buffer length.

Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driver")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/cpufreq/pcc-cpufreq.c | 45 ++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 83e6f73dc9a4..c7c65104fc09 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -92,6 +92,7 @@ struct pcc_header {
 
 static void __iomem *pcch_virt_addr;
 static struct pcc_header __iomem *pcch_hdr;
+static u64 pcch_size;
 
 static DEFINE_SPINLOCK(pcc_lock);
 
@@ -136,6 +137,7 @@ static inline void pcc_clear_mapping(void)
 	if (pcch_virt_addr)
 		iounmap(pcch_virt_addr);
 	pcch_virt_addr = NULL;
+	pcch_size = 0;
 }
 
 static unsigned int pcc_get_freq(unsigned int cpu)
@@ -253,6 +255,7 @@ static int pcc_get_offset(int cpu)
 	union acpi_object *pccp, *offset;
 	struct pcc_cpu *pcc_cpu_data;
 	struct acpi_processor *pr;
+	u64 input_offset, output_offset;
 	int ret = 0;
 
 	pr = per_cpu(processors, cpu);
@@ -266,7 +269,8 @@ static int pcc_get_offset(int cpu)
 		return -ENODEV;
 
 	pccp = buffer.pointer;
-	if (!pccp || pccp->type != ACPI_TYPE_PACKAGE) {
+	if (!pccp || pccp->type != ACPI_TYPE_PACKAGE ||
+	    pccp->package.count < 2) {
 		ret = -ENODEV;
 		goto out_free;
 	}
@@ -277,7 +281,7 @@ static int pcc_get_offset(int cpu)
 		goto out_free;
 	}
 
-	pcc_cpu_data->input_offset = offset->integer.value;
+	input_offset = offset->integer.value;
 
 	offset = &(pccp->package.elements[1]);
 	if (!offset || offset->type != ACPI_TYPE_INTEGER) {
@@ -285,7 +289,21 @@ static int pcc_get_offset(int cpu)
 		goto out_free;
 	}
 
-	pcc_cpu_data->output_offset = offset->integer.value;
+	output_offset = offset->integer.value;
+
+	/*
+	 * The offsets are used as byte displacements into the PCCH mapping.
+	 * Check them against its size before truncating them to u32.
+	 */
+	if (input_offset > U32_MAX || output_offset > U32_MAX ||
+	    input_offset + BUF_SZ > pcch_size ||
+	    output_offset + BUF_SZ > pcch_size) {
+		ret = -ENODEV;
+		goto out_free;
+	}
+
+	pcc_cpu_data->input_offset = input_offset;
+	pcc_cpu_data->output_offset = output_offset;
 
 	memset_io((pcch_virt_addr + pcc_cpu_data->input_offset), 0, BUF_SZ);
 	memset_io((pcch_virt_addr + pcc_cpu_data->output_offset), 0, BUF_SZ);
@@ -334,7 +352,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
 		return -ENODEV;
 
 	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER) {
+	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER ||
+	    out_obj->buffer.length < 2 * sizeof(u32)) {
 		ret = -ENODEV;
 		goto out_free;
 	}
@@ -365,7 +384,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
 		return -ENODEV;
 
 	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_BUFFER) {
+	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER ||
+	    out_obj->buffer.length < 2 * sizeof(u32)) {
 		ret = -ENODEV;
 		goto out_free;
 	}
@@ -418,13 +438,15 @@ static int __init pcc_cpufreq_evaluate(void)
 		return -ENODEV;
 
 	out_obj = output.pointer;
-	if (out_obj->type != ACPI_TYPE_PACKAGE) {
+	if (!out_obj || out_obj->type != ACPI_TYPE_PACKAGE ||
+	    out_obj->package.count < 4) {
 		ret = -ENODEV;
 		goto out_free;
 	}
 
 	member = &out_obj->package.elements[0];
-	if (member->type != ACPI_TYPE_BUFFER) {
+	if (member->type != ACPI_TYPE_BUFFER ||
+	    member->buffer.length < sizeof(struct pcc_memory_resource)) {
 		ret = -ENODEV;
 		goto out_free;
 	}
@@ -448,6 +470,11 @@ static int __init pcc_cpufreq_evaluate(void)
 		goto out_free;
 	}
 
+	if (mem_resource->address_length < sizeof(struct pcc_header)) {
+		ret = -ENODEV;
+		goto out_free;
+	}
+
 	pcch_virt_addr = ioremap(mem_resource->minimum,
 					mem_resource->address_length);
 	if (pcch_virt_addr == NULL) {
@@ -455,6 +482,7 @@ static int __init pcc_cpufreq_evaluate(void)
 		ret = -ENOMEM;
 		goto out_free;
 	}
+	pcch_size = mem_resource->address_length;
 	pcch_hdr = pcch_virt_addr;
 
 	pr_debug("probe: PCCH header (virtual) addr: 0x%p\n", pcch_hdr);
@@ -480,7 +508,8 @@ static int __init pcc_cpufreq_evaluate(void)
 		ioread32(&pcch_hdr->minimum_frequency));
 
 	member = &out_obj->package.elements[1];
-	if (member->type != ACPI_TYPE_BUFFER) {
+	if (member->type != ACPI_TYPE_BUFFER ||
+	    member->buffer.length < sizeof(struct pcc_register_resource)) {
 		ret = -ENODEV;
 		goto pcch_free;
 	}
-- 
2.34.1

