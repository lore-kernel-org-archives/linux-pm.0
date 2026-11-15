Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784589;
	b=iBrlIUl5KFdcjPkJwpEP3NecmXCwfdvu2CytOrU4Jo7wiXFOxc7K+NwEmjI/qi55NekY
	 tqaN+xMF9UZn17RAW9yrGuPQWiPKR0KT7AhucaZtoPKBUrP/wCRTxv5ZQpmN3Q3Xz5qIw
	 fb42LDvI8X4PMKyjDupc67vSIU4GiMnq3JdoVo7L5NnHkqKm8RNQFBtHXhBRtWOPYZUum
	 mufS753BhX2tqdQf4ZdlvqyEc7yn2A8octea/NTzpDMbHe0IRQzpvb2L4bwmUKkbLjeNN
	 IEPK4TyfN3Ot6ChpOpahkb24RqCeczSlSFsrvJS/ZBqOTEnISfAbz8kEhMqqUiiZ8/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784589;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=S3Xso8zlI7c2NHL+WSU7oDqDR5O6Kd9MbbzxJKnFqnM=;
	b=GRrYdcIO2xe8WRzfEjkBXPxQjoPAs8hGtDks1eOUj5VYB79OEHhtHaSmfIi65Ydydd3a
	 iep8OXShxHqNEqKiM2Tk11lrK+srO4YaDU4w446uJEcGRiBX5+XZ++2KWGnYEbPENAXZx
	 cg6ErMiuCB1+04UAba/1VS4D+yEAd2JRnDn6KLeuAWg+A0kn8WplUvIO4vTG/KKLbluIS
	 oVYRZnd1oB+HXQmVJ27quJ65e0YFCJbvU7KXxlF5JAIZMBQVpT7HlLExGOeHpWwgLCORt
	 CU+OC7tIn5s9mGHzQN9OWl2G3NoZYxq6qmxxE6NHZxHmEbt2q1VKJ2F9oc8UiI74bpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98709606A32F;
	Sun, 15 Nov 2026 23:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1634A1F000C9;
	Sun, 15 Nov 2026 23:16:29 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 85EB4181BFA; Mon, 16 Nov 2026 00:16:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <d94273dbcb55dfed01f75a02e9d0f28aea390ddb.1794579149.git.waqar.hameed@axis.com>
References: <d94273dbcb55dfed01f75a02e9d0f28aea390ddb.1794579149.git.waqar.hameed@axis.com>
Subject: Re: [PATCH] MAINTAINERS: Add TI BQ25630 battery charger driver
Message-Id: <179478458753.205616.11895816508966502913.b4-ty@b4>
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


On Fri, 13 Nov 2026 18:06:10 +0100, Waqar Hameed wrote:
> Axis Communications has resources dedicated to maintain, test and review
> this driver. Thus, add myself and the company kernel mailing list to
> help out with this.

Applied, thanks!

[1/1] MAINTAINERS: Add TI BQ25630 battery charger driver
      commit: 622c8eff338c2d9b084b38956ec7bc8124c84e67

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

