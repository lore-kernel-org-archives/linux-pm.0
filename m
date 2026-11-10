Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345947;
	b=ZapVumOhs7PVLA+TNTeRUk5R998XvRVECxheaIVzFMwyLXHoZKdMHgkbAOq/vNc46nR2
	 go9B1UZb/7HjNJPJN6+9xdhJRR9vbVH3ZbgtoOCRN2JJDOm0BhZYkqPXoW02lMD5Ot4xz
	 lZ8gck3KxxLhLJ1NPVv6YGcPKNpUWx7W3Q0vxlJP+0g0JZ3ubkmctdqWsVtYH3h66GIzn
	 +aFDXpVQ9vVvn/nuNrsqfdIFjCWF86dUMt18gwxr9Kxd958LFmp+hmAjI27h4pemM7yXb
	 Lgr4WHNqjgqnUHPLQHNyHEwGY0FS6KF5XIh0NfZa556YNQ98EOR8hQgBcWUxuGvwC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345947;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=EdPrvIoeQkOKljOBokRv+hpyTWHif36ZDAjxUxoFpUA=;
	b=qlvWhRTebzxOD8LP73o8PrEw04yM4BO2BsazwnoUU5Rm+f1tLU3+xvkB7HM+QV4UBAbU
	 W1vRqP0u2g++wpRQ6+YoE4xKvcZPGT2TchYtgBdSzTHSNBA5VXlRDqsrEluvBr4k7ZOmb
	 Pwx3MkrBJokJbWI5DUOYjNuT+v8qXQ3eGlF1FajwxsDVIHSwdfq1y8zi6GSfZutCcRsom
	 KShPsU16KsAKFBhbhvYyUG6M9JhbeFU+H/8azOPuVVtx+DBYR3vipI/jWf3KW9AfEWMw5
	 9J6Tx0Vmx0e7KHw1uTu8A5LJ8xO9hA7ydD4P2x8nyvI+RBCQ3Y7ommJ9jSLqKA31Esw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=bhBtXJ6g;
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA627606A320;
	Tue, 10 Nov 2026 21:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA627606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=bhBtXJ6g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=EdPrvIoeQkOKljOBokRv+hpyTWHif36ZDAjxUxoFpUA=; b=bhBtXJ6g8peGt6aBT/og1oe/b/
	/ldqn7fRO1oFAdW7RZz2uJqaAGB3ufJBSlbIgwlACxaY//0iQUVtys0GbXgvr+eSZe74pacn3YEZd
	SMzYVU1dk2TAMKHGBBH0Si9JnUrfJRsvjTaR06OO4+d+kGWPvWe+2Iqyz1ORL4RUgm7+WURelWuz3
	05fQR6RpTzQbZkx1InA26LPWzKrfNBszNxzQ/D9Hh0yAWwIxmtpIez7B2GOjz4Ffsr5mPcuaB+Ljm
	6hlwP0gRT17/jKMitePEYdcpqXhe/abx8lzM3sJ3rBoXMV/olZlJHUe05p0Tw6CoUxOPdC0wAPnIQ
	R79+LVqg==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xQtLb-00000006KxL-0RIA;
	Tue, 10 Nov 2026 22:25:43 +0100
Date: Tue, 10 Nov 2026 22:25:42 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] power: reset: spacemit-p1: Use atomic I2C
 transfers for power-off and restart
Message-ID: <avOL1mCkI4YSaDeO@aurel32.net>
Mail-Followup-To: Anand Moon <linux.amoon@gmail.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>,
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
References: <20261110061429.2036-1-linux.amoon@gmail.com>
 <20261110061429.2036-2-linux.amoon@gmail.com>
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
In-Reply-To: <20261110061429.2036-2-linux.amoon@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi Anand,

On 2026-11-10 11:44, Anand Moon wrote:
> The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
> to access the PMIC. However, these handlers run in an atomic notifier
> context (specifically within an rcu_read_lock() critical section), while
> the I2C-backed regmap uses a sleepable mutex.
> 
> This triggers a "WARNING: suspicious RCU usage" warning due to an illegal
> context switch in the RCU read-side critical section during shutdown on the
> Banana Pi BPI-F3:
> 
> [  563.803475] WARNING: suspicious RCU usage
> [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
> [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in RCU read-side critical section!
> ...
> [  563.841445] locks held by shutdown/1: 2, last CPU#0:
> [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:4}, at: __do_sys_reboot+0x230/0x29e
> [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: atomic_notifier_call_chain+0x4a/0x1c2
> 
> Replace the regmap operations with atomic I2C transfers to avoid sleeping
> in an atomic context. Preserve unrelated register bits through
> read-modify-write operations and check for atomic I2C support before
> registering the handlers.
> 
> Obtain the I2C client from the parent device and verify that the adapter
> supports atomic transfers before registering the handlers.
> 
> Tested on the Banana Pi BPI-F3 (SpacemiT K1).

While the patch looks correct, I am not sure this is the correct 
approach, as opposed to the one proposed by Troy [1].

Indeed bypassing regmap and using i2c atomic transfers needs to be done 
by all affected drivers. For instance the VisionFive 2 board, which use 
an axp15060 PMIC is also affected by this issue. And the corresponding 
driver is shared between architectures, which make this kind of change 
more difficult.

For the BPI-F3, note that with OpenSBI 1.9, the reboot is handled 
through the SBI SRST extension, preventing this issue to happen. On the 
long term, I am not sure we should keep this driver.

Regards
Aurelien

[1] https://lore.kernel.org/linux-riscv/20261104-v7-0-rc1-rv-dis-int-before-restart-v5-1-956ec09c900d@linux.dev/

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
