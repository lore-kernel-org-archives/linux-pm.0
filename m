Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472617;
	b=cLQAsmGkfzw+VLWZoOsW0QSASBiukxfppzb22RHidvg28fmTcBax1NtRXIk2nyeAaH/B
	 6bRJcE13UCSw7ctuBJmBW2vlqT+GrjNUvljvoXkydTzLZOYv0HzaK3skD3C/sYDKHpVvF
	 SeKj7TTkaUY4EjydhN/1HG1bqynsI3Rdh2JZ5xi8KzSmW42B9+VjdcIC1JXtHWSndVER1
	 Fn2FDFLbPi0WgDraSFIPfs+zZlmB0InL830cZr/XMZEwjZeoOoHXblEWttdaVV2iokOFP
	 Oa+17aMsyFx+4hJV+IJjdXarm+o/bHoX0X+OTgn5BA+n44B9Ws7GwoHYW/RneamGwAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472617;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=Vamf6qewNSAWnl7V8j1ewD5Z1Pgf95ZZp/ReDU0LPuc=;
	b=U1ha3NeVWtNHOAGzTYCyvDKqfUlqmeQRzVy8/uL49cH+/5SVO9Np9Ys2ERnKl89e+xvx
	 Gk++QQUYtDVymxFVxYRn/GjuhU2CC7UuwC0J9tmL6AIjqvNcHcqal6QSMVQrecngfzjIO
	 /64tGU+PWKsnrPlxKRaq2I4wv0n4JuZ8GhbqI+o35JiC6UklApAP9Tlbfq4B59G953KTs
	 daVSkcFUlpKLkMmOZfxIFIMT0PvQnVJlwsA99Ov+IaK4h0uuTCMtuPmkvFwoE25s/ooM/
	 mtoH1Y05ETkQ5FHhH7a4oQYPfaf4kWnclJ4fT1GrPY2sSPwJA2itEeMNF9l6rVsU85g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b="bD9D/dXj";
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E5606A681;
	Mon, 23 Nov 2026 22:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20E5606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=bD9D/dXj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=Vamf6qewNSAWnl7V8j1ewD5Z1Pgf95ZZp/ReDU0LPuc=; b=bD9D/dXjIpyZzr4c6I0jQ2QMQj
	ehgl7iCDnWoNXSx0YhEvnJ5cJGCAeC9cTolz8PZuvoDvkCHiHjHUfx6ya/lKMc6sQ8vCxdemkkfDB
	wvYTduI7EmGjMH0al98IhmI1mLwxlTfedk+C1UmToX0/jHnw1AId6wT5nWqthkp7YI5CZe2jOYvjF
	z8K2vxzl4W1h1+ULTvWHTMN5+MdNWWQy+btnxEgU0Cs0oPHoIYdwTNMwiJjnfckE/nly/OOV6rn+9
	U8U6dcr9vR5D2ftpSNONQP46crIDrAX1wzx/12EvyAcVySUKmrHa7TcbqkBbl2KIaXHNjczmurWlw
	RWc75JOg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xVcRe-00000007bY0-3lpJ;
	Mon, 23 Nov 2026 23:23:30 +0100
Date: Mon, 23 Nov 2026 23:23:30 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v2 3/3] power: reset: Remove SpacemiT P1 reboot driver
Message-ID: <awS84s2FVdzy3j4Y@aurel32.net>
Mail-Followup-To: Anand Moon <linux.amoon@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20261118104935.1716-1-linux.amoon@gmail.com>
 <20261118104935.1716-3-linux.amoon@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118104935.1716-3-linux.amoon@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi Anand,

On 2026-11-18 16:19, Anand Moon wrote:
> The SpacemiT P1 reboot driver uses I2C-backed regmap operations to
> request system shutdown and restart through the PMIC.
> 
> The system-off handlers run in atomic context, where regmap operations
> may sleep. This can trigger invalid wait context and
> scheduling-while-atomic warnings during shutdown or restart.
> 
> On SpacemiT K1 platforms, system poweroff and restart are handled by
> OpenSBI through the SBI System Reset (SRST) extension. The Linux PMIC
> reboot driver duplicates this firmware functionality and is no longer
> needed.
> 
> Remove the driver along with its Kconfig and Makefile entries.
> The P1 MFD driver and its other functionality remain unaffected.
> 
> Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> New patch
> ---
>  drivers/power/reset/Kconfig              |  9 ---
>  drivers/power/reset/Makefile             |  1 -
>  drivers/power/reset/spacemit-p1-reboot.c | 87 ------------------------
>  3 files changed, 97 deletions(-)
>  delete mode 100644 drivers/power/reset/spacemit-p1-reboot.c

The patch is correct, but you might also want to remove the 
spacemit-p1-reboot entry from drivers/mfd/simple-mfd-i2c.c.

Anyway, while I support removing this driver on the long term, it might 
be a bit early to remove it. Indeed, while the driver is available in 
OpenSBI 1.9, using this version requires either patch the vendor U-Boot 
or using the upstream U-Boot which still has some limitations (thanks 
for your efforts improving it).

At the end with your patch 2, keeping this driver a bit longer doesn't 
hurt, as it is only used as a fallback if the SBI SRST extension is not 
available.

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
