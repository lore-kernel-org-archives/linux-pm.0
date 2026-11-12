Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470480;
	b=WMbIrO9F/s3XbG1mKa85gHkMpMrzT4CVPNzaNAc+IwES7syv8owxH5sNVr+sLFKhrSR9
	 t5z6+eoYBMYqn7TKFdSzkm1M8zPaEjSVrD513N8f1zzku8tIs3tqyruigN2wXhamG4y/u
	 K2et6XHrgQwZ42jzFi1XKwzMLG7D3+e+iurmtCofLpqf0WotNCTLvajtVkINw1wrjVJA/
	 jGuxfn4VtFWo2ZA2xjxHdJhpJNB3jw45noPTPXhYq83dBgbcxT7DkSG5qR7j7tG2dAMts
	 ax2BOgzL3RFKJMZGApVFYVldoJe3LURz7I9jyqfG368K/MsCGZR8JfRvkxlZ88lR6Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470480;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Qah46fhbDwH4cpNdD/q4W0jvLXp6V+k5euCRpR0v8cQ=;
	b=P5P50ktRDTg98RJ2hH6bnhHOeDR+EdUM7grrmLuzXnwwFCxcKVwo5zA252ofDR2aJI7f
	 lUJyaQzEye55Mf7u/mcXghE1MLL8INhsDJfYa1WwwB/UWuOIklGTJefGR8G+hPzgmqogO
	 qaPX68CGOYbjr9LAfwqpUUnq7l5FJYIOZ9DgCo9p1MZRCk0DvpuCFDIwvfFno+SXVKWca
	 GmNlRJ+mf1/+4aicOOO3wjwSNsrhhe+OmzaA6n8iVQr2fwKoR61DvH9k9efzlZoSHXAHm
	 hK38AdD095j+5VeUvirJoDr4wGi1J9Wx97RRMDHsYxYfIDby2ON1mhBn8NVdPiPemJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kY4tAs2h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B103606A327;
	Thu, 12 Nov 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kY4tAs2h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064A21F00A05;
	Thu, 12 Nov 2026 08:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470479;
	bh=Qah46fhbDwH4cpNdD/q4W0jvLXp6V+k5euCRpR0v8cQ=;
	h=From:Subject:Date:To:Cc;
	b=kY4tAs2hd0U6lOA0K8IxC/LsYPMVBRXQdyyNxYL2lQ+IMtploA/s78BLdTUm4XGVc
	 P93leJr28v0vw8jCBQJr4m96iVAlKdi285/i6ynntfAMhaIfOOlIMgerEEPwpbCzkU
	 s0VkrfM2epQJKpgkUp/apOAqtAfCKGBcWOEJWWrD+vcQfmWmZSIQ8P/P+JdVyIu+CT
	 hq2GNG0PRDXKoonqL0CETcItplnpX8A35E2nydcm6Rw/9bi36Qsd5a1ICv9wjHH5o2
	 ICI0zNWQOxOn4GzrJewhiMuaCNkTgZwGWRoYDJ+uY3gw7Nk+nJVIGMKuQnzpJAOYeK
	 Ew/CooQyOUDLw==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v4 0/2] PM: spacemit: Add power domain support
Date: Thu, 12 Nov 2026 08:00:55 +0000
Message-Id: <20261112-04-k3-pm-support-v4-0-de3931aa5153@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQ6CMBCF4auQrq0ZW6DgynsYF5QOUFHatNBoC
 HeX4sIYXf7Jm29m4tFp9OSYzMRh0F6bYY10l5C6q4YWqVZrEwYshxJKCintObV36idrjRspSGx
 SwEI0SpD1zDps9GMjz5d3+0lesR6jExed9qNxz+1nYHG38QeA4pcPjALNGyGKKuNKMXXq0Q142
 xvXkugH/hEOfwW+CrJUNRSZAF7KL2FZlhcKPlMQBQEAAA==
X-Change-ID: 20260909-04-k3-pm-support-0bef40e87fd7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2695; i=dlan@kernel.org;
 h=from:subject:message-id; bh=zFye6M5NKotuxjgyr7IlnWx2Qi3038u/MfWOQTdTsqc=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq9XJCxCuotHkY4p603gXwIV4JIq12y3AQjVnMJ
 wgkSYGeqYCJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavVyQhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+331g//fzYjoLn5jn9BCg0jlpTOwJVQxJNuLwP5X+R1xTRhqECd0O0isRPzS
 zk0pLateXp54ZEEy28ZTQqlWe0Epu14zqrcjoxG5oNudXYZ6QpYmazkMiqCwI37Vn2haHTgTeu9
 suv2GuyAs35I9Fi76MV6xGcbi2Bmlh3BdnnevOlQd3BdU64cbSErUxKKYKuuxwRS90msnHNUzC5
 SGaTKA2+mhSsURroHhDzQcMFHs0kK9LjxWnSs1N8AtKwjyuMizRDNZLrm6S3UWVZq2N1HAjppoG
 glVnZbhzXOO6xoAVkA2+pJurCRFoRjBBo/4QLcXMeDW/7DFyQUltT588GYyQynLfjdHjHzJAaAF
 idYwSTs/XaZXtR2AdWfSFWdd9mp9nqEC1VbPGDKJ3H75lqfFe2VoGnSkjHVXSZ1rFx5zxAr/xZM
 2aD/rbaGDT6kqfoheaHvrOrhI+x4qXZnzt+UV2omg4yHaQ6laG3BqiRZublWM9DWbdLOLdPUj5P
 8thC9oo+JFpNywErtgf3iRmCUpSOGOl7GF5USSH39KYuafsaeaOipY/xPVszWjAFOiTy3ggK7TL
 A6ckdcMt7GHG0wTAQixwZFi/oZEdFhT0JGLifBTPansSkCh5TkmZDPVkZGPxrIL2MJWUhbDUcgT
 Nl72x8/ql/zaOVku5IJ51Owz0QPYi8=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

In this series, we try to add a Power Domain driver support for SpacemiT
K1/K3 SoCs, the driver implement the power-switch functionaly which support
power on/off, and it's based on Linux Generic PM Domain framework and
similiar to vendor K1's implementation, but unlike the K3's vendor
version which is more complicated.

  The DT documentation for Power Domain already exist in below file,
and APMU already has #power-domain-cells property.
Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml

  The previous DTS patch is obsolete, so I dropped it. For devices required
PM feature, it need to add a "power-domains" property, and should send in
a separate patch.

  In order to test this series, a prerequisite CCU patches are needed,
which can be found here [1].

Link: https://lore.kernel.org/spacemit/20261008-04-k3-clk-pm-aux-v1-0-8372d7307694@kernel.org/ [1]
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v4:
- adjust Kconfig help message
- drop unused include header 
- propagate regmap_read_x() error code
- simplify spacemit_pm_is_off_state()
- Link to v3: https://patch.msgid.link/20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org

Changes in v3:
- collect tags
- rename spacemit_pm_is_off_state()
- implement a remove() function
- use proper type in struct spacemit_pm_domain_param
- refactor struct spacemit_pmu
- Link to v2: https://patch.msgid.link/20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org

Changes in v2:
- convert to auxilary driver
- no need dt-binding doc, drop it
- drop dts patch
- support to build as module
- set always on for K3 audio pm 
- no global variable for struct spacemit_pmu
- no force to do power-off in spacemit_pd_power_on()
- check return value of pm_genpd_init()
- adjust license header format
- Link to v1: https://patch.msgid.link/20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org

---
Yixun Lan (2):
      dt-bindings: power: spacemit: Add power domain controller IDs
      pmdomain: spacemit: Add power domain driver

 drivers/pmdomain/Kconfig                        |   1 +
 drivers/pmdomain/Makefile                       |   1 +
 drivers/pmdomain/spacemit/Kconfig               |  21 ++
 drivers/pmdomain/spacemit/Makefile              |   1 +
 drivers/pmdomain/spacemit/spacemit-pm-domains.c | 424 ++++++++++++++++++++++++
 include/dt-bindings/power/spacemit,k1-power.h   |  14 +
 include/dt-bindings/power/spacemit,k3-power.h   |  12 +
 7 files changed, 474 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260909-04-k3-pm-support-0bef40e87fd7

Best regards,
--  
Yixun Lan <dlan@kernel.org>

