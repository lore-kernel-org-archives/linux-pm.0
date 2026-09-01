Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED8A4137B1;
	Tue,  1 Sep 2026 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228604; cv=none; b=MKTSj0pH5iStz+kJuNxeOpiK/h6EWX1F+8oD8YwjMHWZtX/D/gM2w76LTn6oWkvttbPSc2TM8Nhlodm2jST38n4fY+JOvBlSgOqo4Xsw7UYv1IWMEcUCeJUeYRNXcj7JbRKCRlNL7iuRBPKvnMvhW7b6d/9zQrV9/PqKnVxhyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228604; c=relaxed/simple;
	bh=pI/m15BORp6H3uuLVg96xEfLWePxBXtyexYM7MW5aBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK+LZTZeeAtbkmdSvdYbPJanJ1III8QhTgv+ZHnc4lunkLTWeCt97d6TRvJ6RCfA2Nq3q2rEvpCaj5jNIOdBzEth0Li3qogXl9Yc6oaAEMV8mf8D/hpZKq5Am4Bra9HqMili2Mlc6xPE+swLYr3RqMcGO0v7hRv7/S23P1AN74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGLt3MzF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGLt3MzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94471F00ADF;
	Tue,  1 Sep 2026 02:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788228589;
	bh=l2/Qv52KLhzYpZwCHsLF5SqhNc2qXXwGucecsmx/0Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGLt3MzFZAg2OAWLMPK4YKeFbygwwQCuCHABdfgMQv/2BkqLIOTWFrWOLVUoIFVEC
	 IoKGzb59iXn3cLyb5IE3IPJ5rE72ovil1mGSw/wU+2FRvkWWSEUu0sgIbyCsybibnE
	 z+X/WpyWvl7lp/7srNMep02GWujEt2h9prYhLO9UvE+x1jQ7CVhBhRvX31HyCiRehY
	 YLxuZGy0WnpgTyFJC8RrmK3TNCpHAXBNYTR+jd6GjPs1SP7oRqKjPGi1Yyv7ZoaUNd
	 n3V2XnKlSBj6/vHkSXkli4GnmMNuCcBgy4sBuA7FfY7SAmRxhgu1W3VRIeYUHZtXAn
	 UdWZS1DlMsW4g==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Add Milos CPU-to-DDR BWMON support
Date: Mon, 31 Aug 2026 21:09:25 -0500
Message-ID: <178822856250.1835959.17205450156743825339.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
References: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 Jul 2026 13:45:01 +0200, Luca Weiss wrote:
> Add support for the bandwidth monitoring block on Milos which lets the
> driver vote on interconnect bandwidth based on monitored throughput.
> 
> Similar to the CPU OPP table series[0], this would benefit from driver
> support that can differentiate between DDR4 and DDR5 RAM since different
> votes would be correct.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: interconnect: qcom-bwmon: Add Milos cpu-bwmon compatible
      commit: 63a0be9b801af9f357054226895d5a172632c7ee

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
