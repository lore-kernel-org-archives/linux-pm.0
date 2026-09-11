Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE8585966;
	Fri, 11 Sep 2026 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158041; cv=none; b=riy6SXVQ6mZ35AIg9vcYbF0l7wUR7MHairyCyrl8ZB5Q6AhYw/GWSduABvsweZVczQ0W0lUwbj3Ptttz0a3KiiEe6ymEAb9ap6rYX6rl6KPtFzUyy1Cu1lQs5Y9061SMCFyZqo+XVodSnssP7tSNuabN5k95ZPSQO7L65Qwp8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158041; c=relaxed/simple;
	bh=d59MPUPA1H1MBkL0A1IYH5gBVzMvwkxxIArLc12cVVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CzqiIpN8V6JZfvkppvZL5OjisKX3r6XbDCtdUW5RPVlyl+IuV0ABclS9elBlaBjKeKRFGNc9WQiTlfYWxCUQ9fJQgwq6dOTcTi3X/7AqSPpPyrQjj4Zq8PPFQm7cxP0y8wGpHbD0ygm9mAVAOJPU9/EmoTisq/yXds3NB0nDrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=jA4bXDJI; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="jA4bXDJI"
Received: from localhost ([47.65.179.181])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 68BKKVRc088790
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 11 Sep 2026 22:20:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1789158032; bh=d59MPUPA1H1MBkL0A1IYH5gBVzMvwkxxIArLc12cVVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jA4bXDJICm5i7ajf6+X3o28SpIGteZbAJIaIGcWZaJZeQjYVk96QWHrodjrsCcjuK
	 cOJjv0axFWG7bSQJFCgQcn7kYO0rFY+lgGPIlE66VWcIhUAYVqoDmuCaWsmLj5NQDU
	 e/pWT6U/2SRs0+w8hj5lwtlhoadUmLoH+uPjrSjg=
From: Dirk Gouders <dirk@gouders.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question about system halts caused by temperature
In-Reply-To: <gha4po5nqj.fsf@gouders.net> (Dirk Gouders's message of "Fri, 11
	Sep 2026 08:03:00 +0200")
References: <gha4po5nqj.fsf@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 11 Sep 2026 22:20:31 +0200
Message-ID: <ghik4bmtf4.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11 2026, Dirk Gouders wrote:

> since I own newer hardware (Lenovo L14 Gen 5, AMD Ryzen 7), I suffer
> from system halts during system rebuilds (I use Gentoo).
>
> I now found a reliable reproducer (emerging webkit-gtk) and a setting that
> helps the system to survive such a build but that setting works with
> perhaps very conservative frequencies and from what I read in
> https://docs.kernel.org/admin-guide/pm/cpufreq.html, even with
> /sys/devices/system/cpu/cpufreq/boost turned on, the kernel aims to try
> to not let the system overheat.  Could well be that I misunderstand
> that...

I'm sorry for the noise about a seemingly well known problem.

(My previous hardware also was a Thinkpad L14 and that worked out of the
box for some years, so I thought I hit some new problem.  And when I
tried the powersave governor that let the system heat raise to death
while the fan speed remained at 3000 RPM I got really confused.)

I digged some more, found *thinkfan* and currently, webkit-gtk is being
built with performance profile at around (hopefully safe) 84=E2=84=83.

Regards,

Dirk
