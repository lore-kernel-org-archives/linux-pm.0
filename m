Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217318;
	b=IuahTajNa99Qj65WMkcRnyFtqKvRk7+y+wnzZq+dgk3AnrWWrNoFMd4O9k3VoY5XjoJc
	 yrbgKVhWn/CfvSTftM0lQjCw3F+mPewdXKc8iicFAYEU/oHbOpBW+r1sYKR2Pp8omj07C
	 l2swg6C+d00kKY2uZ5RWlkOVVbVh53eiaGxroU+r42tQhZp+kyklTk1efDOLizFBH7TiW
	 aKvddpW0JLSzTGQ1zcHPrN8VMHWX7u5JaoATu/LYsw7jrzrwnBwVWrxOPElfdhpjbf9Ek
	 QBDQyBO6zYVed7M20v4V4fIRDCuxT+tmJX9aDxhEUM0tGakTptW08uxUAgzGP/Lb/Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=r93XzVB3Mw5/o9AS2aRrBAkJ8mfk7Pdmi+7Ik3SQfyM=;
	b=4XK2RqzWl+33dH2XbNTB9MEas/IPS0+FXygIPTfV27C3Yl+lHDL0aKJ4AU5PuJQ92SRd
	 xh3jratHso1Xg8DRt+UFfVojD5filySKyhLo2giqsFVynyPmVdt/U0BMEiexNPjN+nolb
	 W1BwsKTpX8pnGW6SeHc6u46DzGW5y2ts14Ksyy/v8gzV6qlkO5kH54CHXkwu+9ojN2Ghd
	 lmXYcxWxgoDQphoSks7uvJQfFPOYufUHLcGmYhyQnJEjk8drI+OsB/ESeVzFZpScOEssi
	 lHZoXRGclsU86uW4xvw0wqrF1cRDMek0LtJnplGi6NMVTMFeyyjS9n6b6ztM+fj2a8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=cD7VHbjy;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08DB606D802
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 09:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08DB606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=cD7VHbjy
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e47347279so392707f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 01:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794217316; x=1794822116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r93XzVB3Mw5/o9AS2aRrBAkJ8mfk7Pdmi+7Ik3SQfyM=;
        b=cD7VHbjytBeJwEopqcJf5o5WnJl1cuopzqLaPLHwX6UnqEzoAgozVPUH1ybMFXsLR3
         JlieyB6dDtKzefMui5xiHDk7hiz6zcSZqve8nSNFhTu7ENyul9ThsWQbWyC3vSn/sFsl
         GMAZSh7Gd0umBYIjbHCmUFkprpKQfOik9SMwvCYAR1jLJIclfj5RgeWyOs7kT38TpVto
         +0P5Fkd8BB9zwIKyG5PTImPlFlaL2kafuxRN7v6lYc4gB5rz2+kYYveZ3oi2kgH5jqxx
         bMD8qTrQIzUmBNcm2GtWW1bVBnOWhorXS5WiDIMgbhm/fgVlCQxRKOntq3hJQaeJm9zK
         ImSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217316; x=1794822116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r93XzVB3Mw5/o9AS2aRrBAkJ8mfk7Pdmi+7Ik3SQfyM=;
        b=Ph2j38RDsPxq8KQTl9W/ROYQoWWR9c8079jslvBJm2BqIINbrvyT9YV66Uz3TcTgeA
         H7xkFp9x/dOnPmLZjukzL2zzOhf8DDuNSJPyu+c7MDYci+2dB5Kyfna+K6lRQfRpvW7U
         xTYoZUc73/j65ZJqGqjSzPIS675N7pr1E5Md17cNaFcvtVBIqE6sZimZtSbgpkopO4GV
         4z5GPbp9Zj09qe9hM6YI5mndA9VjIrGq+l6SZjyNuynW8zWD/9NPaqnLxbBDtBLNQI8D
         HcC/ZltMOeGia98Ed3motPEUnikAVisMIMta5pHmZMj9TO/lhtY3AykTUqJTanS9HpOt
         +Nrg==
X-Gm-Message-State: APuU4Z/TSICm4Xh3eIrTKLv/wSm99bGl2a3R95KYLoTKyMCNLbnejt+V
	yKpq1NgzWg0/EMGmfEH/aLseNnnLL39nN/zHrka1pnZtFTXE8bPn6ZlQJQEDhJEFx7s=
X-Gm-Gg: AYBFou04rof2Zfi2oZJMZdd0w/MpVrsUKOSN5PDD2qk6O1OMDLDay841zMwuMB3XDN9
	eGmTXZgRXqg5NeojTOixFfk3MihVjY85ITeaWyHRXorM6O5fEDBFyaF8F2i6L+EQ/mubsbM1GLb
	LClVLV+3/fnIB5YKLUaRQplz5Yv4q3kx/VxzVsOmImq/elVe0YMTkZuQkk13gnnTnuVHA5UGw6Q
	VmdnHVhfqmNSqDtkm+WWzkmgPr4cnITMFzCucw4RsKe2VfQSHVB2sh0LnRK4J9SbVxfaNXoVLHY
	2fZpmk/6hRLAhiZ6ALYS+mdiBeD3C8eGCKB7Ub83OUjYgeVSU/nJghVnYc5vnlSIRpiYH+Dfg3/
	AcFzRQYRiJuUEiAX7KaprEPr/Sb68ValTkp0EzOm83pKQHsN7PjT1PjAZSxtug/w1T2gsYySV1m
	1MDcTEku7WYa58bgY2MS+MEd0+KrkukD9j/aULNgHbrH2whaosiIQDTlXNx6CZcHaJgNfQpCbuH
	kKycv5nLJ2TzF02hbRQJMG2NzsdARxt4sGHSr93Xujrgvz+LnFvE8cE2RHq4IO5eZVd+H6dmPCj
	2fRrM//mp0GNI2RGt6uYiVvqd9AmFgSU/qg62Cdr9/sGQlvfKW8fy+AlEJVMw+eCCKULCPXJj+J
	DZ2nC2/zf
X-Received: by 2002:a5d:5e88:0:b0:48e:6674:3b2f with SMTP id ffacd0b85a97d-49585f85d15mr6285161f8f.51.1794217315632;
        Mon, 09 Nov 2026 01:41:55 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-496150c6e90sm7278409f8f.2.2026.11.09.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:41:55 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 09 Nov 2026 13:41:48 +0400
Subject: [PATCH 1/3] dt-bindings: power: supply: battery: Add a charging
 temperature range
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-battery-charge-temp-range-v1-1-a967abd8b80c@flipper.net>
References: <20261109-battery-charge-temp-range-v1-0-a967abd8b80c@flipper.net>
In-Reply-To: <20261109-battery-charge-temp-range-v1-0-a967abd8b80c@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5090; i=alchark@flipper.net;
 h=from:subject:message-id; bh=s+ij2ixxg0Tf+IvaKSSYEw/URZBHqSW+IbBNwTTaFNg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9nBqv0Nq7YHdWVcC5PobOgwIB1VVbm5Zx829dfH7rt
 52zGThzOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqN15GhjlyUvNjgz4HnwlTjP52Nnz6+gcT/+vohly3ub4+pX2atiwjw6EF39c
 VHF8j9D67y1Tr7aYXZiESCqpH3KXsttpMeF5QwQcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Describe batteries rated for separate charging and discharging
temperature ranges, such as 0-45C for charging and -20-60C for
discharging, often with a reduced charge current near the ends of the
charging range: operating-range-celsius holds a single range, and
existing users read it both as the limit for any use of the battery and
as the limit for charging.

Add charge-temp-range-celsius for the charging range, falling back to
operating-range-celsius when absent, and state that
operating-range-celsius covers discharging. Add the charge current and
voltage to use between alert-celsius and the charging range limits, to
describe a reduced charge rate near those limits and none beyond them.

A missing half of an alert charge current and voltage pair falls back to
the matching constant-charge-* setting. alert-celsius is expected to fully
fall inside charge-temp-range-celsius, but when it does not,
charge-temp-range-celsius takes precedence to ensure no charge occurs
outside the allowed range.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 .../devicetree/bindings/power/supply/battery.yaml  | 45 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
index 9575ee1491bb..d2f2ed9a01fe 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -111,11 +111,21 @@ properties:
       for each of the battery capacity lookup table.
 
   operating-range-celsius:
-    description: operating temperature range of a battery
+    description: operating temperature range of a battery, in which it can be
+      discharged. Charging may be further restricted by
+      charge-temp-range-celsius.
     items:
       - description: minimum temperature at which battery can operate
       - description: maximum temperature at which battery can operate
 
+  charge-temp-range-celsius:
+    description: temperature range in which the battery can be charged, within
+      operating-range-celsius. If absent, the battery can be charged in all of
+      operating-range-celsius. Outside this range the battery is not charged.
+    items:
+      - description: minimum temperature at which battery can be charged
+      - description: maximum temperature at which battery can be charged
+
   ambient-celsius:
     description: safe range of ambient temperature
     items:
@@ -123,11 +133,39 @@ properties:
       - description: alert when ambient temperature is higher than this value
 
   alert-celsius:
-    description: safe range of battery temperature
+    description: safe range of battery temperature. Where a limit of this
+      range lies within charge-temp-range-celsius, the battery is charged
+      between the two limits with the alert-low-temp-charge-* or
+      alert-high-temp-charge-* settings. Each of those that is absent falls
+      back to the corresponding constant-charge-* setting.
     items:
       - description: alert when battery temperature is lower than this value
       - description: alert when battery temperature is higher than this value
 
+  alert-low-temp-charge-current-microamp:
+    description: charge current in place of
+      constant-charge-current-max-microamp, while the battery temperature is
+      between the lower limits of charge-temp-range-celsius and alert-celsius
+    minimum: 1
+
+  alert-low-temp-charge-voltage-microvolt:
+    description: charge voltage in place of
+      constant-charge-voltage-max-microvolt, while the battery temperature is
+      between the lower limits of charge-temp-range-celsius and alert-celsius
+    minimum: 1
+
+  alert-high-temp-charge-current-microamp:
+    description: charge current in place of
+      constant-charge-current-max-microamp, while the battery temperature is
+      between the upper limits of alert-celsius and charge-temp-range-celsius
+    minimum: 1
+
+  alert-high-temp-charge-voltage-microvolt:
+    description: charge voltage in place of
+      constant-charge-voltage-max-microvolt, while the battery temperature is
+      between the upper limits of alert-celsius and charge-temp-range-celsius
+    minimum: 1
+
   # The volt-drop* -properties describe voltage-drop for a battery, described
   # as VDROP in:
   # https://patentimages.storage.googleapis.com/6c/f5/17/c1d901c220f6a9/US20150032394A1.pdf
@@ -200,8 +238,11 @@ examples:
         ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>;
         resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
         operating-range-celsius = <(-30) 50>;
+        charge-temp-range-celsius = <0 45>;
         ambient-celsius = <(-5) 50>;
         alert-celsius = <0 40>;
+        alert-high-temp-charge-current-microamp = <450000>;
+        alert-high-temp-charge-voltage-microvolt = <4100000>;
       };
 
       charger@11 {

-- 
2.56.0

