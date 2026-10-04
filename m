Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFC3EC814;
	Sun,  4 Oct 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136025; cv=none; b=QDtJkAwTk2xZ+NFGKNOhJOw5H0V5rJaiovTQXd2rQffmD/MqcTtRaDBwdv4xPnsl/ZdxIcF6UJSfZ3N8CV1CEQVBg2MkyyTqRJnKMa8O9BIVH/rOREku+slFUYVdPzMYDip/f2eMKoAOFwVQM40wR+fxa+bkvW2f0UoHLrVxok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136025; c=relaxed/simple;
	bh=NPz6T0XrgKZ1YQBpKF7046z1vITweJjvjOYjdgMdcmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IaDhe5Ebj0gsRn3sWx1FVKFEh93QafudJnFY5ZDXZXXqgcHwt+9zS4UNjGDvHpxlI7riAlEJAI7qGAC7fD65VkDN72+k6n3V/BwKuKybz6c1UC7/iJtMBLbn8mWLIHjb8a/+wi0MbXJBti91RF5kFusBgOyzpzjJ/1yiJxvC0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5F21F000FF;
	Sun,  4 Oct 2026 17:47:03 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 43080180A51; Sun, 04 Oct 2026 19:47:02 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260926142905.206215-2-clamor95@gmail.com>
References: <20260926142905.206215-2-clamor95@gmail.com>
Subject: Re: [PATCH v1 1/1] power: supply: generic-adc-battery: Fix
 temperature IIO channel conversion
Message-Id: <179113602226.190911.11177787317110334945.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:47:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sat, 26 Sep 2026 17:29:05 +0300, Svyatoslav Ryhel wrote:
> Temperature IIO channel data is provided in milli-degrees, while
> POWER_SUPPLY_PROP_TEMP is expected to be in deci-degrees. Adjust the
> existing logic to reflect this conversion properly.

Applied, thanks!

[1/1] power: supply: generic-adc-battery: Fix temperature IIO channel conversion
      commit: 6bca94e64255053ab2aa56f2588fda73d399b790

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

