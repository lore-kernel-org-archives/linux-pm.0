Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9263ACA7A
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295253; cv=none; b=BKktcTq+1Gma6ly1mv8BOkkdfa97cSHnwgGI2crS3z7+sjkwOYNgt8M765M9cYQMVeZ1ukaeGA7w6GNwNpIm5CRDiQvNiSHT3qQWcZx4UBDhoXV70UFv4zgURDwBnpIbmEVbPd2wIK5kPo+rLOJnmP0cwXyrh6ry6xXaEo1xMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295253; c=relaxed/simple;
	bh=DXXh0GJHE8ur+1dO1nCpSy/JskzK6PWckuD1ZB0l9cQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZHauVdcp9cZxJXUtllLrYclLnB6z7juBOdUFqVMYedQ+vmSvDlxfvifugMtTXkL67rAcLnNWTvVwp+L9OmHIS/5eFZxjlm4mutOXeWTcjY255SqLUbygvqvdt0bsDHfhUZmnK8TMsZE305k2engCTPext+ltk0sV/N26JKRNjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=m2rc9AI1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="m2rc9AI1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4720d22c94aso4964416f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1784295250; x=1784900050; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KSVT86jwC5nyb5SerhE6T35ZLSgx4GxTVi5D3yHG51o=;
        b=m2rc9AI1tZROXhbsnjBg3IkKftwrRLzJc30owGyDwE7uUc7KLs8R3EkJpl8dWRkHws
         xLaLRguMeYUYyQ0s+DsLURbEeAxGBCPzCjN/BLNaix5wPOt6w3CVxLO8AilWGGcI9BEo
         Tgm+1CZv2HtAjrwzCLd80O4+euWLFHZ00YHNooUboDyQY03cn983gQpAWmaGQ2XfCnIL
         3erYaPqxanQsIXstzkGGphxfYV2tG7t1u75XDboFBcvP3mcz/G5QJ5r92RkYf1jfokDd
         yrtWt+1MD/vbX2YkRhXowdRTkKprxKG5SosoveuFwK5bvupK2blkekeOmFA/Pp0SXWUs
         V+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295250; x=1784900050;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KSVT86jwC5nyb5SerhE6T35ZLSgx4GxTVi5D3yHG51o=;
        b=Zsii03QnaDd1puF9GlFICXN8Ka0JFxqnX3hV6Iy8cChtuY4AK3zyj1j4KHsbZTAGlW
         papLvBuEER4sRh+Zs3v0ldbCJbbcH6p34qEyJN0l6IDfQ1L2NPnhYMuKcMbFU9G9i0HI
         WsBQXeQfSMYnAm5kaDylexGSXKsWobsTEucBGlfQQRdTkYuDxbBAYCLxpXXiI3TeV4Dt
         NVfgPyEtxtWtSSQ5tDMJKCBHO9dr72TAiw6ZOz0H7lFGVtEh4PtZtiESzBaPvEPx31ac
         Xk6x4+FHwd+aKxqA6wzgt0/OeWaxhanMMz3IczAi8kn7kg7y5lFR94H7/ITKrrUt4wo1
         U2GQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmR7VcSdxDpkj0MyRwVqSxqwqOUjUhTUDWzmKUnHG0VckBywhL1vUEnpn11cr1mZ8xJb7Zv0vyfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVgNByMFqbyMdItZQnZslSZRGnMMN/c9TQ/BocuEmheTsHo2z
	/p+y4Yd/0EugEdZvPtP+Acc6YbVxPDiUin9UyQNE3B/lDlhP93zg5EMKgDQFhJNytB0=
X-Gm-Gg: AfdE7ck1DUCO06jnbO6jLwV/El6IKWQvlFd4iuYNIUh5HFyY9XWlXRFqdkX+CCB/f9w
	aiYqqezHneu93BcAt8Bm1OQ12BFamk3BZ792jjaJxxYtw1BwEJrymDRhXe7l9biPrPISmjx6aPh
	Q1w5YgreThC7vVcRaEUGcqmNrp2+7gI2rbjvb+assNlpYebOqR6oIuhXCQgiDGhQV723F9YuYch
	t0P8fII90XhbMGVrDjkgKUwPUYCqldTOfGWuERV74PjibL9ANf9a8HWQb3UY0OMtkopj7CePPPv
	KnSsQMh0ywl8EYr+ctHNFde0waPzIGmjKzay8fhWucvSbmXOo2p4eeEb5Q/9cFNb6vnP/qVgcxb
	cvPtRNVg4YiI+YnMFtVTqljB1yEwms5ec9yzK6j3IHj8LEH3U42ntg2zK1dACEuSIaglSeavRN8
	G0aYBQzyWT41OHbvR12yMvhniDtQ==
X-Received: by 2002:a05:6000:4702:b0:47d:fc20:e7b4 with SMTP id ffacd0b85a97d-47f622f2c4amr3719847f8f.10.1784295249579;
        Fri, 17 Jul 2026 06:34:09 -0700 (PDT)
Received: from [172.18.170.139] ([185.104.138.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm4361547f8f.5.2026.07.17.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:34:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/2] Add Milos CPU OPP table for DDR & L3 bandwidth
 scaling
Date: Fri, 17 Jul 2026 15:33:02 +0200
Message-Id: <20260717-milos-cpu-opp-v2-0-428813fafd52@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOQQ7CIBBFr9KwdhqKBqIr72G6AJzaMbYgUKJpe
 ndpu3b5Mv+/PzOLGAgju1QzC5gpkhsLiEPFbK/HBwLdCzPBheSq4TDQy0WwfgLnPQjZGWmP0qD
 krHR8wI4+m+/W7hwn80SbVsma6CkmF77bYG7W3D93boCDRtWdDD8bq9S10xR870asrRtYu+wDA
 d9T+Tvtq8zoiFDuA6VLlVUtIFhRwssPDA/AEewAAAA=
X-Change-ID: 20260710-milos-cpu-opp-26fb6c36be60
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784295239; l=1554;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=DXXh0GJHE8ur+1dO1nCpSy/JskzK6PWckuD1ZB0l9cQ=;
 b=VjKsALIT2Lckvq6HraKgzl8M6gMe1at9iKNQMLqAWalW7m0MptW3ptDBRU3bKX2SWOeWF/uOK
 3t4a1YkJqXwD4XOOo8qQmEJfvK7eOGs58FGcw9K3Ic1MLKrCeT4wWeg
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a node for the OSM L3 on the Milos SoC and define the CPU OPP tables
to scale DDR & L3 bandwidths when CPU cores change frequency.

Tested with 7zip benchmark ("7z b") and membw [0] showing very close
results compared to disabling .sync_state and thus keeping all
interconnect bandwidths on maximum vote.

[0] https://github.com/doug65536/membw

Unfortunately there's no support upstream yet to have different
opp-peak-kBps values depending on whether the device is running on DDR4
or DDR5 RAM, which is where Milos should use different DDR votes. For
now the DDR5 values are used which are (usually) higher, but should
hopefully not cause any issues on devices with DDR4. TODO comments are
placed where they differ.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Squash the three dts patches into one, some patches along would result
  in performance degradation.
- Pick up tags
- Link to v1: https://patch.msgid.link/20260710-milos-cpu-opp-v1-0-ae7f4b09bc77@fairphone.com

---
Luca Weiss (2):
      dt-bindings: interconnect: OSM L3: Document Milos OSM L3 compatible
      arm64: dts: qcom: milos: add CPU OPP table with DDR & L3 bandwidths

 .../bindings/interconnect/qcom,osm-l3.yaml         |   1 +
 arch/arm64/boot/dts/qcom/milos.dtsi                | 344 +++++++++++++++++++++
 2 files changed, 345 insertions(+)
---
base-commit: 4c45e14df2f4e77982ad70d6d8e3fe750edd4c37
change-id: 20260710-milos-cpu-opp-26fb6c36be60

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

