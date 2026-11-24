Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795542210;
	b=EUuyNcsI0H3ZRMZICSYGJ9VgbYS+l/xx2wbU3ytOW74T3C08kmqw5NdKlG4McMJ3PmQI
	 nJcn9RmoBqxc/JaxsE/aadFjIzaCr5XZYh60mIKUHVL4wKeC7xprwvt0ugPOiot33wQFk
	 Pw8TQC8NcbQiQKc3cBlDWOEaiO0lRQA9kyuWMLjiHuoRwf8thZ0vLWG3/V37LoN0Yb3Yt
	 7bUPhas45dQab1hUY++NzvNmvawJxQnVEvHV9rLqI10y28fwOQj8kN+sR4eVMg1fnXuMu
	 MQJm/DpI1UdXdcGsTfeynvzEwQlkh05tYYwdk77O1RNgCnh477eAlvuwOVSO/GuPWUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542210;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=g+3NK877aAArWS0EnyN/81ifPnW/cDWTAmqtDECLetk=;
	b=IllTL327LjcjTqVsY5tqgQRQufhtuWCN3MobMiCLt7uvdtHpCW3/IhYIHHkzCljFi1GB
	 LI9BKfWCQyIGjhPoKROrR10jSwJxajK2uStfrwzo2aXBu5lkxPSVLtDTGqbcqddW14ckV
	 UHfjrwo7Z+ZnaJwraNSDpoL+DYFzxaN1u3a7UtIZUQRuIk4oRQFRJmdrfCnIrfuLMy3NQ
	 GI+oCH/TU2q26TokTEJonbPnUcH5Stocn50bzw4k6UFnB+5KWNUFTBftUxyZgRxxHUvW1
	 QJOoWPL7EhzUSvPVph7X4XWaEk/22zfl0YtkY4NGHViUFISoIse29kansCFdRhYkCrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1DxyBS7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4C606A31E;
	Tue, 24 Nov 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1DxyBS7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795542210;
	b=goox8n71YSsHr90RCBEt77lyOlAPA1MrQPtw81t7rdUisKOqaOqNLE8ivSf9uVH5KSBN
	 EAM1yB6Me8gQnRAO7p5tktO/UdpZMKfanta0iShWjhgQS9l0GYlE9yLjnpPK4XvMCR9e4
	 1LR+dEiyl4ycJCmIog2MqRI1kKFyFZYrTlYzl4iCpCpghSt8VFQz2iJ5jQh0INlYmTFnI
	 dn25ugtf3VswpVHSTuwNZlpbz1xdn3czXh0WBcdcsc+rNU4Sq5P6kncE+SjGkilvkORVJ
	 biLapsTmjI3rzDxl+1iPNos2E8z2glLlNRiE3YusCvHt0St0E3hRk89W/AtkUWSVkUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795542210;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=g+3NK877aAArWS0EnyN/81ifPnW/cDWTAmqtDECLetk=;
	b=0ZCWDxBq/fX49IdCPlpoN96M8N0+rPPzAy8J8r4HoXiyDzAT8QMT/HhOtSMTBm87ZU5P
	 xjm1jf1hAqA9l5c5qrLZbRVxkJTDZG3bM67iU6CTYZX//G4+inNYC/Pzc/133SxHNeBxC
	 sj+qAFUl/nRv7K7C6A+G4OkQ35MYrbGjIXEWb73wXC5yCYJm46EGp2sqfDVPuACSnl+VD
	 Mf71SCMWIVF5u+dx/bHGYQvol4iRIUTuH4mJnEIandZYdGzV8QH7f7kYy+EOPFpl9TdL7
	 B5WnlpYcocJiXTQYBaCg19kvNHyrvwmhKLIhs6HEg6BsRgjx8t+iK0swXJV4VAYdMbw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 309811F01808;
	Tue, 24 Nov 2026 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542210;
	bh=g+3NK877aAArWS0EnyN/81ifPnW/cDWTAmqtDECLetk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=d1DxyBS7KsLmNB2cZXuIbUxr2tHjrVQW3x8WS2IIIDIuVp5udcR6nZkM984z2qPS7
	 BAv3s5V5rbn/nW6rUGWIrHSLNtYn0CLsT33JpmEvsRrPKrHJujiFSWTlh5XThD49Wc
	 PMA3QUE5krPLNkoxgnoXAf1ZfRpdiyXx6p9LjWezMDKL2XMd6h0Jp6Dco5vSrZa+zc
	 9jM+TnWA+nev49XvZ3dgtQLqORH3lF6pNzwc0/c2enlifv0VYJv8NLYKGfl3y+lUSM
	 QEbGzHavok4U8ldr/uGs33C1VJi7gfDoQlWO8k9wp5Q0jtUQea6es6yAHQvtks4zOo
	 Q8jvBeRDZoV8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B977E4CB13;
	Tue, 24 Nov 2026 17:43:20 +0000 (UTC)
From: Armandas Kvietkus via B4 Relay <devnull+armandas.kvietkus.proton.me@kernel.org>
Subject: [PATCH 0/2] Add Maxim DS28E16 battery cycle counter
Date: Tue, 24 Nov 2026 18:43:19 +0100
Message-Id: <20261124-ds28e16-v1-0-bed431df0578@proton.me>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMT3ZRiI4tUQzPdlORUgxRjC8NUQ6MUJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAEZkbdtrAAAA
X-Change-ID: 20261124-ds28e16-dce0d381e12d
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Armandas Kvietkus <armandas.kvietkus@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795542200; l=900;
 i=armandas.kvietkus@proton.me; h=from:subject:message-id;
 bh=rBhlGjEYg12dV0lDhTkpZrORnOq6vZZO6CMKjetk0D8=;
 b=uA7zolE9PS3KyALvplvduaDIe7FbFcploKcC0fsVH7/impjS8IqYkMYUtnlFzztS6Ml/mamDJ
 J9VXuaaQGeuAZyQGgBO0sS8RMCdlcOloWoGgg6tEv1+1x/KPhABRyky
X-Developer-Key: i=armandas.kvietkus@proton.me; a=ed25519;
 pk=wuqmImJ9sKlDVcwALOvfGhjj7G8EBjjM4TpCdmlrAf8=
X-Endpoint-Received: by B4 Relay for armandas.kvietkus@proton.me/default
 with auth_id=974
X-Original-From: Armandas Kvietkus <armandas.kvietkus@proton.me>
Reply-To: armandas.kvietkus@proton.me

The DS28E16 is a battery authenticator that keeps the cycle count of the
pack in a decrement counter. This adds a binding and a power supply
driver that reads the count and lets userspace step it by one.

---
Armandas Kvietkus (2):
      dt-bindings: power: supply: Add Maxim DS28E16
      power: supply: Add Maxim DS28E16 battery cycle counter driver

 .../bindings/power/supply/maxim,ds28e16.yaml       |  39 +++
 MAINTAINERS                                        |   7 +
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/ds28e16_battery.c             | 335 +++++++++++++++++++++
 5 files changed, 393 insertions(+)
---
base-commit: abbe0a96bdbadae9e29489a1528fa436c55aca25
change-id: 20261124-ds28e16-dce0d381e12d

Best regards,
--  
Armandas Kvietkus <armandas.kvietkus@proton.me>


