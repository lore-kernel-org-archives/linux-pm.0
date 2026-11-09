Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187381;
	b=Gyu0bXhzmtolQBYh7g3jnHraV9mCFX4FjG7oqX5EGkbpWY9m70YdqibgeWdM0qZt2rJN
	 12bvr4phz2MnKXfKsh3wwZfvT9CXbSYcCoixXYcpG6fAKRYJaDTIQ23/UPYiEsvPSpX4o
	 VhP20ZuzF9Xsypu6X/Wn0GRO/hwwb+XEhQtjuCIUykEe3Ev8in7ZtT0Q7SMSc6vJqghUX
	 SPFfh5tZuj2G29qM7FREtTSGL9zT1CBeLrypgq/OsJrjaAA0GzmdH2/yvHXV7J2PFpL7J
	 xxqOufFi/fEzccA6FgENvM368Zra+ivo4SauSvUUZu6SF7I1VNAdVGX71/1PsU81F0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187381;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=zUTznsOQNFhFrl3ORUaK4Hi1bs02g/3gwLsJjq54hTU=;
	b=vcLPByXdHVNTW2rGva2KrsgHnfvsOy8XZ7oiQwjSSY2ZG3tUsVjU7vhMT9SHm/hzH46P
	 YDZC8ogf1Fz5O0B446FaPORisuS46wy+zeGLc8IsLwr4jSc08uptRv+zBwFkNxTqZggUi
	 HJawkwvPcAA4SiB4QFbOIetb4dWZRWkBtDlT+3IOgUZfCNi0XQtXvyfm6hGaV5obDh2n1
	 g3CeB6SQD2SH6lV5LapUG8yWIzIfOWItSPk0f9NGRrXq7rml2pyvH7/sfNyx9m2hImJiA
	 mZPpDRNwdp0ZdYssITN3F2JcmfAkTaBpu1Om69iHPzaJBoCepNCPjnbc6N5MwGhI2zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102D608360C;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBF71F00A0A;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 0B78F1828F2; Mon, 09 Nov 2026 02:23:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Derek Ross <derekross@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, kernel@puri.sm, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261019143307.2109629-1-derekross@gmail.com>
References: <20261019143307.2109629-1-derekross@gmail.com>
Subject: Re: [PATCH] power: supply: max17042_battery: infer the status when
 no supplier is described
Message-Id: <179418738003.1255445.15692501249871604792.b4-ty@b4>
Date: Mon, 09 Nov 2026 02:23:00 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 19 Oct 2026 10:33:02 -0400, Derek Ross wrote:
> When no power supply is described as supplying the battery,
> power_supply_am_i_supplied() returns -ENODEV and the driver reports
> POWER_SUPPLY_STATUS_UNKNOWN, even though the gauge measures the battery
> current itself.
> 
> That is the case on the Pixel 7 Pro, where the charger is left running
> by the bootloader and no charger driver is bound yet. The battery read
> "Unknown" while taking in 1.2 A, so the desktop showed no charging
> indicator and upower treated the phone as discharging: at its critical
> percentage it put a charging phone to sleep.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17042_battery: infer the status when no supplier is described
      commit: c9797f02962f784d5920eacc4d6cad1369a8c20a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

