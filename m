Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B213A7F6B;
	Tue, 13 Oct 2026 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869703; cv=none; b=eSrNQM78EJH11laMzFHmI6yVdx1rmQjYlJOiIXcf4aZ8+YIxQ2GwryI+CVPSTYFXGNb7F75qUfp8tF2BK3IcMoAtS84PwPKluv5XUhL2OUcDCJ0Qb54zwFI38BuK4VnQMbhtV5Y56X2mdACled3XZ0HPaeA0j5h73GiXE/5499I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869703; c=relaxed/simple;
	bh=1VhxKLrhWBiAy0eAwQAwxIUNrjz/xoi3XdqEFckbF/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FanRB/+xET+KHaUli9NEgB25qx3yA+ogiRq9WoK83FV5gdQQhLPaCUYL3MtZFy/7BWc220b+rXdwkZ2v6jvVv3hdtEYSzP+lTXkeWkmYpWTJa+Relc0YGzxU0R17HesS0vwo0ZpOE/JxgTvTBkumJxLPKIR+m+fhGfZYBEtzsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FMXl4S0A; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FMXl4S0A"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 827F880DAC;
	Tue, 13 Oct 2026 07:34:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4iAY6EFKXxY; Tue, 13 Oct 2026 07:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791869698; bh=1VhxKLrhWBiAy0eAwQAwxIUNrjz/xoi3XdqEFckbF/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMXl4S0AgM4goRxIIPr+lEbOKorOZe+jIOJOPiEXVxUkWXWrxu7bg1ut4r/ucwRsE
	 iDEHlY0MQIwlqxfRFfys0nrEhVsrx3OLb0rCXoMrdazc4Xzuqvv/2T2BQwAgiExoCt
	 5h8eDjR6lftXye9tsmS7JhVv3IpWH4w5hh4S9CNs12QGe59y7UfpvQ74dWu1dKUka7
	 SiHZq1Kfx23KivJmdGVMYUUaXtePMLON5qUF8rbfY8aycQz1efLc7QmzuuQ0DAYeFh
	 Dz7jtxGmFCMWi3kJlKCCepoIhZauJGWA3kkr8N+CHu8xQOCU0wXcxSDq/oQiNkvZDU
	 3jrtmmocYfI+w==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: Charis Stratakis <c.stratakis@proton.me>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	regressions@lists.linux.dev,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the complete callback
Date: Tue, 13 Oct 2026 08:34:46 +0300
Message-ID: <20261013053447.43175-1-aliamemis@disroot.org>
In-Reply-To: <RzdkKLBwqo3DyCK02-SY8TzjXuAuqzmM5cuV7LddeKdLyZhPu_av9VmcP8a7ZE5Uzt1sJo4AoMaN9reZpMo6jSQ2P1G3ooDL1rn2atKO2O8=@proton.me>
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me> <20261012225141.13683-1-aliamemis@disroot.org> <20261012225841.15260-1-aliamemis@disroot.org> <RzdkKLBwqo3DyCK02-SY8TzjXuAuqzmM5cuV7LddeKdLyZhPu_av9VmcP8a7ZE5Uzt1sJo4AoMaN9reZpMo6jSQ2P1G3ooDL1rn2atKO2O8=@proton.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 01:40:17AM +0000, Charis Stratakis wrote:
> 18 of 20 on stock against 0 of 20 patched.
>
> Tested-by: Charalampos Stratakis <c.stratakis@proton.me>

Thanks for testing.

[...]

> Would a plausibility check in acpi_battery_get_state() be welcome for that, re-
> evaluating _BST once and warning FW_BUG when capacity_now exceeds
> design_capacity by a wide margin?

I'd rather not.  It only hides the absurd values and the plausible wrong
ones still get through.  If the runtime race turns out to matter, taking
BATM around the INT3403 _TMP on these two models would fix it where it
happens.
