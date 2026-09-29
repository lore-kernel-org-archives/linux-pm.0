Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0AE3CF698
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676374; cv=none; b=m8DJ6AgqtAKEoo2dEkSNngVF3WnHajLBhTKa84cpacumv6Ir7IkFhT+Vqm4PCFEJtyMwGbOll33N6vdneZ0bQQIggIsU82/a4v0qvBHiLTkaR5WbLvPya2CrcGS3nUNFL3IneaRVRm9wbjmrw0L8Kng3UhVmADZx0AjHObpVftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676374; c=relaxed/simple;
	bh=vuq+i0+bCMQ9/9d/xtbVztfdytZENeiCb9lc3buC0uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbhT/kPZwemdZvdaPdDgP9leVnUK3mww7diW5J1j3pYMOOPgauJ3nEqgpFqbHlJ8HQuNGbXv9TgPRk/wwOe6jNO70P0P9opoLYaVT0os0qzwnyaWapJF7JTp0XLysqAMD4Gz7mAvMLBHKL37K92Gfx86iwxq7bGks/Zqn1nDA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=DmJaxyNX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="DmJaxyNX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so32349895e9.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790676360; x=1791281160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phJsUqb9NaFMguRfrpAljTIHGvzpGMajrsq7kQa1w8o=;
        b=DmJaxyNXl0kSXFQW3MwMi0x/90mN6eC20joPOGB8Rv3OpNNPjJt5iJPJQng0/rrVJX
         bTGY1iArxC56NMPOxL1lsGslMylSHlWKtizF1ootQkPUaUujAsLig9Un0jFT9H/vkmsF
         53C728alOmkUf7CJBAFXA9Gx55JbMnRLdwo+BHmJJKdNjGHVcIwP2v6BbK+Od8LmMwEm
         5bviykArwBbMGY0LJQB/vE8soVsLyZ7+QTFpkT3E+yStXPic2DNvTacRaChWQSAXXjrq
         zOXaVBZfxI7omJ6auc7ISCD45jS/mQBIEVW+1NwdR60kjq37XixmA/apv3XnoQXH5/cw
         qnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676360; x=1791281160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phJsUqb9NaFMguRfrpAljTIHGvzpGMajrsq7kQa1w8o=;
        b=sgGlU/coqsi+TdCOSZqm56PTlzL5nOCzFJjA9GB0c1HL7r2D3juDLhS51biJ0tC8hC
         rCgQ/9V/ZD+99HzGkMCEEvxsIZjR+4XlxI/hv+ZlFQ5xOENcJT4MPYCGc/X7gAPkXKSt
         q4q0QBX9/89h6ZcUaB09B2dttiPaPX0VFgTkX7e5ye755UH8J+xCizPzFOnXpGDmG/zJ
         Z8CdYLXw0TvZLqR6hOL3dQk2+lJuj64xXLF20HrzXcakhsmqLie/TKw4A41bDWMA00GG
         PG/Od5PUgfOShU2rIsBc6/gypxrJqTKz9WyTW/Q3iv9qI9yy1DlQpmwyYfoHTrsmynGv
         5JjA==
X-Forwarded-Encrypted: i=1; AKwUvBwwSm6QdnP6g8WYdaenaM7cM5H1gLk3wEOyonKajLSj0l4I/4qnJjg3IQ0q0jX07B/C5RCs2DHrag==@vger.kernel.org
X-Gm-Message-State: AFuF++m9m6QKKnuSzN7uB4maHu4/O+KONd5+0b97xlHx0qz4OfKX83xn
	L+8lbLfRC7OAvZ3skywibStt6b5CrRXneMSwCtyJdvNzeIwKRUHpa2BXkEO3W7O/a7Nog86iwvf
	TVQQT
X-Gm-Gg: AYBFou0NRJWaCVPj+QXzrgASX46k8RHuLUQ+eJJZcT6HqM/S/wKJiBFczxPWEyaEU9R
	Hp2xMZtPA4jx5cyi40/UGmcylzi77fh9pXCc7kMYBBupHSgn5fZ4V+s6zC3AfLM29szKkNm3KoC
	bpj2yzE6pTqhIsMVia/PqhAiHF6M14aXKx3Pw2fHKZgmYLPcG7QePVHr8dYjFRLTeTsrWtYrk0b
	zjTCK9cdGfWzgesYC/LhXMYp+nsimOTkdbhk8WPHN+nOjDQOXlsrJZ5xLoPcN1vN9ZIoAqguQ+k
	RIXwe1UmqINvRN+pxfy0Y044/R6UlbJk1dnMOQLM6SafMTxAovObnN7I/H0yNWQ0MieGlMjjI+S
	gvY+HXv/uo+HhcEbY5/GKHn+lR8EG9ZrlkLsQi2VxQgL4m7rdKV1G/wblwq1+Z14TYmTi41jkJa
	XbhmnGY5Ue/gpwMufwaygZLpfMi7B92q74m3viM4oLXXWVIYlKcKVg2DOKaEK7o8Y8Tolv5rjl6
	m6Lm/HlRtoTSTGRPlmnEwYN1w4=
X-Received: by 2002:a05:600c:4592:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-49fed8c6cccmr258300315e9.19.1790676359994;
        Tue, 29 Sep 2026 03:05:59 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2954995f8f.6.2026.09.29.03.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:05:59 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:05:46 +0400
Subject: [PATCH 1/4] regulator: of: fill in supply names in
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-regulator-get-all-v1-1-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
In-Reply-To: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Corentin Labbe <clabbe@baylibre.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=alchark@flipper.net;
 h=from:subject:message-id; bh=vuq+i0+bCMQ9/9d/xtbVztfdytZENeiCb9lc3buC0uc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTt7m35+qM7b/X2jd5XvXacmmW2oT1uls1fsQv7tBVbS
 8wvW2rKdkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVs50YfjE/mTJ/yhk+2R1bzPNF+T/s5LHd9c9E7eFumzCuDTyPHi1mZLg5P1Y
 6MPhi55H+vL3e1zf6BwduLw09l6tb5S6ptjDKiAcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() returns an array it allocated itself, and
fills in only the consumer of each entry. Every other way of getting a
bulk array has the supply name set, because the caller provides it, and
the core expects it to be there: regulator_bulk_enable() prints it when
a supply fails to enable, so a caller that hands such an array to it
dereferences uninitialised memory on that path.

Copy each name into the array's own allocation, right behind the
entries, so that it shares the array's lifetime and callers still have
nothing extra to free. That also retires the fixed 64 byte stack buffer
the names were assembled in, which is_supply_name() never bounded the
copy against.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net?part=3
Fixes: 27b9ecc7a9ba ("regulator: Add of_regulator_bulk_get_all")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/of_regulator.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index c0cc6cc0afd8..785b7a11dfc6 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -935,15 +935,15 @@ static int is_supply_name(const char *name)
 int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			      struct regulator_bulk_data **consumers)
 {
-	int num_consumers = 0;
+	int num_consumers = 0, names_len = 0;
 	struct regulator *tmp;
 	struct regulator_bulk_data *_consumers = NULL;
 	struct property *prop;
+	char *names;
 	int i, n = 0, ret;
-	char name[64];
 
 	/*
-	 * first pass: get numbers of xxx-supply
+	 * first pass: get numbers of xxx-supply and the room their names take
 	 * second pass: fill consumers
 	 */
 restart:
@@ -953,16 +953,19 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 			continue;
 		if (!_consumers) {
 			num_consumers++;
+			names_len += i + 1;
 			continue;
 		} else {
-			memcpy(name, prop->name, i);
-			name[i] = '\0';
-			tmp = regulator_get(dev, name);
+			memcpy(names, prop->name, i);
+			names[i] = '\0';
+			tmp = regulator_get(dev, names);
 			if (IS_ERR(tmp)) {
 				ret = PTR_ERR(tmp);
 				goto error;
 			}
+			_consumers[n].supply = names;
 			_consumers[n].consumer = tmp;
+			names += i + 1;
 			n++;
 			continue;
 		}
@@ -973,9 +976,16 @@ int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
 	}
 	if (num_consumers == 0)
 		return 0;
-	_consumers = kmalloc_objs(struct regulator_bulk_data, num_consumers);
+	/*
+	 * The supply names are kept in the same allocation as the array, so
+	 * that they share its lifetime and the caller has nothing extra to
+	 * free.
+	 */
+	_consumers = kzalloc(size_add(size_mul(num_consumers, sizeof(*_consumers)),
+				      names_len), GFP_KERNEL);
 	if (!_consumers)
 		return -ENOMEM;
+	names = (char *)(_consumers + num_consumers);
 	goto restart;
 
 error:

-- 
2.55.0

