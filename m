Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D639B4BC;
	Thu, 16 Jul 2026 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236026; cv=none; b=d927lIKdnmcesGQNHAHaZTgW2YxCcdRtMnMA0s3mhAUm2rlJ9PzwVYvMf1CjUk9thUn0+KcHh3HEzC1pU9KhnDO+YK3hEG4yhowpY47Ch82Y+aEtlaxXifTYlY0Uv6/6xEZKbKrJio5AYCESsRxiTnA7Scl6IiKyfN9R1JVnfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236026; c=relaxed/simple;
	bh=QqWj1+D31O/3KQIWteFXYGq2Pkv3RETxUVNfG6LXlHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iC+KubQvLNWTj91tnySzaiFUm9KHC6yNxIsy+dwb4wuUIzMhyeyIjUZgItgdrUCacyJp1OxVu3S+QBKMPnVPAkfxr0GI58kWPk7avwseaUuXN8+VChMlTISaA3J89qXkA4jJbPau28u2E2pShb4T2IB80GHmhlVKvu9PqH/fRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2vMWjor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2vMWjor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7171F000E9;
	Thu, 16 Jul 2026 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784236024;
	bh=wRv4lOlKrq3dAOzPxj081DoRmnFjvX+pfhBpXeiahJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=D2vMWjornlyVXuKs4ZElabuNI7w1Q3eVyg5StJmER9vXugRvhmkx9JO18TXH+ZEuF
	 Rs1kYbqnqUazDhraR1RRZzVA1hQ/nl9zkOwV5baDCNG91SK0kRqcVaqdcikpGAZ/45
	 OiR05TZv9aVfYwMI7xw9HzGTAxxJXIEIs+TTpI3B6c3yCbV+WeRlMvtpm8mPIUV5A8
	 8z+NEwAjHbDZVIYJbqbWUidGgMR0LVQnBaqpEDPT3zlAi5QdVr5qNl0VISAqP9bYDc
	 teQ4Z1KkDIeTwDcEJ5pJVjF2/TaTQpvOh0qCHcggSJi5UfPlJb6q7E8zyw+LDVBcnY
	 H/8wbiIimcRFw==
From: Srinivas Kandagatla <srini@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260713-mt6323-nvmem-v3-0-205c39267a24@protonmail.com>
References: <20260713-mt6323-nvmem-v3-0-205c39267a24@protonmail.com>
Subject: Re: (subset) [PATCH v3 0/3] nvmem: add support for the MediaTek
 mt6323 PMIC
Message-Id: <178423602161.378875.7272283878375160682.b4-ty@kernel.org>
Date: Thu, 16 Jul 2026 22:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 13 Jul 2026 13:11:34 +0300, Roman Vivchar wrote:
> This series adds support for the EFUSE found on the MediaTek mt6323 PMIC.
> 
> The previous version of the series for all AUXADC, EFUSE and thermal
> drivers was split after Krzysztof's comment [1].
> 
> Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
> mt6323.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC EFUSE
      commit: 8852dfee93d3f8a54399060052e68792ba35f1b1
[2/3] nvmem: add mt6323 PMIC EFUSE driver
      commit: b3c090960d86901bd4e41447744fd532d6e1d7f9

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

