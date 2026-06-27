Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070E31D371;
	Sat, 27 Jun 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578378; cv=none; b=gbbASzq1g9avoQ65mHDO1QUezM0+88efbtiZWcl9+Y5mnr9+rSI0IbAXB6+j7yraDe9qhXIR3SbYTsmSq75krJfqB7zhrhdtSp7fcMvwFLF7tmdcKJjKamYmiaXpRUfkZq7Fa0KGm/JYHFRbC+A6RN5XF44MarqULNxZr2hdr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578378; c=relaxed/simple;
	bh=1cpjwuqX4AI0+mZn4uzmSmj8Y/XUMlU10pu35e63QH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPwojfp8zcGVelQqI47hlpn7XFCVE6OKX0koyIQl8cZzjxpFai49w2CaDW3sjheObZMKbTMxd5dVtCuBsys6I/1MEN0+dxui8V/Js6vl0gE5C/kEf1KcR92LJOt5jitIJDZgUeA9T4cdObjSMs1pUl0WAIjZUsAqJI6cex44DvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ29Mh3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ29Mh3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3503A1F000E9;
	Sat, 27 Jun 2026 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578360;
	bh=pVrtp0+OjLGteT3DW93alrv/5D/KFUVlB/nwln/Xxic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MQ29Mh3YYIhn+fwEdG49NMRm8ZUBKIx7RFcrRvGcPFW0SQdN7xTch6NQzDirpefNd
	 wssMXjaFL3N2OFCrZe/e0z79mj9fgrXU7+IOHExp/hBdFHsgJDT+pXGzTfanGEczen
	 aMHmPevDnO+DABNTL5P5nLIGYXrPxHvATETD3yAA+ZYSBKl22iJvLZwa/XhKkbUqvg
	 Urfz1gHyoHKNXtycG8ISShSIvx3UrVW+8wSPQnXacn2mgymFE8etj69WzgtvzWSjed
	 rt8Y3agQ/7Rcbs7WgW45AjDMMAwvxFdr+acgsO/hlIXa2FhA/JIn3iJfQEDrGYqAbX
	 HhCuxYAJsGJxw==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Sat, 27 Jun 2026 17:37:32 +0100
Subject: [PATCH 4/6] devfreq: hisi_uncore: Preserve PCC shared memory
 signature
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-acpi_pcc_signature-v1-4-c1b7268d4fdc@kernel.org>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
In-Reply-To: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Huisong Li <lihuisong@huawei.com>, 
 linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2

ACPI specification defines the generic PCC shared memory signature as
the PCC base signature ORed with the subspace ID.

ACPI 6.6 added clarification that the signature is populated by the
platform and verified by OSPM.

The PCC mailbox controller now validates the signature when the channel
is requested. Stop copying a complete local PCC header into shared
memory and write only the command, status and payload fields, leaving
the platform-populated signature intact.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Huisong Li <lihuisong@huawei.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/devfreq/hisi_uncore_freq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
index 4d00d813c8ac..7976eb359061 100644
--- a/drivers/devfreq/hisi_uncore_freq.c
+++ b/drivers/devfreq/hisi_uncore_freq.c
@@ -187,7 +187,6 @@ static int hisi_uncore_cmd_send(struct hisi_uncore_freq *uncore,
 				u8 cmd, u32 *data)
 {
 	struct hisi_uncore_pcc_shmem __iomem *addr;
-	struct hisi_uncore_pcc_shmem shmem;
 	struct pcc_mbox_chan *pchan;
 	unsigned int mrtt;
 	s64 time_delta;
@@ -210,13 +209,13 @@ static int hisi_uncore_cmd_send(struct hisi_uncore_freq *uncore,
 	if (mrtt > time_delta)
 		udelay(mrtt - time_delta);
 
-	/* Copy data */
-	shmem.head = (struct acpi_pcct_shared_memory) {
-		.signature = PCC_SIGNATURE | uncore->chan_id,
-		.command = cmd,
-	};
-	shmem.pcc_data.data = *data;
-	memcpy_toio(addr, &shmem, sizeof(shmem));
+	/*
+	 * Copy command and data, leaving the platform-populated signature
+	 * intact.
+	 */
+	iowrite16(cmd, &addr->head.command);
+	iowrite16(0, &addr->head.status);
+	iowrite32(*data, &addr->pcc_data.data);
 
 	/* Ring doorbell */
 	rc = mbox_send_message(pchan->mchan, &cmd);

-- 
2.43.0

