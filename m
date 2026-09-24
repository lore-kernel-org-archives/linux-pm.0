Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5B3CF1EF
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240912; cv=none; b=h696kVirKJXeWfoCg52ehc6Tarb00LFnUyqsLmrYOhDFvd1sobT4fbCPMHXMsWXVdmN7JshtS0YYfLlrvxzpWlDRuAIw4GOcyIDYA4h92l6NC7TJxiLUYXIL+c3R5ZDtpEF0v6etXKth5nMo2ljnvf5/tHN7Haopg8T6hYvgVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240912; c=relaxed/simple;
	bh=2k5LDiRE2e9ux28kWiO3A1ulU83erXhA3t/eSPi+7RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C56AnxLHH1RviC3MInDkJQMS8X03l03R056OBy5iqpJClyaKKf59TRRdKzV/JwqUV+oLizBSkHYhjzg/GiFFoxRYZIBhy2EFgiMlXtyKBGzV0K+oHEpuPkyMgxVmVGTeJA/w8wJo5JC/+rywYpP6wXZqBH4mjqORTt1vpG2zAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=iKFBwORC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mcf7u/Z1; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="iKFBwORC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mcf7u/Z1"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 788161D000DC;
	Thu, 24 Sep 2026 05:08:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 24 Sep 2026 05:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1790240909; x=1790327309; bh=Xqv1mDI99ah11f1yhlui/VOhRBkx83Hx
	2Z3gvQ8bQaI=; b=iKFBwORCPZghVFx+fqXojWzijS9BVpdN3MCVmXnVdZLU3O72
	cF2BCQuK/Gkdc7Nj+ktGrIJUSy/AWGXy8jsLmo02E+A/bE/JWvBScgd0j59TU9YF
	/0mXWCpSBbkGTJsqRKTv33kyEJ4gbx5XdDHPOqN9b8KA4+JalN2xTkJcu/qEuqei
	x/ht3f3vg83LfT81ow++pkzxeLqBXQpTD2usbbwFCBIN8aPtAj7854GVShGXVUWE
	Y2KmytkIF1iEcjMuoax5FME567sJlCaRB91golaBS7qPL8H8+QsZYrOmIm113CHj
	VkJX6pDI+LQuECaa8zsqTWa8nUgIzgzSEeOcZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790240909; x=
	1790327309; bh=Xqv1mDI99ah11f1yhlui/VOhRBkx83Hx2Z3gvQ8bQaI=; b=m
	cf7u/Z1rj5Z1Lu8O8JNtUsu1WZcqtFVBt1HxRdiQfGLDe7z3JFEgeHHqvL1Bm/zV
	nMlft2xiwxzsolDtFBT3v7oGvD3rdLFryIWlvLmtbp1H/Eejv9nW28l7i86XDUWK
	eiv/OZUlFBJbdeTaDmpO9c+IDUYxS6OsUP8uksDTLguABFrvtUuJTltnQVRT/0vY
	xDMOiMXKe1V6XJBvq+f0aDm764Ixt0t4SsH4Ld6bZwmigofDVar564viDHo2m5rK
	dgDHt8zX+qdrOT/pdM86atAwIbvhqj8a8WkxAxdXzs+4Ki1DycYE+zPAmPqDN7Dk
	Wcd9uXZb4+rAdv1bJ9Kbw==
X-ME-Sender: <xms:jei0agGdBCCE91c0e5Bakob4OWtQeJG4tiGzBYjYBYpynL2RuRL-ag>
    <xme:jei0akTeIfFwEJl7rsPAjvMPXTdo4rr_ugGb0PNlvfl2SseRhZlEwMsW7n9plxzZh
    GzS822gLtRsxWHLwKipiylFDp581GXKuD5C5zYNSqJ9IC_MfIDz8AEoKA>
X-ME-Received: <xmr:jei0apIx1QVYE7AVBswccvqYtwUrosb1OVeVQw5055y5xpPNbdjwi1o58sSE0jPKIutKyHbUkw>
X-ME-Proxy-Cause: dmFkZTEjk+BA8kFR4mTDVJK93FMrFhrDcC21+ja2Ou9J4aQPa7mAQU/u/OMl7DjWdnqXxf
    Yw/XTeEm17OQ4MiYeM0kyjc4oNKLwrh70yyjKMNhV+l7VS/iEQKQjpsfn5Lgc1Il1nTOj7
    453lX80zNYW+LunAzNxv//P3XWMeApfxqQrLmY4DDJR+sEpwtLQHZg0e9JqHzdQQuSv8Cn
    XEot/EspdFKQqmmZCcmZyTMKN0m+/SdoM2ihkQChMvgj7hJfH0iI7VOhhHIzMBAMNsEi34
    CZQVwG4MVMaIO0Y2IPfbokcrf/neUILiV2luvJjme9c1s7WUNAfD5dwSwMJHSk0ZUGDas/
    peIispeLBZ7IbJxSCtn0hUYrGPNwqk927Ls+ESHG7RU4597HFR51vqNvJjo6vP345KfH+3
    y+vD0hkMDX8Kns0SdW9nzqmMVX5APBlXf911Gv+CvruG3sVFvebiES+SXG2UF334TqwpwI
    Zswv1B4KY28lnPDJMRyhCeQI8cs7MKAA5kz7jT2VSSkO11qUF7Yz+Zz6y4qvu3p4mPG0Hl
    IFUsEryS29fj+dH3VxSh2lADcm2+Q3pcKfV5I9b+mf5nItr8mxywL+icQ17/ft5I0ptONr
    d2duu00o76ajFJHK3HOqgttLcXMVMvT6nVqpvz6DBosWTt36Ua1RFy9TNKEw
X-ME-Proxy: <xmx:jei0anZLtVPQE5zRwFgY_W4gij6pfcvRmHmwUfCH1Lrl8Kgout4rqg>
    <xmx:jei0aj8BCVY-HGx4LKIc9uA2l-r7mG8IgNS4d6oSMU-mqcnqmcnS4g>
    <xmx:jei0agaQtw8pRQxDteActYO-QNbCykHot-xeo4abQCvnOBH_aR8_dQ>
    <xmx:jei0avOKyt3QVyYpdpao0l_29Mg7hs40toU0PS8IHFF0bkeX6S10ig>
    <xmx:jei0aj8hQZ7rMd5mEpAImrYhUC8ADfg85nzmJSTMmUoB62MnUXzpUjxE>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 05:08:26 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: heiko@sntech.de
Cc: chaoyi.chen@rock-chips.com,
	ulf.hansson@oss.qualcomm.com,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v13 09/14] pmdomain: rockchip: add optional per-domain power-on settle delay
Date: Thu, 24 Sep 2026 21:08:24 +1200
Message-ID: <20260924090824.38493-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <15844283.tv2OnDr8pf@phil>
References: <20260915104328.45901-1-gahing@gahingwoo.com> <20260915104328.45901-10-gahing@gahingwoo.com> <15844283.tv2OnDr8pf@phil>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Heiko,

Chaoyi has given the mechanism, and I ran your experiment on v13 as
posted, since the SError behind this patch was first seen in June on a
board that held vdd_npu_s0 up with a local regulator-always-on and had
no domain-supply.

Same kernel in every arm (this series, an unrelated dw-hdmi-qp patch,
and a test-only override of the table delay), v13's rock-4d dtb, and for
the last arm that dtb with only regulator-always-on added to vdd_npu_s0:

  delay 15 us, rail follows the domain   536 cold power-ons, clean
  delay 0,     rail follows the domain   SError at the first power-on
  delay 0,     regulator-always-on       SError at the first power-on

Both failures are the same:

  Kernel panic - not syncing: Asynchronous SError Interrupt
   regmap_write+0x58/0x78
   rockchip_pd_power+0x4b4/0x63c
   rockchip_pd_power_on+0x7c/0xd4

In the always-on arm the rail has been enabled since the regulator
registered, so nothing is ramping at that first power-on (1.4 s,
deferred probe), and it still faults. The fault needs only the domain,
as Chaoyi says, and the delay removes it. The enable time is already
described: rk3576-rock-4d.dts gives vdd_npu_s0
regulator-enable-ramp-delay = <400>.

Limits: one boot per failing arm, nothing tried between 0 and 15 us, and
neither failing arm got past its first power-on.

Regards,
Jiaxing
