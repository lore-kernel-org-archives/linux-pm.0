Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E94B26E7
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191656; cv=none; b=kakX8TbHZF9A2me0Zvw1Iew5xJzlkjIK5sv8NL8KprKYff4rEM0Vh7y06i0ZPrVJLr/NMucAIpxXAxK/D/psyVxxwqrhv36OD16XKoHwPmekLuCJhDhbgXo3D7cs459lAjI8EEJFBBuBBMET5n2BdAAg15npVFRwsN+KwqwZcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191656; c=relaxed/simple;
	bh=om3QiWY1bTxRKmG/KBVTXUqJ0HDBqwKhfhK+NItOh7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emH0UvKGGS6ariLErZFocr1xv/6UCbHLPxOteDkk4pbrCx32AwoaPMq3BiKgJ5aI/8yevjxj7mz1p3uZrlfo8A7FlbbeXUBrJmVpRd0rgsbaxLHOxfe8FWDgFm9rP9t9GUWvC3D9XRzBfkLSEZpR1wJGR+y88c3rqwg8N18tHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ4I1VKr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ4I1VKr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482e5733a5aso2173363f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191652; x=1788796452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FpSbNGtSqoQ6lDNF7R+qXd/5b5Ix3q2rK7Y9Mk6hanQ=;
        b=XQ4I1VKr9QUsOGESojUAKw/N3A+sq9oiZ4RquSt2X5UerYtr3Hw8B9A02GmFmHBVHs
         ok6n3uVUTnKU2qpHvgAoOsGN94EMKMaBjHZTF/oiuJJrgSdU42dfRHa/beXwKiYz1PaH
         s6S7IEVBxt17g7pYXJ+YDjLju1FIEx2O3IWajTYWQ7L6oY65I0Vz+rND54/fGR3Fs5b6
         3c9E7RlBbMEYOvk8UW8l9m7+vRAh4yEQLYMysGh3vDQwNtiv6c61PcisALdh5iSJJGde
         cz3iDfyi6NqCZ18UWT/r5bkYeTMIPBUkeK1JvbuCZh0dkHePJT1caOdTXrF/wpnNYIht
         J0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191652; x=1788796452;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpSbNGtSqoQ6lDNF7R+qXd/5b5Ix3q2rK7Y9Mk6hanQ=;
        b=ShgKeRd5sRb5TEkGXEc2ulrO6ykSIdjkJx0BU4tMmOgNA7HJBHOb2AWw9EsCd7sirG
         ToMxDGSF4tejxm08c3yy0INeHE7+YsToqjUf5WdcPJPcdzXBXx9HyVRev5D/U9ARlweG
         IOzMgLbJML5CsXOJEuCJwdX//b3MFmBuzKhJWvpsRB1ZGEqVRKWrAD3JlC77dVP1rOeA
         cCl40a8LM1TolOkMqhq8dQrPRn4BPTLs01q+lrd5sPUfvWhG8OAskcbtTINxy6ZFVLGQ
         1BxJVdkGNd+Uc/co3NaadtFWkiTKx3e4DCbLSpri6x9LNq7Ad5IK11mkq87+jy69+HRX
         e2Og==
X-Gm-Message-State: AFuF++n6t5BopsxLldSY3f6kjdsrJd4bzE/Eyg5CbtZjW2hGm0arSLwv
	L09ObdpWtuJQSVa2GczsRxlo+dD38A7HIXgy1kJYLk5Y29FV1AOpKshi
X-Gm-Gg: AYBFou2cJJoR7QPaDzKjzXsX7z/IUlskRDCKJui3jEXcAvNtoqTWdklFJhW2PP5kNjh
	84s+cO8JOhO8DgCh7/9eX54bdZNSZqmC9ZduHY7xG2vOEC908xPUQpJgp9ysGxg48j60yQYMFdP
	rJhCI+hUIXSerJfAbJ7m2zwQhS+ha6oOQ7F4j1EUcCbuNdDyE9qyyJTkjjmVX7x7k0nmwM5y6c3
	248y5LWjyPQWh5tdm2mE560Po+tpHESpS/CyWFvtDDlxP8Gu8L8+bLa0r3WaLWK1yp9sS8Wmpc1
	tTYLt5vAC98b2hJwbulYGJTPtRzjjTejNGIvw4OdSGqsCxZNxTpPIw8b8b5T6q5+PMZ+3Orr5Ck
	wvr3fRS3P3+ziNvK6/K3LodjxR0PIdCsICvbv7ISJDx7MFXZLfy4xr+VHcKbIoVCI6XBl9/eFlY
	xZ7LXmu3bGXK7piRnu6sq7eIqbky2mwK/wxuJlwh6NgERvvG3QuTWW4CGKz4x8S716ky5ftEMn3
	zOi8phb7MWdquPeARTvow0PmvZXopj+AF4=
X-Received: by 2002:a5d:464d:0:b0:484:3310:7110 with SMTP id ffacd0b85a97d-4844103d18cmr2807354f8f.28.1788191652336;
        Mon, 31 Aug 2026 08:54:12 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af3asm12949099f8f.12.2026.08.31.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:54:11 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 1/5] power: return -ENOMEM on OCV table alloc failure
Date: Mon, 31 Aug 2026 12:53:35 -0300
Message-ID: <20260831155339.181487-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831155339.181487-1-ivanrwcm25@gmail.com>
References: <20260831155339.181487-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

power_supply_get_battery_info() maps a failed kcalloc() for the OCV
capacity table to -EINVAL. Return -ENOMEM instead, matching the
resistance-temp-table allocation path in the same function.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 00d8bc98d588..f550f70ca586 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -907,7 +907,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		u32 *propdata __free(kfree) = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
 		if (!propdata) {
 			power_supply_put_battery_info(psy, info);
-			err = -EINVAL;
+			err = -ENOMEM;
 			goto out_put_node;
 		}
 		err = fwnode_property_read_u32_array(fwnode, propname, propdata, proplen);
-- 
2.43.0

