Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BE38BF67;
	Wed, 11 Mar 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213051; cv=none; b=PIpyrSrkM9QwQg5mS18aUuOfMGKvnui4tEbpwH5Wty+cEoM7AajMvO8oBOCEdjmA+9F77v7GUj91/rErN1vYBy7hZvnTY3WlN4wo6xHpk/7x3gH/ERp+RbYNDsdipEGwWXk+oGaLinWxeXz5JElTe2hqvczNST2GFxzpF+KtkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213051; c=relaxed/simple;
	bh=R2vomvG0JHBvkdHo8dd+Ba8sEqe81Ibe2B2jhQZdt0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M++WSwRv8cdKOmXj0+sWjhkJq4Z8iqQRZYzlOmwD+PGwtXnW4DbXmuOfJEByMdzkpw9wAtRrO87O21bbb0/kbgy5wfXXbUTFSkCJgwbxt+cKr5xWL6Ea6xetVDcKchSQvvub20FYlMHCVVzG87eZ4AHvPClbOMwbeMp1RIj1trM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9823C2BC9E;
	Wed, 11 Mar 2026 07:10:50 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 81E681808EB; Wed, 11 Mar 2026 08:10:45 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260306150738.497978-1-arnd@kernel.org>
References: <20260306150738.497978-1-arnd@kernel.org>
Subject: Re: [PATCH] power: reset: reboot-mode: fix -Wformat-security
 warning
Message-Id: <177321304551.505649.14538200747062900965.b4-ty@collabora.com>
Date: Wed, 11 Mar 2026 08:10:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 06 Mar 2026 16:07:34 +0100, Arnd Bergmann wrote:
> The device_create() function expects a format string to construct a device
> name, so passing a variable here introduces a possible vulnerability in
> case the string can contain '%' characters:
> 
> drivers/power/reset/reboot-mode.c:148:22: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
> drivers/power/reset/reboot-mode.c:148:22: note: treat the string as an argument to avoid this
>   148 |                                                  (void *)priv, reboot->dev->driver->name);
> 
> [...]

Applied, thanks!

[1/1] power: reset: reboot-mode: fix -Wformat-security warning
      commit: c7e05ab38adc44d0cae4888016829359dcbba7b2

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

