Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A32D7398
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124877; cv=none; b=JZo/UJ1/Flu5oDhdSu9POWoo9TU9yJB0jA8Lu26gKgzj1VeZfbh24U2fQ1Gqgo1l5hkkBVM/T4qDPzT8i/JKmUWBZFr27Uo3ih+GWZKPF5WYLK6gexg3NL/YaoRr6aceFY2ganeun60Z1WUIp1XnF9HIHWAy/ea+obAedAiSauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124877; c=relaxed/simple;
	bh=0S9ZiRaNeD0ONuhBWck3LZ15qfVQqVd9GHb68v++sEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYTdUnt8b2QOgwhyaBJn2tJZcAprAGfzDdMJ/9k/Gq+AQ3qfwVIjgxEM8Aibd9wyqo04Gn+v1lut43E50dYnwzeXkQdgwqy9f4uSwVP9NIKf4NEfI8KiXDbHbvdrRVFpitBQd2b0e0thQbtYt5uFNeRqJdF+3z+by3EvJUdODg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRiRWugd; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRiRWugd"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15ea896ddc8so3978918c88.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 21:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792124874; x=1792729674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=soaPR79MMoowv6/4e0ZCsyZJkdHPPam+XR34R/7HHt4=;
        b=TRiRWugd03HK68YGIOm6hyiVi/PjVf8wnrBkLIXB2TR+7DT0Z+wTQOsYquKPT7j0Ai
         xELXqywbzK5VnBe15X0qtvrcdt+PzFfyFgbkaqSsTjOWNCsf57XsByX4YJoFdOj3fKvp
         A31z1O9DXfPfgUTvyTZ4cfpHkL+N5wAW0Uu01DbnBSLNtKjFh9l2AR1UfwRBFljhrqZr
         DQIxdwhquy/cAbuMH7EDQbg5wXXdOQnYIaK9Gez0QluWOiNLKn8PfFbd+7dNUkht2fI9
         9oqoH6Za81Xmv8XP+hQdoM9NIst2DTGVyEfbmbFbldI4xpNeKpOTXbXVgfxr0mmb2kKM
         Gxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792124874; x=1792729674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=soaPR79MMoowv6/4e0ZCsyZJkdHPPam+XR34R/7HHt4=;
        b=o/w0fubpe7+6cV/qub/nO7T9mDaFsGpO0AcpqtDiM13swAc8Ek5EPThE9Rv+5GKcrK
         e4g8h4Kz/S2Z+flwoayY5xLKalt3oAKNCQLJIQdQRzEi6FoBe9TsVXIZUrYAzfI/Szuh
         8PNqnjr2NoqUGRC6bBpXz7f1ocFlZ8dh6wa4uceCiYIav+VlFRtXZi9vo+/dC4GfpG24
         o+lX3wHZgJlm0PJbRhf74h8isu0vk+BMGFtHILBubYtQF6PUsl05fGIl8ZRGuFXZn+n0
         LKUTyPFRuNjRrvLuOXdQRJnO5H+HTC8W7MzOYEuParlYthCqNUP86DEm+Y55/veuIuzK
         fEAw==
X-Forwarded-Encrypted: i=1; AKwUvByZqh2J1Ugf2C2fSakpfrp+ZRD8mvcbm3GU8cbkd3nu/x54bAoLn2pi2W3kPPtZwYcanfTYHz/X2w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ09Jk0l8vNLU4MP4/PR657H8ghRIMDi0tFLIhbMa66qSTqs0SX
	O/aw3wuAJiCw3ReoYlcO8v/c/1K9rDfhjWxqpigqk96zeP0cqMBZ2pgm
X-Gm-Gg: AYBFou2dU9UnW5sG3Qnu7qlvVncM+E1otwYlQoPP4WlKPiRPan4As6N/uiPl0ybuTNh
	Eq9LKn9+f3+0t+wOiH3Xre1H5Pia8QfyG58310pKeEI3c8s3nApMx44/kdK57xjEOVEnOLcjnrU
	m80sk6wtqqZwqCMdLlKN+Kk5OONGYDRp/N7Z2SvEd8Xmc82YismF6QTZjlan7+TuaHw3p5nPizn
	jbENhLPvQdlB3h6O8m1X2ASVxnvJIGbwkmVvPK8u6CI1pBO4PdqmLsZz5+fW9ronBqh/Hq9YIz9
	T7R4HKNmx8c/r9nkRv7zC9w10AkYEgHPepBRSD74V1AASSNqeI/CtQ2N1LRXD1dCHv7k9ymBNCl
	617WWOzYQwntHK71s6AJZTSWILq5MKmglblQVUj75lqLM34cq1FBLHDEDh1V+NNcqCU4WTJYL39
	hdPo1I5UoRBMbmaRR3vTItlBrwt9TbqPevCIaUePqCOUKODLt/C7kDpZw1b1XUzK8LsVI7N48so
	C2zqykljQ9N6tEVmo2stjtrKkHXbF2iWzqHnE79BSPFfBWyOnYnhusHxDKoyPuX8Q==
X-Received: by 2002:a05:701b:2605:b0:144:fa57:c617 with SMTP id a92af1059eb24-16a60a02625mr30091887c88.34.1792124874051;
        Thu, 15 Oct 2026 21:27:54 -0700 (PDT)
Received: from localhost.localdomain ([152.58.201.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm2644712c88.16.2026.10.15.21.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:27:53 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org
Cc: danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v11 4/5] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
Date: Fri, 16 Oct 2026 04:24:31 +0000
Message-ID: <20261016042432.824-5-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016042432.824-1-sreeshankar0910@gmail.com>
References: <20261016042432.824-1-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the cpufreq hardware on the SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff..2dc2c265c 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -29,6 +29,7 @@ properties:
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw
+              - qcom,sm7250-cpufreq-hw
               - qcom,sm8150-cpufreq-hw
           - const: qcom,cpufreq-hw
 
-- 
2.43.0

