Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795261479;
	b=zGkZguCDcBtOIbo1GtjG5O3RHj5tgQNtFFRhq7lKqLVDGVFjQzcdOhzXee7H7dbrN+d9
	 RAC3MHR+NYjvOHSmFzOkelgwlVSb5neC3dfJHRw73kC3CIxXwCclTRL6n3HNch0jzuPrR
	 8KMAuLGOyyx9PVK/OtbKeMvA3VwzlppU1uPKN1BgryZyI9Cktr88imTOS8DnXKxlprTKl
	 V19WibZQmb5ES+cN4PefL2q1toPcuPM2nPF8i6JgV9GRDFR3myhxz4IC8cZ8wwbA02ALi
	 9QYXziM+YEFcG1smli+43sD6WssvYZJNkD20xuoBvU3jUa0fJX+VUd1y7Z9XTjY8pbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261479;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=b1A7CQxVGCFXC/DgIuwJEaO3717R9dNjpDHXvR+r1SA=;
	b=yzKXo00XGHPvI6bu1+zdyP9nDTbAO1sxEB12hg99xMy7GH1lNnCycoeyV9HjZtJcXCRJ
	 7f1J4p/bKTDPJ67mX5lmhg3yp1MVYozTf8dlas23rRzwE0bjHMcyJm2mYe/TY42HSWWn4
	 C/RgVH+PYxAxFLv5t/gsyUwKZ4VCbUARXasdVVAY3CGHVTL1hJl6lKMaJh2VpePzX8lgs
	 idmGLfDhHzBhIq4lBMNlWbaRqzDEbrPdzIfOL3ojacUqBMSEvdgOGk/2+0Nd9wN83hJW/
	 l3TackEFQB02mc3pBmv+j4w+QrbOyjwm5nFpLXuRstKvYjhx4ZP+9AoopRjwMFa45Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgztXGew;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47A606A32A;
	Sat, 21 Nov 2026 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgztXGew
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795261479;
	b=aJAdokKFQlAu2wJaU7vg6X7Nc+1tWg/7odlT/zOOnRsItROcMG7z74M23pMRP3MCRQwE
	 QdS21/K9n4U/96uFZlWsvXKYKHSxG3GrFkA2s4w9fHc3GCcRhdwtpuSA65YOgezs9TW34
	 ZUdAmXo8VLobAGxRk0czx7aivUNRyeqjAud6onWcRsM8l7MfgZ8b8xI1FF6454haUoNQI
	 qgtf8UGeNp5dw6MynJUJ4W+6N4ArxrhRQRV99/kFsDA5hbq2KVUQW8bCLEf3dtyLHC3bB
	 rwYnwj/9VmG5l7GXKR3zCEO5pZE7THmFD24/1VdfzhOltS1d83JIj3Dqy1L+y3njBeg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795261479;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=b1A7CQxVGCFXC/DgIuwJEaO3717R9dNjpDHXvR+r1SA=;
	b=A+X2O5V4OmrJyEPIN2X7A21XQDHr0xPnh+g7KPh9dPx0tCR0/vzY8Cd6VtTqCrfw7sAC
	 c464F3I+aFwFGT4+H3SUcsT1KEpFnaT+r3I8U6vbEBKwrB7YDNkIzyxHixltpr06zRci5
	 srJ9cTvv5DFBTN0zXpDSxjIdzpjQSM+D2nhOqBl0DrC9Oqzvk81ky4q3LoBZbw2Z9a9RV
	 NxiwysluAV9uNN0mHfgJgrWS6bH2N5ei2BxDDFcVCozhU4WK1+Iy2vZjDaSTX13U3Rgck
	 uN+9u0BaBroCaFcl2G3XHUbkz+rct82sszbEgOeYsCnt75+tcHx0/1rwf7tO4gOZesg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 23E6E1F000C6;
	Sat, 21 Nov 2026 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795261478;
	bh=b1A7CQxVGCFXC/DgIuwJEaO3717R9dNjpDHXvR+r1SA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=NgztXGewUOHcHS2gXBsa/In+u0drlrQALG/NAbCydGu6MEQWDfTnjvjWwgjxbfKsd
	 c87BATqaKxUurwtDTfoymAFdeZovzg68qjIH5gkJCUJjcHVNXKBlDMCB5N/QMUItMN
	 7mClcO+8v+RdGNSTlpE7RQLisjdJ5zAlDcXRK0SHHDeHmq3Afin4SHh25qMuXtEN/S
	 ydgLmOmA6las+v4Y6sAG1iSe67dXBCOwq5Gr7oXeCECOgbr36fw13Vxtr5L6PwYsfu
	 0EOlwQJf5V51EgkeGrsiT3rAZUchMatND2MA6az+r/2ryNbyyjwNTlnH7wEoL8GFtN
	 qI3EvSi69fX0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6CFFA4BC14;
	Sat, 21 Nov 2026 11:44:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Subject: [PATCH 0/4] arm64: dts: apple: Add CPU frequency scaling and OPPs
 for M3 family
Date: Sat, 21 Nov 2026 11:42:45 +0000
Message-Id: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE1iKvF3FbGgBiNBtYhE3F2x/
 BbvXeDYCjsoggssH+JkmT0oDEAP9dwzSusNKlIJkSKcYtRm7yyvuBiDnLR5XGcpadWAj4zlTs5
 vWFa/3d6MrLf3Avf9AEyN2ORyAAAA
X-Change-ID: 20261121-m3-cpufreq-opp-e6d93a871c2b
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>, 
 Yureka Lilian <yureka@cyberchaos.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795261476; l=1447;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=Z4dkI5W8ztcVVMZtoORCNmVF+rOWhXkyUMdCS0a0i44=;
 b=t80PuFuDSmNmGuacvmqav0HLdW2brvX/rTQ/9inPNlLwQ+4JX35v137vUTAnctOTUad6XDxos
 +BOIFd5rjeIBFeAKeG33k90EUkLBj13Cbnf5EYbobgOsD0LHfGTZRdC
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

Hi folks,

This series adds CPU frequency scaling support, operating performance
point tables, and asymmetric CPU capacity values for the following 
Apple M3 family SoCs:

- T8122 (M3)
- T6030 (M3 Pro)
- T6031 / T6034 (M3 Max)

On T6032 (M3 Ultra), the cores on the first die inherit this support
from M3 Max, however those on the second are not supported yet.

This series is based on apple-soc/dt-7.5.

Thanks,
Michael

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
Janne Grunau (2):
      arm64: dts: apple: t8122: Add CPU frequency scaling and OPPs
      arm64: dts: apple: t6030: Add CPU frequency scaling and OPPs

Michael Reeves (1):
      dt-bindings: cpufreq: apple,cluster-cpufreq: Add M3 family compatibles

Yureka Lilian (1):
      arm64: dts: apple: t6031: Add CPU frequency scaling and OPPs

 .../bindings/cpufreq/apple,cluster-cpufreq.yaml    |   6 +-
 arch/arm64/boot/dts/apple/t6030.dtsi               | 228 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-base.dtsi          | 213 +++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031-dieX.dtsi          |  21 ++
 arch/arm64/boot/dts/apple/t8122.dtsi               | 210 +++++++++++++++++++
 5 files changed, 677 insertions(+), 1 deletion(-)
---
base-commit: 477f3d0f46b0d885f162a64d13ca51e2f7afa542
change-id: 20261121-m3-cpufreq-opp-e6d93a871c2b

Best regards,
--  
Michael Reeves <michael.reeves077@gmail.com>


