Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65573F660D
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288734; cv=none; b=f0kgrBhUPhu2CJ7nKPivJzhauHCm12HqJxDYMA0o5ZUrycfSp+/yZGNhh4h/KavwXf048+8IBhzmTyKejk5i2hb2Xcbo7EYgtSJ+0MkTo+qF29+hZiJ/DrwQM7Dh1b1rNoNV9fW2+pcdWEMlIlby97XbbN0qeqTsL7qDNugi1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288734; c=relaxed/simple;
	bh=9LbC1FHVDDMZdYZI0WqN7RgRzl9vDprPfnVnjf9MUaI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UqjrnDOnYy3BKumBh7J21gg+kZfJhDdCdSfY7/6XQOBydECfEM4hWCHOUiJKXAsamb3z9/8n7zLAyU+GcUn+hKQHcClInA+Ao3x0dm4Qn7Ozt63ZFMN59yIxq08Bjrqwr9ZLOoH+xrVk+BEZZtw2D4ZQM763CThH+8UuSlrH65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=3ryjejuU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="3ryjejuU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c19bad03so61492605e9.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1784288728; x=1784893528; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EpUodwbhkAxMkmXtH6zvZRrKPhM41ygJzANZM/9HTt0=;
        b=3ryjejuUxYTfUqthX+6JVN6mV4yYEwMcwwceDmQrFthpdosF7FuHqRBin/WkCEZnfc
         bVroc8hCNxndz7pvXLUvmwl6p7CCRJNsPbGMba9+tUWK55Wcj+Tk1RVGU8ugzl5QddW2
         q8Iufr+sGixnWj8+4asi8Im4TMPkuzSvcO5lnxNomVM7MGWX+lrcSJkZziP0Xo3ksALM
         rsrDM1NcP0yxr+dGz6BE6jP1NmUrmCclnYszoHLLq8F3LQZniEoZR1rJmj4miHCWWSkA
         6Jr023hi1rYPAIR6gqEQbwektat4iwt4gHgQhkBgEKNdGr4MBQr9wzigV1U7jcf46svq
         t5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784288728; x=1784893528;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EpUodwbhkAxMkmXtH6zvZRrKPhM41ygJzANZM/9HTt0=;
        b=JfUnNE0j5c9jPkSm6kwgzkf8GP6plRWxoTeW1JK58T36TCS4PFUpwYityof4gEMtBO
         iIHafs38530lfuSS4c+ZEyCLS5VPUUQRoPTTiq7KsmCNKRrYDLlXed6xYHDoYrrgfIxt
         1ewUGWfy0ndQfR/FrEp4Oj+TZgw3utvRhB/U7Drqf83OIdFCZeeMboHE8fGupp8RfAlA
         4LxB4/lF2t/NatVMjAvnMi+FrVuRQOZpssqOIHNQ7VAVEC5y6Lz/djz0IAAPtXyDRynI
         jW6cw8vH0x6Xrm+oABImUbvHvuW0fCzFYorGzOdj4bqJOrAMi2zT6iAmzLz93r6XP67X
         4uFg==
X-Forwarded-Encrypted: i=1; AHgh+Rrioq04ePjktpFj6i7V4RxZ4bRrAamHoizBuCTJUVfA1Cp4BHm3qc3Ty0N+Dwm5RJ3WrPNkRAaFZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+W5/Dq3KFHvwGCtq/84WQJGF3MyyJUNxhhWtoCl0T+MlXdaF
	4cywajkqLA64So1ZI6TLXIu/9JghowVUTJ4L8NItASdQXKKh6ppXi/p1DkN6GM/178E9CBL72Qk
	1i35fX3giqA==
X-Gm-Gg: AfdE7cnhPnoOwWptEiWJqfwLppSucAy1fGZgdOpGuXWU/wf7Uee6v4yS8bfhlyinH9Y
	GJYxybo6+peP3OlNCFL0/p7YRJopobpao+msJt8ij97Bh3F+mn+l0AMc/kGO9a3ZVwAiFppYQbv
	7Y0XDBfCLSl42/7oy4zK6b3Yplkf8GIhRq9AOnoSz4DZOG0lUsVP9qnEnLhUhCMKxElIZITHJNp
	dRP3GZZtdr5ZeFaAlckZ78l5TvQOLccjQwpZRrWbQLbJ4h0S9yHhx9njcN3R/oDl05nijbeRRtW
	tCr4iQ/2MeCARU81GHK9pancrANL53GKbTXLU9ZG5jBx3IUIc29N5dn5bBaT1islgQzcGEy0A9a
	v46hhKSCVFHP/Efd4I6RpLqcubL6IQdtepTSFyIlWqeCmELozDgQO+atMrL3DlPSIyx6TX6CYlm
	mO7jfbPd5C0rqSFpA=
X-Received: by 2002:a05:600c:1396:b0:493:b150:c607 with SMTP id 5b1f17b1804b1-4954a3f36a9mr25499865e9.12.1784288727673;
        Fri, 17 Jul 2026 04:45:27 -0700 (PDT)
Received: from [172.18.170.139] ([185.104.138.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm41353855e9.0.2026.07.17.04.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 04:45:27 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Add Milos CPU-to-DDR BWMON support
Date: Fri, 17 Jul 2026 13:45:01 +0200
Message-Id: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2Nyw6CMBBFf4XM2klofTTyK4YFrVMdY1vsQ0kI/
 24Vlic599wZEkWmBF0zQ6Q3Jw6+gtg1YO6DvxHytTLIVp5aJRQ6foaEZiyoPy54tIb28qwOZLW
 AuhojWZ7+xUu/cir6QSb/MpsR6VXqVV410EMiNME5zl3jacq43R2hX5YvqiRshKQAAAA=
X-Change-ID: 20260717-milos-cpu-bwmon-fce32974efb1
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784288726; l=983;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=9LbC1FHVDDMZdYZI0WqN7RgRzl9vDprPfnVnjf9MUaI=;
 b=vrKpPTrZL0S2ljLXdwMb0KdZ1gBG0K3Q0BF4hIQXj4WiGn98nVZ7Q45EATOPjPOb57d+Gw0ZR
 mTE7gVnOQtHB+UYaxZoWMscEQIhJFqmq0SKKNOpYD723i7Eq4WoxpWu
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add support for the bandwidth monitoring block on Milos which lets the
driver vote on interconnect bandwidth based on monitored throughput.

Similar to the CPU OPP table series[0], this would benefit from driver
support that can differentiate between DDR4 and DDR5 RAM since different
votes would be correct.

[0] https://lore.kernel.org/linux-arm-msm/20260710-milos-cpu-opp-v1-0-ae7f4b09bc77@fairphone.com/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      dt-bindings: interconnect: qcom-bwmon: Add Milos cpu-bwmon compatible
      arm64: dts: qcom: milos: Add CPU-to-DDR BWMON support

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |  1 +
 arch/arm64/boot/dts/qcom/milos.dtsi                | 49 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)
---
base-commit: 19827e7930a5511c68e12aac6e4522f3661a1709
change-id: 20260717-milos-cpu-bwmon-fce32974efb1

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

