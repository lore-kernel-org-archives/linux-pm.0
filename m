Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A130567C;
	Thu, 30 Jul 2026 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449074; cv=none; b=eL0I//VMGvQmZay6R/NxkTLOdtIruqphYKWz02amoykL+lzpeQJBvs0l18XYLO/Q4+UyimfRj8gkHSyD7jY1r5pMGk7Zw/EWzpsHTdrOPDB4Gmh6wE+mkmYcWgUE/q+0rMCR0jYKGhp44VE0iuIdv3hPKa0yyhIWv91VuTCXopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449074; c=relaxed/simple;
	bh=t0liFaiZANNHqmqeVPHU8zVU9riqfNJoavuOSw/6qzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZUYGVJxkEG5mpvKE1eei/SjvzdjydOhZzmq2Kb7L+B8P6ZHfhUQgdOF9UUUfQmdwrfj14d+q0GAja5EFKjFT7+8TFg/AzP6DJwr5tzI02ngmmfs1Q+wmtPCm+dO0+pPg70gpcDv2yn6SGfZaWOJ6AAbsn3f1ru5aG6u7iyi/saA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19911F00A3A;
	Thu, 30 Jul 2026 22:04:32 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 589BA18073A; Fri, 31 Jul 2026 00:04:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
References: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 0/3] monaco: Add PMM8654AU PON support
Message-Id: <178544907134.238864.1390835100279901939.b4-ty@b4>
Date: Fri, 31 Jul 2026 00:04:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 24 Jul 2026 15:44:10 +0530, Rakesh Kota wrote:
> This patch series updates the PON power and reset dt-bindings and
> device tree to add support for PON power and reset keys on the
> Monaco platform.

Applied, thanks!

[1/3] dt-bindings: power: reset: qcom-pon: Add new compatible PMM8654AU
      commit: 84b3a9353e3f32ebd0dc5bf1ab378742bd7cb682

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

