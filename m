Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA8126F0A;
	Sat, 21 Mar 2026 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098985; cv=none; b=In6xixHsWTfnTrVKk/RhvvCz+fDtfhF8eZNWx8uOBbE3DCkcUKgCRUfUNL50L/xbYXpWijnihjLMbH2Sbcrsa2rn4h1/dkTVE0DyidRyBCKX5xRTZYjXPomFyGBqkrWCFa9pUXZ7acSvBSQxFFXjzF9Zf38isMU3lkM6FNriZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098985; c=relaxed/simple;
	bh=FTUy3SHKisCSb3aVqdeTnX/ivZtExz6zz8qPUm9jZFA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ABlcWq9YQA49MOqe8+Ji9SUdGppTWjo0O/wELdapeXKGhO9bW9afuGtEiS/y1Tcy+ftmLRkU/V6DTgc2FCkndAzWSSCSvkkfWdM3XjxnSIDupDPZjX8JH1xSNBE5IwFPYV3IyICh0jYynZzQWitizYp0Y2U6DqRWVNq/JsQyvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSS+0sA4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSS+0sA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EEEC19421;
	Sat, 21 Mar 2026 13:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774098985;
	bh=FTUy3SHKisCSb3aVqdeTnX/ivZtExz6zz8qPUm9jZFA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=fSS+0sA46I8TT2FNYNz+7ucPrPbu6XF6GOWjkK47X5/SqdAZi/gMKmPhodXWuRIxW
	 a4QlWXfJTX8+POg0uoNaILMjiVzmdhyFA/L0z8iHkyzgrZ2Y8zTnxxfXtFXWLcJyU4
	 RrFXm9PVtZ+2SSuDWa7XzOC1l7u6YrYwKyfFOS27te4xP7M/gyUNIc0HIu4NeS4fb+
	 u351MoOJwF8/SUvmYLVQOnZKFJUasnLjJJ+jIO1RsxXzF5bHmKHNWteK+WeeUwzplo
	 +AThnUbM/25aEkHIf25gHVjL6atlO8WVUUdKfG9V9iY/OldbQxPCZ0nmtKCOL48rtA
	 LEVK+1to6q9gg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 02/10] dt-bindings: power: samsung: add
 google,gs101-pd
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20260318-gs101-pd-v8-2-241523460b10@linaro.org>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
 <20260318-gs101-pd-v8-2-241523460b10@linaro.org>
Date: Sat, 21 Mar 2026 14:16:13 +0100
Message-Id: <177409897339.266364.69715997034739052.b4-review@b4>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=krzk@kernel.org;
 h=from:subject:message-id; bh=FTUy3SHKisCSb3aVqdeTnX/ivZtExz6zz8qPUm9jZFA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpvpoiSSVkjLgy+SPAun4vTdN6OjGAsY6EB1ZHD
 a/yLk/mBQSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCab6aIgAKCRDBN2bmhouD
 12I5EACGV7PuLKZQwhTb6sv7cuMAGpNxYPttAYk1fa3JuZf2DQrLoCZiMeMHAb9pjUjCTpP8MCC
 0LYU1XsM/segNP1fyf9F6aYqD7haLQ0QnnHxjLANXMIexqbT1g2fgNVs0AZPmt7aQEo14uo5Trj
 gCIRI3XSpcnFhANTHs5LIAAW9+dxSL9BrB4We/UhCs0KXUXpOHoj9T8TuEnVwg0XOQCMuqyoF8Y
 E4IBX5L7dCHRo2q3n2LCqu3t58LLSAONSw7muGnUYOb8XCY1ZEuhIecmRc0L1Wl538Eb01srRVN
 N0p+f2xEPn5dM9CEiQ4utoHGz9WlhAmW1wczajWbrtX1WaiRlYFcfUaJ/mCFq6XQY4sReRxqQDp
 us2FKUBML+eNvHGNlOC53oqsL/eROHlc5FeF8RTLywO2j0SpxxABxKGI55oW6HYA+KtiAWEwyZ9
 oS7zeuzbzZAPKwRr51LvIpC7kyTXsNB8u5X0vPgFXP+XNQEwmtEeineZlzefnMdJan7kBvA2ZL7
 Lixmwi+ddWCt0ouetwLDUK089QwGjlSzvoQEGAjOFGC87X5ifUWVKmbKVvUG5sth9TFAXC/BP1V
 pVUM5gFgroprj4u6Xjt9Q6Jzh2WnqQ8GyPgLNR90cYlcP6M5C0+PcMod64+39rpmQrI5Glg5sGj
 Qo1PihFPLFdbd2g==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

On Wed, 18 Mar 2026 15:27:47 +0000, André Draszik <andre.draszik@linaro.org> wrote:
> diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> index 9c2c51133457..3f1a2dc17862 100644
> --- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
> +++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
> @@ -44,11 +45,28 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  samsung,dtzpc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Distributed TrustZone Protection Control (DTZPC) node.

For what purpose?

Your patchset is organized in odd way - first patch for me, then not for
me, then again two patches for me. Please keep it consistent. Or better,
decouple since there are no dependencies according to cover letter.

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
