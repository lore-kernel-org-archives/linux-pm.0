Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C65012B1
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784636; cv=none; b=Ft4gf4sqsDo7rCqEszHDqrznLS1eQp2wBlPp29hY4j5pW5m53z/EAesZaE6MtfK39im8is9KXhRDdbHc5Lg6zMhv/JMuu7VZ33yVFzGw9yJYA1iiB7Hd2zBROHfsaEpi+qUUhpc1RR7h39qvZeFe7Ts4dOQIWXVtwVfI2n8I7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784636; c=relaxed/simple;
	bh=iZMpbAvuQm4kiaSjpijC/w3mG6fmevsG4tbgUmTW3Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R32yB4R/9BPQ6X7dbtLoBDNyxvXrgPieR6YZg+lQsXRWai+ixoY/YQQKTWh9GoqAXp+7H5qMckixxEjFkVaUOGYyh1YUrbqoBceB8H6g3l3wcueSK88bi7fsPhoqAB421vrtZ+ntaOjZFabVl4fmw+DKvgXpQc47V46CTupdLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=jHW883He; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="jHW883He"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so599945f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790784629; x=1791389429; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NGH+RfodRBv9yx6ICU4d+xVetnRppkeE15j3XlEUyz4=;
        b=jHW883He/aYjKuTPaDYwKqoIRHitas5T3tzkLnyyx1u8Ow0s6DfUXYpfWRXP2BHYdA
         OrKi0aSRX8Yo3Vh8qzLOilgBQJiUZVAvj36pSDT9YMAyZhq9hAGoZsVOi3f3vnqCETSn
         bTWucu9S82VbAQroxoLBdjg8yOXpdCksU2kojOlCyYlAo81dYA/6Dk++Sof8NJl1/wl+
         TsWlA5XSXLhGBXV1tg9mudc19t5MN7L2CAPksI2CIt7zDEh5AcRxJJxm/dUldqzg+GOB
         dQPxXft9USm+zUbcVLjUIag5RGjUYtTrKFKcsS1gHkfytzKBE4lr7kpgfXNGGGBMUlwA
         UrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784629; x=1791389429;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NGH+RfodRBv9yx6ICU4d+xVetnRppkeE15j3XlEUyz4=;
        b=Sww8CQMW81sv/VdrTDz8o1+tUkvq1gmy/3W6ZekU/UeLk1f8s+upNgFzXaZ64OscLp
         SADHk+r57d/chCzafJUFZBkNsb1aUbYXLdKmUu2BT0FMxmPyhv9nrm+8F5bEY/8Kk5nH
         olbm922oFDyrWZt+6DpO3chZuGDwQUrmEA8zFYul3RBdWGmBPYtpnQumyoEIFHjgz7dN
         meG6t/0TIj00EtRPHeZjkYRlP4MjIYP4qUFB1Dbr7/4sje4gNjzxWqosh3Kw0gpZW2Jx
         uTDmH7AzjD8FvfLVNMAImCHMbTKnHNipEL5jsogR8gFlMoHuFGWpGPs2nUPhgmrTIlyW
         ZCPg==
X-Forwarded-Encrypted: i=1; AKwUvByUOOURN5vK037Lxjzeu3EAQj0TjR81illPx5KKAFG8jP5Bg+fjdwZznvo+5RVZQNSh61/Sq9BZYQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ns+JgtymL/EvRZyDdc5ZG4UR3H58c1FrG14nayqSxkqgDjKrIj
	qikaWPmVzY48L2plOhSMWTkxm6etgWBa1B3zMBEPaifx3/ydSGzvtruwY6OGyzrl7wY=
X-Gm-Gg: AYBFou3P1CIeb/hdKol5pmU7qy+aOqB3umyryNcCDgZkCQJ9Ql8RA/UqxQzkgheY9ij
	b7kEkAV1kh9cLdA9Co/M8TQILAWePYhFNlaXR1eMioBw/a87Krw/E8pLDsLro7E2j+2CHUpUC0J
	2UrvF2Swr1sHe2tbPPhs10SyVLKmOrZBNFAXxPozRHGm68cRh/PP7n9apjgSbZSBh2d4CmDFCCC
	88A65AHIJS9HyjbeImsWs+UEVw0C38/SCqOO9oUwjnM7UjwckUYPeb/RYxiWPHpIorTE5uvhjQ9
	fHpCC3oPUHrhN2aMUVLUAYh+CG1Kj6zsCNMhsmO1PIW9puXXKDK1/Au/3Wb3KWvg07gTXcZABDD
	O8SaJrx3Oumrgw9y2Ju1Y1j1HFfXvsR1UAxxLG8E8KtvUwfYOWkBGi+BY5I9jPXSbjE/eWCekNg
	I9BsDP650Pkigm4ppFDxVZPLtlnmayZPVNPoxz0HtHI4CXOIFyt3OdU/UDT1lLQZcbvTRvw0SdB
	Al/pVkAUWZBZScT
X-Received: by 2002:a05:600c:b96:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a01eb03db2mr2531975e9.8.1790784629228;
        Wed, 30 Sep 2026 09:10:29 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01ccfeb2csm8578785e9.1.2026.09.30.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:10:28 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 20:10:21 +0400
Subject: [PATCH] power: sequencing: pcie-m2: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CMAxF0a1UHmMpJFL5bAUxaMILGEQIdvlIV
 fdOgOEZ3DuRQQVG224ixVNMbqVhuegonYZyBMuhmbzzvdsEx1fP9aWGO1+yArxaxxRTiH12nlp
 VFVnev+Nu/7c94hlp/G5onj/Po62mcwAAAA==
X-Change-ID: 20260930-m2-pwrseq-kfree-78bcbc3b6f02
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=alchark@flipper.net;
 h=from:subject:message-id; bh=iZMpbAvuQm4kiaSjpijC/w3mG6fmevsG4tbgUmTW3Bc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtNSlqmC63gKM342H5FBf1K5b9/14q/L30SmvPV5mLx
 +peLtwa1DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUW6Yx/OGbvfh7wv3ErCPSh5aznk61dOVxXpyvGOo1wbYgaCZz1xtGhvbSqfX
 HP5bEWFvJiB0W/+LM36DpptTqEXgkz0s30m0rDwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
pwrseq-pcie-m2.c never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 52e7b5bd62ba ("power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Split out from [1] for easier application per Mark's feedback

[1] https://lore.kernel.org/all/20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net/
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 91916768e922..0febe4b3d980 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -613,6 +613,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 err_free_regulators:
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 
 	return ret;
 }
@@ -626,6 +627,7 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260930-m2-pwrseq-kfree-78bcbc3b6f02

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

