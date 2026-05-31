Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2077345CBC;
	Sun, 31 May 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241193; cv=none; b=TH6c0t1csxMPzg7JFpOrB3PuhZuCkZhAmJm39UdjzfgfEPjdficrRXTi/gnlzUUdROpVKCumtIGuVi7D38au557maJ6yK84L2tYpcV2IOgjND/O+VUgojy4crQR69Mm36V8seEkOOy0/y9Bs1gGxWTFBwet+LrliR+2qMhvjtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241193; c=relaxed/simple;
	bh=yuNMze+dYwvKQyRxEsXD5OjRpU3KKGaFmtu7/zO4kJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuZq7J06fFyMO/asPDJx1NNSqxAihO6aAbwskSnBOywY111Pll9NnXo9XS4ifNL8WRnUfxYdvn99jnuwjONXLpyQKVLa++j7eWNxjBqz3svrDxdZZgudyRJRIY3mR/Rk0UVriS0UL0APywQgehhBPM6Q80NpaR4Q896ufifPErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk; spf=pass smtp.mailfrom=pelago.org.uk; dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b=HlUkKbb9; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b="HlUkKbb9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pelago.org.uk; s=mythic-beasts-k1; h=From:To:Subject:Date;
	bh=yuNMze+dYwvKQyRxEsXD5OjRpU3KKGaFmtu7/zO4kJc=; b=HlUkKbb9coiqPNfi9kdkJHNKGU
	8E7LdVqMAh9uG1M2ztJ+SVc+uQQy3qC6PWe6S5GLt7vNDaf0Yk8kucF2WZt04pZMuG0QmXd89Svkd
	vFrMPHoydtX9j+gh5ihSPhlfP26DxV9qfFh8Kqi8CC9c7Tpbwf3OIDefBrVOD5r9TsUmxkK40SEoX
	R0TvrXr6Y/q3cZ71S4oiO9tESdBJ+iKDVQXC/ET88BzldJKBGhCk4HyCDscxAsQdUXnvjWuAABrTq
	x1PNve/p7vuPADtWHB940UODu4MZThhvqxR1R1ixjCdN4drK3snF3HPI13ht5ewMOW7kTMDIG2+GB
	rnXsMvlw==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@pelago.org.uk>)
	id 1wTi3F-00DfGw-0A;
	Sun, 31 May 2026 16:26:09 +0100
Message-ID: <2238f0ea-e479-4946-971d-9fbfc9170ec4@pelago.org.uk>
Date: Sun, 31 May 2026 16:25:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: "Rafael J. Wysocki" <rafael@kernel.org>, Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
 <12896447.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-GB
From: John Veness <john@pelago.org.uk>
In-Reply-To: <12896447.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0

On 19/05/2026 18:15, Rafael J. Wysocki wrote:
> So please let me know if the patch below fixes the problem for you.
>
> In either case, please grep the dmesg output for "ACPI GPE" and let me know
> the result.
>
> Thanks!
Hi Rafael, thanks for the quick patch! I'm not Nick, but I have tested
the patch here on my old Toshiba Tecra Z50-A and it seems to have worked
- I now have Fn+keys working fine, after losing them in a recent kernel
update (apart from Fn+3 for volume down, and Fn+4 for volume up, which
for some reason continued to work when the others didn't).

dmesg|grep "ACPI GPE" since applying the patch gives:

[ 0.197248] [ T1] acpi (null): ACPI GPE enabled for PNP0C0C

John
