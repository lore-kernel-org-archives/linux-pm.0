Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23804535FD3;
	Wed, 14 Oct 2026 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990369; cv=none; b=S6iWfQHE5CDxDqBszHBThXwQJ+ut+KUyayiL1YyARXYnxFa03VcL9FUp+XWS44cz4Pu/lw9cWz7RbWdGPqEHQOGYrBK/F2ty/FaXwmtigw5TTZi5wWpo+EQGvKn6ivYmHR87cJQX5M+1FBFSrJY1UDjBHSNqFiANnaynRcJ7vwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990369; c=relaxed/simple;
	bh=v12IsbExoXSHnqxCSAhcKivWOTP9pDIPEsVnUp8eq2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRlXl8wumeuBLilyLDBqg1l/wys4X0b7W+RW5dUFvnKo2yd9/x0OWnu85o8XLjWjNaQlo+Qk730USo6EHOxDSKbOUF99x9wNVJrRpA1+cRRxE9ntXJMLtwNId7xu9enAkOtzHQHl2aMGT9wyUP1pi07BCx1yDmwso/dJu+SlPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EhCgrQzq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EhCgrQzq"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1712680A09;
	Wed, 14 Oct 2026 17:06:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSpeEZg0RwCu; Wed, 14 Oct 2026 17:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791990363; bh=v12IsbExoXSHnqxCSAhcKivWOTP9pDIPEsVnUp8eq2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EhCgrQzqE7cdTsLXP1cO+ZKDhY6WJGyXFTmF92/5xcG9fQAWaz9U8zOHJLHSSrxS4
	 MyKlvHqKolFa2XDCMG5SDjSdXSXtnNDzQGRRdZBZko9DmwJhS7bLXbWt3gwXWMvWmv
	 +2nQj6hHEeWUDkjVuN6ZQtSw2ZOGwwbEew9TZKLdti9GqJzeyYVxbD0YhGpIoFA4LS
	 HUNWiVsuet6m3MBiIasN/PnTt4REDu6kdBIMUxie+78s4NPUTbUwnqkdgyZH/26U0/
	 pgwZ2xnpIfQ9pW3D6ydYTduYXDnF/r2y86R7uhN05tgThuibs4hhol9bP4py+SLOOq
	 NrN0ldaaDMkDA==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Rong Zhang <i@rong.moe>,
	Charis Stratakis <c.stratakis@proton.me>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
Date: Wed, 14 Oct 2026 18:05:35 +0300
Message-ID: <20261014150537.121547-1-aliamemis@disroot.org>
In-Reply-To: <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
References: <20261014132703.93355-1-aliamemis@disroot.org> <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Oct 14, 2026 at 03:45:10PM +0200, Hans de Goede wrote:
> Hmm, I wonder if we should export the lock added in patch 1/3 and
> then also take that in the ACPI EC interrupt handler ?
>
> The ACPI code already uses a threaded IRQ handler for both EC GPIO
> IRQs and GPEs so sleeping in the handler should be ok.

Sleeping is fine, but the interrupt handler completes the EC
transactions, so taking the lock there would deadlock an exclusive
_BST.  Doing it in acpi_ec_event_processor() where the _Qxx methods
are evaluated, works though.  With the brightness key queries also
running the \GTST copy, 283 of 891 _BST reads were broken without it
and 0 of 804 with it.

> I'm just thinking that if we're going to do this it would be nice to
> cover the bko221065 UCSI case too.

UCSI and _Qxx alone aren't enough there.  I emulated the ECMT users
from the 83DR tables and the EC helpers kept waiting up to ~680 ms of
their 1 s timeout behind GBMD/SBMC until the ideapad methods were
exclusive too.

> Note this is something which can be done on top of this set.

I can send a series on top of this one for the EC queries, UCSI and
ideapad if that sounds good.
