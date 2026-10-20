Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517822;
	b=HF05dRsn48X+zU3Ji7GynolqhIko0vI7zf4jVipu4Rhq2BVrPGZlZ72WhIe9dOMbRKyU
	 9j5NnY4LcWDKb0HgQPg/8ISVCbs6aM5PnRvb8Oa/T1f7mIwXG87oBXXqRRvklP/EKl3sm
	 GBZgq8Focqtsfs4tB4a1VVvsaleJtal5sIzF+FNr5np34Xej1GIzS+P0WBrogtR+JTkpK
	 k4x121wOEJspVnTkBeW+ElvwhQ5JeW2W9qizqWSicJ0JiTrJHnIfddG9OtaZYK1KekE4t
	 GXy3Zpb5v0G7oShnCSuamkS9GREtjToq7daFcDetH3kaOfTwSgkVb+h1lpN//NqP65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
	b=iz8tuHoRmiDNs8TPCpuh2StJRJXRzsIygS5FKF7QQ9ezRxeJyiA05bn7l06lWbW3pjiU
	 W6V2XAEVJjFMBd+rHAd2KECCIDyCH69Ot7MRLPKaVl78u7R9synxKNxq7ngKwR8ryT04T
	 xtum9lod+ZLbQ9kZb59V481FL91M0i/ETnBlQkfUvOYuw1lXwuZd+OmMIX9u+BjEHAw5j
	 27RhLClZpfX48yUuiRAH1d3uhGtLmReX1LtoWE7badIZwLBTl+x7w9aJITjGBqyUhtEwp
	 dhUwot6j3XWUMn6XUyioKaV9o3OUOPiUfLCEz3f44nkA865a6b9MEX9thmycN58egRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpAWwkFI;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DA606A327
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 17:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 170DA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpAWwkFI
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so19995885e9.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517820; x=1793122620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=kpAWwkFIF9xwPv2rF4Urtm/z72bnzw5wHjMRnjnWDZxbuO7568i6CG5x73NUlEKKry
         mx4b3vUHZiLTbrlxfQ6kXksr3dCLRwWiSDnIVvShyL42ACssSuvYZH14lS0Xkl0J7Qnu
         2F/5fMrlzhcFCbD/NgUIr8NegG13j3QAdsulLO9FsOLYpA1zmr/2egF6qSuhdCwptWcK
         AUrr74TZmzZMEFYl7CLnyzFVu58owtm8P87VwPcNzJBtHRujGkGcreuzRRtR6lKn4lKq
         awiJaUyI5dNBLJpkJ5gz4iQMyBDgXVeKhMonvHKjh/ZXQYbUUqlfwxsKRIdOIEohtEcl
         igxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517820; x=1793122620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=oEStQBEfSOdudWWRWaCEzQY1dz3T/AEOeTOGoVieoPIpAe/YXkFuU+8hNxKOayS59W
         hM7HWvg3Oar7xTk6fFp7SqJoq8MV37/nH5S4VFvYE7kVUNwqNv0YpxIMZY34KB7f7b2Y
         E0RPfNXekeuDrx6t5o/HuYARv7HF3S4/encLILP1f7F/2SbI36eUACAiv1aUqicqwq3P
         7xE0wbLm4qLwxFrBhW3QQq1BUlsm6TEzAZp/zvd6jFoXUFvHUOlbe5TlLtagoxh4nkmz
         mK28CGtUyrOWoeS4cK3cq3ftHtj9DXsNl2IW2XEZMyoJqdpcxuJM2T2HSQxEZypJCvPD
         diYA==
X-Forwarded-Encrypted: i=1; AKwUvByJ+l0XpL8vbON85ZH1STap3IcqHBHcIn2ghLA0RTZe09BOlW4Dn5n1PQF+UDSFkKdat3nj088yZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKpDk3TETwaYxJ1GydcuOWmpziUE96a13Nj2aOrk5RpaWlxT4tF
	pkKlZ7WYatqnilkti2k0fwtj75YvIun/GZ8VVgTVgglF2FjXtCvdkYqn
X-Gm-Gg: AYBFou1I0Shd/8tpk8TfO8lz6yXlH3qK4prZ4C6FPLsNCNZyIQU7bNYJw3mWuOjac2q
	yrgEoaFDdQryBSVDB9yLMQBL8OzlAALYfgaHtHxni8dUGvhSHKliHwCKgDqP3fO9ZtmGkWqkJCI
	1ObikXANCu5VJ5Uf2eT97682fOJBpzCiPhapUsFUUqn5MbldK/zL8vLgNHwD6D3UECnxxtwz6/Z
	AvqTFEcvC/94rLhszZ21Vaeecls0XhGgGv/EHlikU9qWy98F3umh+MLXPSX09kfje3N/rmsWqXu
	p9tAgP+j3obRnHzCujwQqtLEjcdDRu1gayxMZUE1aWkBBzkxBqoOLF7w8UFd/CJDAC/MEOI2q3j
	NHEjd6A4l7CXuYo4D5CTSLXE/l1cTWLTgkxU5ACh5RRUhQ64pOZxM/b+ekiVZTbLEMrOHiVTREX
	DxZdRnmg3Ff421nBgh9Uqsd+rh1sbfib7MNSLKRKs9oZl5VMN9pFeS8w3TEt7qpUGofBM=
X-Received: by 2002:a05:600c:c87:b0:4a1:fae2:a8ab with SMTP id 5b1f17b1804b1-4a1fae2a902mr22956085e9.3.1792517820215;
        Tue, 20 Oct 2026 10:37:00 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm52505235e9.5.2026.10.20.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:36:59 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH RESEND v10 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Tue, 20 Oct 2026 19:33:23 +0200
Message-ID: <20261020173556.632798-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020173556.632798-1-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
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

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of mtk-pmic-keys for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 140a862ecfbe..ff720588128b 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -31,6 +31,7 @@ properties:
           - mediatek,mt6357-keys
           - mediatek,mt6358-keys
           - mediatek,mt6359-keys
+          - mediatek,mt6392-keys
           - mediatek,mt6397-keys
       - items:
           - enum:
-- 
2.43.0

