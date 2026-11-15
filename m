Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784591;
	b=5cg/ESyqujm7D6WC4bn1Atp3Zt2Y5ys2Hk6U6E8rI30xl92ilIV5vkc8t+kYzaw79wNX
	 S97HQQqmoYUIQyIPoGcavFaeCjuVRFZZfT+eU24BU3wtJq1CPHiCa+iGrWvfAJARxhLLz
	 Qho9wIkFZmJuxRnYBtaeoyn/YrAOqu3GQtcPCJjcm2k2padjCDzqtLhgGPz0O0QuphpsL
	 vIOHWW5HkNdVhT1wZB6qJlfuFNgLPJsdG1Kktv0Q6wCF0zWlC6A3QKmUegVHU0mb8+8xo
	 ss3qBRIeoFhjzA6ynk9jwYcpmMWiRQIaAHBbmsD9ZfQZwf3uEomWaaTXd83TdF09SQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784591;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=imHcozHCLh6AKNXXM8E4mMDrsQh5WpTo5pwmbcPLs/w=;
	b=kdMZSR0BowwGCazohYRAFqFshDCZOF0d2Z2O/CN1LoXuK80ZqwB9eBfCK2EquKd0sdi7
	 ud5SLfOi339+BoGC+BJTfXQElEJMGU4GCBqmu7t1GvI8m0WmCgqQN7jyc6fvtHEFxAWc6
	 LNPu5S20VMh+POhuMjHixuW+JHN7XC5KJajcP96jJehNf6zdzSzEGviyySUsHUS63HtjI
	 spil7Gdq3yDR5ICh3NloxLN5jRAkq+QHm7H6S7rW7Kh7vFc+Zfb1ZkmdqZrLMj9ZeSIFR
	 zMM7YffTktf8cp78tztx3/Xgpp7Y9z7zMehC6/eQigInC8oPnC9qHRA9Q4M1OpJWK3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6A606A335;
	Sun, 15 Nov 2026 23:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AC11F000D0;
	Sun, 15 Nov 2026 23:16:30 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id AA944181BFE; Mon, 16 Nov 2026 00:16:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, 
 Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Cc: pali@kernel.org, sre@kernel.org, afd@ti.com, 
 konrad.dybcio@oss.qualcomm.com, david@ixit.cz, krzk@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261019-master-v8-0-2517e41c8992@gmail.com>
References: <20261019-master-v8-0-2517e41c8992@gmail.com>
Subject: Re: [PATCH v8] bq27xxx: support interchangeable OnePlus 6/6T fuel
 gauges
Message-Id: <179478458768.205616.13290099651767302689.b4-ty@b4>
Date: Mon, 16 Nov 2026 00:16:27 +0100
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


On Mon, 19 Oct 2026 22:08:15 +0300, Rinat Muhamedgaliev wrote:
> OnePlus 6 and 6T battery packs can contain either a bq27411 or a bq27541
> fuel gauge. The two chips require different register maps.
> 
> The DeviceType check now lives in the bus-neutral battery core, where it
> uses the existing register-map and control-register helpers. For bq27411
> and bq27541, it compares the type selected by the compatible with the
> reported type and chooses the detected profile.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: detect bq27541 behind bq27411 compatible
      commit: 15687e5a48e746ea8de2952e04f04b358866376b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

