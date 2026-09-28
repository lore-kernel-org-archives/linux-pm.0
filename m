Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE040EB80
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615910; cv=none; b=DkvZEsNC1KaEIxoa1IS7MbHxTYNPBLlZPcP5KFIrcbyovwD8WY1tK2hKa8CGZmmkF1n0MZ38l7m6q7C15rB74st+rgucaLvbUMkPZspxBd1fZZpsL0V/ru+OEjVpfzC0eZ+qlHcvMVwBYXeaFwj3VNu5ru14M6805RbcZal34rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615910; c=relaxed/simple;
	bh=s/mTlAGn0bObuTqVrR8xDe8Fg6yt56YXK2In/CNgXbE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gcay7vZ+oijBC5zNaARkGqLD2JXP/eA0kN/qwA8chfYPFXBV51MxRzl+UgK9bSA1FKhxWI1V1KnegsXHixnly7DRran5rni5m2oj8I0Nh+Rg3w062vrzQ8LoiEogoCLvsrEWrHxnh9zBscbK/sbiFWUlw48NMsJ5vVFFu7uwMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=wTolbVbD; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="wTolbVbD"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so25170085e9.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790615906; x=1791220706; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/FtP8QfYvdqSZuTV1DgfaQnem0vOH6RafKPHcaYLj5g=;
        b=wTolbVbDtYhpCce6IK6o1dCqVffCVCP9blXXWdTzQSusspLs8slyjpb4aTwE2ncgHW
         S19mvCSEIC24BtYENhYqO+/CdCMxK81DqMA4z6d0I6Yrkd/mo/mn1+6ESjjg/ffh7YDy
         OE4OXIetK3M/CQXcNLLQCzY2CCDZK6bfrTR66sBsv2Kat6mOGeNHdm8saJADYP8074ci
         cRsX+2jVoXFe8TfOHZT48Jxmmim1OBYuM0fzsuHQTvKv7l2nPzmY4A+KjSvaPEO25Hwm
         TbmBo7rs98RB3wmoLlcRphX+i11DxCfDnHPuMtShVq2MkF6K24wkSEcGs6AWoCpvj4wK
         kNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615906; x=1791220706;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/FtP8QfYvdqSZuTV1DgfaQnem0vOH6RafKPHcaYLj5g=;
        b=j8TK4nRaGaBHU5bmDB/YSysJ3Mg+DJAaXqL82YiQPc7vb63Zo5R57EEDlcBZ0KZXR9
         p0W2DmG5C3ji6jVNTn4IPCe308sQRRenh3TjNqSMhtcJmjMOotmkCrAlfZTHIvjZhHjt
         K86B3HSJb+8wZO329UBiH0CUJyJNcraxaCEvij0iW9jwh4ca1Au2DG1fzc8Qy7l1soa2
         +GwXa0Qu83eQq5xwChjduNIHezQuz0SFrlpYbuoPfNsO84dMz8XUu1dOZJ4awrfvDEbk
         psD7WlQ0WnMVq1DQSdiSXBuoXvPds7hkD5GXdF+/5F7IEehkPBZQedpphw/9hWDCubTZ
         yvjw==
X-Forwarded-Encrypted: i=1; AKwUvBxZDwLNv7WQDWMUkcPmLDESTmkdqlF+byAcHfYI0O+oxTiy/X5CQ+aC7ETqIhNec0Kker+mF5x5wQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ng0EJtxyV/oSGwR7UHfP169CQvjpYqmADwPUJcdvrYLs/MZjsh
	Lk4j9C1NXRKTKceEQRZGifsECnQNK8aaXE+Jv/aFTImSeiry7CAT84csVzk4X1fOuC4=
X-Gm-Gg: AYBFou3lsmR6+4klnIXBpypnXc9AWCn2UZ+BAMCMvX6MWVDj34vWF4SyBWcV5z5LWNK
	ZUywhYMJSypslnqnZ6Zcb8a3XMEMhtgkTWrH0edRbftCiv0xuiRE681L80WoqUTubcsv7HWgIt4
	ffFsz9Stzv2i03ga4V9MniIHol5k6aIRGW96g/j5Y+fky53g2t2Xm0BoDEEFGxnn68nnMAJJT4y
	REwmuIksbway7ZeONK1UZa7iAwoimf6mF5ihyhNVsjHu+YYiVj96yzahSSpgBCiETZieYWo6xdG
	zYvCJZ+50O9klJJ91b0wzAs0D7v9oS9QsXyMf0LW7uaYLDEto5UWKc6mUguCUKBE4Qz6sm+C0+7
	pb1fOtNbm/ON4o/psF+TAx/JO/+8PQu85RVf8OAfzLfbWS4jqO/PrKQrdlDnS0bS0UnJjQxe1Ka
	GhlkmU9G96HZuE5gEJqwcT7j9MG6xgO/nw3+SU4QcCLg9c/JStw5Dltr//yxkbJAvd/VW/wKHKA
	wmELlh7DdkxXa9V
X-Received: by 2002:a05:600c:1d1c:b0:49f:bd3c:bc28 with SMTP id 5b1f17b1804b1-49fe6712809mr247163255e9.35.1790615905740;
        Mon, 28 Sep 2026 10:18:25 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84221bsm29224973f8f.36.2026.09.28.10.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:18:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/5] power: reset: syscon-reboot-mode: Add support for
 Rockchip RK3576 reboot modes
Date: Mon, 28 Sep 2026 21:18:15 +0400
Message-Id: <20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJbSuCVzEuKP3R0UjJFA0J4
 e5WXX6L91bKUEGmU7WS4i1Z0liw31XU37rxCpZYTNbY2rS24eBZH+5wrFkRUpr5mSI4usZ4uDY
 OxlNpJ8Ugy+97vvydX+GOfv7OaNs+19H5QHkAAAA=
X-Change-ID: 20260928-b4-rk3576-reboot-mode-d3804e39df04
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1836; i=alchark@flipper.net;
 h=from:subject:message-id; bh=s/mTlAGn0bObuTqVrR8xDe8Fg6yt56YXK2In/CNgXbE=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGq6oV6iNH/VmmFzlQ1hQhAYxvpamHsdpOIQq94PE4kcQtNIB
 IiRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmq6oV4bFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSlvdkA+wRRO3lgERV5W1lHYPI+DQvpFJPuu/7czqqt6XFZwTG
 PAQDw9MHAy9l+53NYrKPFyIz2M01jBJjFuVhK7mB7r8c2Bw==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Rockchip RK3576 supports reboots with a specified boot device priority
mode, allowing one to override the board-defined strapping config and the
OTP programmed priority setting.

Supporting it requires several changes though:
- The boot mode request needs to be forwarded via TF-A to the boot ROM
  (upstream since TF-A commit 2a97ba20e901 ("feat(rk3576): forward any
  boot ROM boot mode request on reset"))
- Some power supplies need to be kept active across the reboot to prevent
  early boot code from running into a synchronous abort
- The magic values for each of the supported boot modes need to be defined
  for the OS to use

This series enables the above with the RK3576 EVB1 board as the example
user. Other boards will likely need a close to identical change to make
use of this functionality, but need testing.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (5):
      dt-bindings: soc: rockchip: add boot ROM download boot mode
      dt-bindings: power: reset: syscon-reboot-mode: allow supplies
      power: reset: syscon-reboot-mode: enable supplies for the next stage
      arm64: dts: rockchip: add reboot-mode node to RK3576
      arm64: dts: rockchip: name the reboot mode supplies on RK3576 EVB1

 .../bindings/power/reset/syscon-reboot-mode.yaml   |  8 +++++
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   | 16 +++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 36 ++++++++++++++++++++
 drivers/power/reset/syscon-reboot-mode.c           | 39 ++++++++++++++++++++++
 include/dt-bindings/soc/rockchip,boot-mode.h       |  2 ++
 5 files changed, 101 insertions(+)
---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20260928-b4-rk3576-reboot-mode-d3804e39df04

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

