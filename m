Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315042C513
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583820; cv=none; b=UkjDRTBGB5lemtcv5yWJnDirtpP7tbeKoob23MlpBDVooYQaQY09ZnzgaNDRB+zXyMxrSbei0gmx9yaVtfWE45ru1RaTwd4So3KKDTw+Zm2B4Qio6waMF4wUZ3kC0QY1qQhSr6mL/BcTMuQyNuJo4Znyl4h7sZLXXgaP5esVngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583820; c=relaxed/simple;
	bh=jKh+XPUoJmr7fIpNbx8/2EaPd/67MsZW4ebNDZ/8MPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBWgy39szuVBKRtnmmMn7rnVxQCkFmQ3U4zdt4lQEqRYUFasGL8m0B23BYd3ePZwamYVDKVKJNXOuzZYspQN+zgcvgU2uDCKUXDmrPmELWSE80xiJjo5q6fC3x9PzPWCtnw3XXvSeFOVIEKWQT8mp8/Ru91cCYJ+zsL/FpNl9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AllZ3pxt; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AllZ3pxt"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6b5737bb2so5211673a34.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787583817; x=1788188617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQnqfdvjWzHpIFqKpmfnZN4AvVDc8IQ+C2JI25EK8GQ=;
        b=AllZ3pxtD6h27T4HEHXep8mB2/RMKUx6IV559NoJnnklENcXMvKQuvoSjumQG8sPC4
         brIDIlibXMiuCnKDGjWJdbrHSO9Tak3xyCP2I9VHPLHvQuOtOKnoiaTHTFtBVZ+YzJ/z
         ibpilitEFi49VmhtQBke7sCROB2xBwmGgEe0DjDABHWfWZudgwdwF90OdAcOtmvOo/bL
         XJZp+5MbXegAhpUAirb3cHylk9Aa1fIKrz/jdd0mwUFnvsz4NWKc5MmaU3ixhn8bmkp4
         eXJ0qguZpWDs6AFzbspfXzEUbY0iyP6h9XJigpK4W7P73tWcEFOg8oEkQQWB66M9mG8m
         V5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583817; x=1788188617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQnqfdvjWzHpIFqKpmfnZN4AvVDc8IQ+C2JI25EK8GQ=;
        b=i7eCo4YFkVlU4w6QNRKemzWXLk6wQGz9XuwBcOaE/9Y0zzCkF3c4bGCxAZuntGuG+x
         AicB/NjI/2DeoyJii//sI50uHAxD76Snu39FHav8IRfKYC76XUslAs2mUaaBWEjnbl1b
         FImc4D3666XAG2IXUIGTozvlOwpj6TtgFnyxzQIl0yrWerdkAe8z9lRnPdqH03fnyBSM
         Gjal87hbS0ckjsC5ItCZr4BsgYpW1byVVkHNS7MrMYJ5Fs9oDWMFDfwytiZY/CvZgDVL
         QJBRHht7CeExEbfftps7rH+kGR/aQPLcH5GPkKExpeEMTlf7VJBOnPimH4EyN6+6dqIA
         1+KQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdyxaAy7EWtQbv7cu2JwfMG04341OtZtnsrz9BFKiOo0LR6e/ZQ8kSLzKnNjLl7TejJQiBd809bg==@vger.kernel.org
X-Gm-Message-State: AFuF++mjiHjjohbgf+BUhEel7WKQjNqTUo44Xdvgcqk/Qw4+mDuYL+PO
	0OZmEsOubM33a4Ieo+OU5Bo7qDZ2sRPsMe5qy/Jf8y7km2OTeuaaomG6
X-Gm-Gg: AR+sD11bww7WKf3/89sYENZJuv+uJdVtviOXsMIx0c1cdd+0zgjZtk1qQBIKKmYY0Xk
	wtLQjUuc2J/Cfk0uhbUXDsKOnimgGfhzt2vMtUEtvksW/S6X3gPxd5o6JzdXTZIVY2eO/7vCGuu
	wcZX4hxLlQxtVZlpo1ResJsvYqZfQjbaH1kSab6IRZ+fhYykq8rzLQX1WIQp6vDERRWgtoru5Bh
	uEAJwljRxGOLshh1Q0PDN4ZWRg+/qKZhM2R0/QowrmDQivZKnQaWeZzbnzQ/1Uhji4bHJJ4BWdD
	auZc4gtaE6cNQAXb4oVbem3pEIFfRPtHGvwO/b6Vp1wL/SYB91F5lEzINAx6FzHAoQHtbFowNQn
	Va0df3fhlpw47eGxDfpvHDCwet0B+ATQxi8aHdCSRUjFN1nRTYdpQqYr5NXJcsT/GTTTYIhxiQy
	0JpNHwMM5LpXMMKdBRdkcEdSPtu2WVmohuVE1amlIaJQpwycdT3JaB+QaIVQ36pA9Z1aN4IlrAf
	jZfb9E3ChtJ
X-Received: by 2002:a4a:ec4b:0:b0:69d:e4c8:86f6 with SMTP id 006d021491bc7-6b1592b8c96mr26911121eaf.15.1787583817353;
        Mon, 24 Aug 2026 08:03:37 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d381csm30035247eec.19.2026.08.24.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:03:36 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	taniya.das@oss.qualcomm.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v6 07/13] dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
Date: Mon, 24 Aug 2026 15:01:50 +0000
Message-ID: <20260824150156.1310-8-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824150156.1310-1-sreeshankar0910@gmail.com>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the RPMh power domain for SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0a45e1f55..e08441915 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -63,6 +63,7 @@ properties:
           - qcom,sm6350-rpmhpd
           - qcom,sm6375-rpmpd
           - qcom,sm7150-rpmhpd
+          - qcom,sm7250-rpmhpd
           - qcom,sm8150-rpmhpd
           - qcom,sm8250-rpmhpd
           - qcom,sm8350-rpmhpd
-- 
2.43.0

