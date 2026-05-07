Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697A30171A;
	Thu,  7 May 2026 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158428; cv=none; b=RtTcKk6UrdwFiqW8eNlq7bRWvGBiHY/1qOjff4wRDHSIh1MvNga5a2OiH4Hd84wr8LDNCOzvjCwrmIdDjSBeWLBBBJfP0ntLsBEyzT6Kl1Tm8iEW6lzW4RukphHSNZahpO1BazdmMev5LRnB/zdf36WC3omv3E4lvZR47VM8fGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158428; c=relaxed/simple;
	bh=NDq1yRkDTD9n1Z9MRjKoR/KHoPrasWXZhi/Utqu0UcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HB9622b7HrJEwE5CiH974/O2x+aJ6cEuXAXu3EH5577VOZfL23q+DsUct9hvR9+bmNuWX0deLTBkBACPgfEYnYXhZ5nOSwWXAG8ka1tUp7NZyjQVE5ejclOXaK2YlXUII8V8tKv6MJ+kam+KKyAG5Q8/OyH1NbJuzK2ewaZLUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1jGAtff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1jGAtff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0272BC2BCB2;
	Thu,  7 May 2026 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158427;
	bh=NDq1yRkDTD9n1Z9MRjKoR/KHoPrasWXZhi/Utqu0UcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N1jGAtff4iiwWK8TKDqlW/GLbEyNu3o3HVgehLHfvadTuXxf0BrWwQYQlSTGU0kWc
	 NRSJH4ZQ9uNyjB5ig8ciNzDaG6IDvDP2IoCHLirfjtUhdGxA03Pwwj6F9mSmDUz5LV
	 +Ll2TquOmBdV1ZWPAFpUHRQ6158JRSd6XZ4VYB2vvsDzZnHCUimBCuFLIUad5x+BaT
	 nbN9iG1eXcXzbe8UKNtLfDju67QwMZ3r2a24adutuhe9CDmdlOYdx9TZJ6JQOT7Cbq
	 3H2ETgluYKH8BwEQW2QtaDyPMzqkMdnE6NZkWsA8omTUdQfmtZdnl6aIDq46kZWVZ6
	 nzmsj+38KEQYg==
From: Lee Jones <lee@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-1-447114a28f2d@aliel.fr>
References: <20260421-add-mcu-fan-khadas-vim4-v4-1-447114a28f2d@aliel.fr>
Subject: Re: (subset) [PATCH v4 1/8] dt-bindings: mfd: khadas: Add new
 compatible for Khadas VIM4 MCU
Message-Id: <177815842272.1844364.17432398965217021542.b4-ty@b4>
Date: Thu, 07 May 2026 13:53:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 21 Apr 2026 13:49:18 +0200, Ronald Claveau wrote:
> The Khadas VIM4 MCU register is slightly different
> from previous boards' MCU.
> This board also features a switchable power source for its fan.

Applied, thanks!

[1/8] dt-bindings: mfd: khadas: Add new compatible for Khadas VIM4 MCU
      commit: a10878e699567d88267200afdb165107567e0287

--
Lee Jones [李琼斯]

