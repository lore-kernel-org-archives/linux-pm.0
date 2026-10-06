Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EF3B3C12;
	Tue,  6 Oct 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301543; cv=none; b=NZZ/hbCLRN+JQbdDKYLVGSxU8yHgyoBxLZZtKrsdzRbaqMShqKUIaK2FjAx/3LW5erlOFDH29QAJybAwnsAv04+xmQQOKtHVCdSRgrXOtcJlolK6HkhklH6owLZMPksgX5U2j7EIXxqM/8ARrCWrM3QcmShHyY5nk2lqMN7nkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301543; c=relaxed/simple;
	bh=PrlNmfCQUKdw9Wauj0oVzcv3V3RY/rPLLhINapCPhrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/mTOv50WIHSWFQXiLy0fi3mQdZoKj9iuVovxT02DJxytQ8gWAeN49fQC8BmLD/sUKHEVRWYO9ZHAvQ/2VgxObBmSY2u6KhA5zlH9Eu27w33u0GIFw/zUqZfpfEMsBumUbZpOOy2evqGk1om3KPRio1Qm6vJRo7HI/kowTXQ5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=hhgQr4aX; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="hhgQr4aX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1791301536;
	bh=PrlNmfCQUKdw9Wauj0oVzcv3V3RY/rPLLhINapCPhrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhgQr4aXTjU5C3Pgz8R8dkCcXQvgbtmG21IKGtZmnv22kclziwaQ4UZvrjqbvjPs5
	 oUfCN2AItlaKdkDbWcvE9ZXpjviLt7pd6KwXpWQZahhBtDU1dWFfv8+txExSRUoEfJ
	 o8BeP4OE0mGKmlTKUbIa9rzOfTMbETH8r691jbIaaN6P3m44WnnV5Tio6iZuVRhZ21
	 WgUMq2NTbvdHtldl37I6Ka5QuR13GZpl8n5sdG/Dhl2378Aejw+fr/c2ESBToh6zR0
	 XhmVPWVWxY6nIEzPYX++qzgxJNNWwJ1fgrK7WwTgtXlrCQE47l3FEQG5NRr9iVCA+x
	 auiOCixFlorjQ==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 1C53826C86;
	Tue,  6 Oct 2026 18:45:36 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 18:45:14 +0300 (MSK)
Received: from rbta-msk-lt-169874.astralinux.ru (unknown [10.198.62.171])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4hzgZ21R62zDZD;
	Tue, 06 Oct 2026 18:45:14 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: Elazar Leibovich <elazarl@gmail.com>
Cc: Sivan Zohar-Kotzer <sivany32@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] powercap: dtpm: Fix out-of-bounds read in the set_pd_power_limit() callbacks
Date: Tue,  6 Oct 2026 18:43:59 +0300
Message-Id: <20261006154359.132119-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260612062536.9147-1-elazarl@gmail.com>
References: <20260612062536.9147-1-elazarl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/06 15:19:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127 0884f7b061fa529b810563f359267cd65d2ec05c, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206479 [Oct 06 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/10/06 15:00:00 #28658794
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/06 15:19:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Hi,

On Fri, Jun 12, 2026 at 09:25:34AM +0300, Elazar Leibovich wrote:
> The powercap core clamps the requested limit to dtpm->power_min, but
> that clamp can be computed from stale data: in dtpm_cpu the number of
> online CPUs may have grown since power_min was last updated, and in
> dtpm_devfreq the EM table may have been updated at runtime via
> em_dev_update_perf_domain(). In both cases the clamped limit can still
> be below the first state's power, making the underflow reachable.

The underflow is also reachable without any race, by setting a power
limit on a non-leaf node of the DTPM hierarchy.

__set_power_limit_uw() distributes the limit of a node among its
children proportionally to their weights, and the weights are computed
from power_max only. The share of a child is not clamped to its own
power_min, so when the limit of the parent is close to its power_min,
a child whose power_min is high compared to its power_max gets a share
below the power of its lowest performance state. set_pd_power_limit()
then breaks at i == 0 and reads table[-1].

For instance, with two CPU performance domains under the same parent,
one with a 80-1200 range and the other one with a 400-3000 range, the
parent's range is 480-4200. Writing 500 to the parent's
constraint_0_power_limit_uw gives a share of about 357 to the second
domain, below its minimum of 400. The hierarchy created by
drivers/soc/rockchip/dtpm.c (the CPU clusters and the GPU under the
'package' node) has this shape. Whether a given limit triggers it
depends on the energy model values of the platform.

So this series also fixes an out-of-bounds read deterministically
reachable from sysfs, by a single write to the power limit of a parent
node.

I've posted a separate patch fixing the distribution itself, so a child
doesn't get less than its minimum power when the parent's limit allows
it [1]. It doesn't replace this series, which is still needed for the
stale power_min cases you described.

[1] https://lore.kernel.org/all/20261006151519.126065-1-mdmitrichenko@astralinux.ru/

Thanks,
Mikhail
