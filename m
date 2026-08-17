Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0E3EDE72
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959809; cv=none; b=F8v42C3zVgsOZpxx0f0Xe4gduPayzE3T8Vtuutzpx36sY+MH/uV6kYTJ7oI7OYYe/Qkejwps4ZpQEqHoDvYOcmodK3CQcz9g0Mij09oTr8I3r9Xbykyg4L+itHbGKJ2T1r6S/BGQIAjMSGSmN987LzlqcQNdD5NfaZ8T9txyP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959809; c=relaxed/simple;
	bh=AYV2llpwHVx2jpCfwLLNfUkWZvtKPwZ698vf4LkmWB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8lJK1q4YomUhE67VR5Pkg9N2ZSZrdzcCpI3ep/1BK9N0S0cHi5ApW+KHR96DzBmjMdZ3ItFB0XMIbAL78nWnnoGcz3KpPci47VOdcug6/EslgUhZWey1Cva89sMsEnKdo9TNVvUAprVeQJnnIextmrtJZv5NxHVJOEAfOOqI7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIfuvWJ6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIfuvWJ6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4995df974b3so1486735e9.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786959803; x=1787564603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iJxT22zdZziRjbZwbed7OeV6jhdxmd27WO3H1gy/w60=;
        b=DIfuvWJ6zju3wW7Z8XHRffCrOWx1bsQYELMvpXppqd/DlTKlsixHXVgN1IhAuZwXYW
         LHi+b/S0cFHiFf+ohSTr0Z3ZbrRHOPTqerI0TF1XEMfqzBm9r73uyMScTf30pEH6CiPR
         nvMmeFJA9J2z7QePUo3acg7Q7Eo3J0N6Lv+l8Mzy6rhPod+UYw5NYecS1KBHaIMtQtqM
         xabOnPKtTpb61tkZye6EAwh9norucdtBU5zto91it3qtpmZV8sBHy/7MicVLiIhkRt4c
         J+aWbKZ6EkhdBcCQ1XSPanAMjCIGFvjR0nWuJw1lT+CIDip3woidjAWdNvMyEPNK2Em7
         wsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786959803; x=1787564603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iJxT22zdZziRjbZwbed7OeV6jhdxmd27WO3H1gy/w60=;
        b=lVJe6qMNUgn1p4j1TBzMHTfN5xKdKAXt/j4WX5xokmUIHLa1tf9ryz6A3mcqq5Ye3Y
         +EyNXLgzWEd0OTycunUA06b6Q9Gtss+MPSON1OofuedOIMonuUmQHTWDkvCUNW61PKC5
         b71xr8ZEPWHG4fDVIuMr1DUKClCgmNDysOd/auxWal0RyL+h/XTXQFSU6yUcC1EMl2Mg
         TeKzkzlUC7POvAvcymq6F7n40mjzYT5KfL9+XhLOwfFGdpDWTV2JUavVHtyvPYmtOqgm
         3JuNTuNbGS3uXVbwnFLX+31oggiMD6ti3kN41konsb/K3rg3TjRHhi21awnjU0kyzfO3
         qWvQ==
X-Forwarded-Encrypted: i=1; AHgh+RphFpHPS0rX06UrvrA3O6T5l7SZdeCj2L0ze+mlsYV4o3kEVMlYx/jc3cua/BEJr3AbUM6cFUGnwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZfGoPdW8VpDnNPiYhdv+tH1B+H+aTVkyu7qZFNZ2QCwSbV9K
	dPwGuDVO1+XFtYGnmoNfACvkFdZnRMmY7Vv2YMx+SWT78ArLbOncNthp
X-Gm-Gg: AR+sD11lvPTlrdiXQn/LlbM0QN9y7eAwSj5RH9+CSYkWvO2/LDSpNTW08N6QWQJ0Ntp
	/CJ3TUmnotI9lo2tpUMIrvZPMVYVdCM4x9BUGILS8L9dllfv5Y1eiANehgowZY/b96XSnptQmrm
	AfDIfhNjedGs3Poap5PN4ionZYbpMhS/+KDwG+nq0yAkpsD4/Z39pghX/TpbzegmZImaUcnBQUn
	/TKl1Y63qcwH0eDfwYGhYwhQlD3O3jqgy92QP+2Z75aknSn5115SauCSbNlhuStOPtpBh3JvFJE
	MaDkKjnan9GNTPbxjHrY/gn864r/rJ08ld8RC5MMLCpKIEaQI4cZGZAlDdyaVgIO4mJBBbAdK0D
	XSMDlTgrfSd64r7I+CqYJKxx9dtwDKisxC7zYZFJCcnQ28HrOrQ0G8Cwe8CqgdIdC3F7fBH+Uyr
	Ng/B27cEVTOGxbR5i1MHtdOmnSfPlNW69xL22A+Zc0hDbi6qQFSnv8zgij+2q98YFLgp74Ae3hv
	9+J1NqKMFVx1TvOJdTUq17UJvHtWu1UKNzSSpL3ew6ouebdl1Q1Aw8WYLNiLBzIs+vhzw==
X-Received: by 2002:a05:600c:8714:b0:498:8e6:d463 with SMTP id 5b1f17b1804b1-4998792fee6mr180593925e9.1.1786959802911;
        Mon, 17 Aug 2026 02:43:22 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B8FC50027494B64639367E4.dsl.pool.telekom.hu. [2001:4c4e:1b8f:c500:2749:4b64:6393:67e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b783basm2546509f8f.30.2026.08.17.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:43:22 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Muhammed Subair <msubair@hotmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Alexey Charkov <alchark@flipper.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: RK3576: rockchip-pm-domain fw_devlink device-link failures for nested power-domain nodes
Date: Mon, 17 Aug 2026 11:42:53 +0200
Message-ID: <20260817094258.23332-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DU0P190MB244579F0C395F1F41CA729A8BCDC2@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
References: <DU0P190MB244579F0C395F1F41CA729A8BCDC2@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Subair,

Your diagnosis is right, and the answer to your first question is: this
is not RK3576 missing anything. RK3588 does the same thing.

From my Orange Pi 5 Plus on mainline 7.2.0-rc7, one line per boot:

  [    2.215019] rockchip-pm-domain fd8d8000.power-management:power-controller:
      Failed to create device link (0x180) with supplier spi2.0 for
      /power-management@fd8d8000/power-controller/power-domain@12

Same driver, same 0x180, same nested-child path, different SoC. And the
trigger on my board is a different property than yours: power-domain@12
and power-domain@8 here carry `domain-supply`, so the supplier resolves
to the SPI-attached PMIC regulator rather than to `soc` via `clocks`.
Two different properties on two different SoCs producing the same
message is a fairly strong sign the cause is structural rather than a
per-SoC DT omission. So I would drop your option 1.

On the flags, for whoever picks this up: 0x180 is
DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_INFERRED, i.e.
FW_DEVLINK_FLAGS_PERMISSIVE in drivers/base/core.c, and that value is
taken on the branch where the fwnode declaring the dependency is not the
device's own fwnode:

	if (con->fwnode == link->consumer)
		flags = fw_devlink_get_flags(link->flags);
	else
		flags = FW_DEVLINK_FLAGS_PERMISSIVE;

which is exactly the nested-child case you describe. Worth noting that
DL_FLAG_CYCLE is a separate bit, so a cycle-tagged link would print
0x380.

More usefully: this has already been explained on-list. Sebastian
Reichel answered the same message class for RK3588 on 12 June 2026,
replying to Diederik de Haas's reports on nanopc-t6-lts, nanopc-t6-plus
and Rock 5B (identical 0x180, power-domain@8 and @12, suppliers 2-0042
and spi2.0):

  https://lore.kernel.org/all/aixze8zFboY3huSf@venus/

His explanation is a cyclic dependency arising because all domains are
provided by a single power-controller device: to probe the regulator you
need the bus controller, which needs its power domain, which needs the
power-controller, which needs the regulator. I would read that message
before going further, and I would not treat this as cosmetic. He is
explicit that it is "neither super bad, nor completely harmless",
because the kernel ends up missing dependency information and pays for
it in extra -EPROBE_DEFER rounds. He also says fixing it properly needs
substantial restructuring of the Rockchip power-controller driver, which
is a rather bigger answer than any of your three options.

One last thing, and I mean it helpfully: I think you have mailed the
wrong people. Your To: list is get_maintainer.pl output for
drivers/gpu/drm/rockchip, which is why five DRM maintainers were on a
power-domain question while the people who own it were not. For the
subsystems you are actually asking about:

  drivers/pmdomain/rockchip/  ->  Ulf Hansson, linux-pm@vger.kernel.org
  drivers/of/ (fw_devlink)    ->  Saravana Kannan,
                                  devicetree@vger.kernel.org

I have added linux-pm and Ulf here, and dropped the DRM maintainers and
dri-devel since the topic is not DRM. If you follow up, consider adding
Saravana and devicetree as well, and run scripts/get_maintainer.pl
against the files you are asking about rather than reusing a recipient
list from another thread. That is most likely why this went five days
without an answer.

Regards,
Igor
