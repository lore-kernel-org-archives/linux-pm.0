Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C43CAE73;
	Thu,  2 Apr 2026 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170492; cv=none; b=dwN3hck33pZGQyGxUtlCcUyTMnsWAq9JFed3h0LVayyq2MkcNmaKRQDUghugS355iSQrjZumLHNzMh9gtYM1rGSpdHz2i9nfZZifyXRLOCmhC50fmcGQa4czNc1ON4cU+KkF/qeawe6s4RMcl+9nCv+TUd+B0afQumh5Meg14X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170492; c=relaxed/simple;
	bh=IqDip7nEgHUUl0U/LKcb3OZPqyMQoZGcbXh/OCJEsuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r8fKHeYCNr6lMNeQTEnv8pWO8Jzfvj+XILD16YEU376BVT/LJUoVZRVuRh2fzYQWCGVV829ohk9gOBTJObooUlQJcCXFQTXrgBX7EOkGa3ydbkhumNIYBfjj9IdPgaD45MeX6YF0r865Dj0oTqr0qUVxy5PIlAaRPmqZWYWbV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8961C116C6;
	Thu,  2 Apr 2026 22:54:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 306FE1812B6; Fri, 03 Apr 2026 00:54:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
References: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
Subject: Re: [PATCH] power: supply: bd71828: add input current limit
 property
Message-Id: <177517049018.464276.12850770472323229177.b4-ty@collabora.com>
Date: Fri, 03 Apr 2026 00:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 01 Apr 2026 23:17:05 +0200, Andreas Kemnade wrote:
> Add input current property to be able to work around issues created by
> automatic input limiting and have some control.
> Disabling the automatic management is another step.
> 
> 

Applied, thanks!

[1/1] power: supply: bd71828: add input current limit property
      commit: be353c6729d087925da702cf8c0ad3cb1ae53dec

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

