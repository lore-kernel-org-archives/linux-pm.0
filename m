Received: from mail.bix.bg (mail.bix.bg [193.105.196.21])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5B043332902
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.105.196.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116785; cv=none; b=EK92Ww7Zn9Z0rzz5wDNq49kIShhlWs0X9BF64iGcHJM0xQG7yhha5hvkPpO6GEb8qDOGPC+3KUQVaZGg+j9bMxNJUXT4vUg57CCdLGimjYAiUZt75z01TlxvBGv8EQjin1K2bOPk0f5f7m5tECvUEnuxJNdJpJe5E2X3lgEKAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116785; c=relaxed/simple;
	bh=jUnVLRlYIjWKofi/vKDPcNK99SnLf7jH9tN/5zFXfrI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWvsMKMAdaDpU152udxNG9jgHjVkZXHhSKv5lhr6CmrEXuqncFTCy18j+XXg/dI0iELueJQ5aSpwzXGdPkUDATW0uV0EsjvrIk3sR/iDIAI+5yXMYmGikPtFrFI5PpxTV5LC+r4XTgbLIPSi3LGp1fFlmCWdYUv1/KedlYqA79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com; spf=pass smtp.mailfrom=declera.com; arc=none smtp.client-ip=193.105.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=declera.com
Received: (qmail 21106 invoked from network); 26 Feb 2026 14:32:58 -0000
Received: from d2.declera.com (HELO ?212.116.131.122?) (212.116.131.122)
  by indigo.declera.com with SMTP; 26 Feb 2026 14:32:58 -0000
Message-ID: <b51a62513daa9d2390031ec350e0b33bdb7e54aa.camel@declera.com>
Subject: Re: [PATCH v5 2/2] mfd: simple-mfd-i2c: add a reboot cell for the
 SpacemiT P1 chip
From: Yanko Kaneti <yaneti@declera.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org, Lee
 Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, Troy Mitchell	
 <troy.mitchell@linux.spacemit.com>, Yixun Lan <dlan@gentoo.org>, Paul
 Walmsley	 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou	
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, "open list:RISC-V
 ARCHITECTURE:Keyword:riscv" <linux-riscv@lists.infradead.org>, "open
 list:RISC-V SPACEMIT SoC Support:Keyword:spacemit"	
 <spacemit@lists.linux.dev>
Cc: "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>
Date: Thu, 26 Feb 2026 16:32:58 +0200
In-Reply-To: <20251102230352.914421-3-aurelien@aurel32.net>
References: <20251102230352.914421-1-aurelien@aurel32.net>
	 <20251102230352.914421-3-aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.59.2 (3.59.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Mon, 2025-11-03 at 00:02 +0100, Aurelien Jarno wrote:
> Add a "spacemit-p1-reboot" cell for the SpacemiT P1 chip.
>=20
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
> v5: no changes
>=20
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 0a607a1e3ca1d..542d378cdcd1f 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -99,6 +99,7 @@ static const struct regmap_config spacemit_p1_regmap_co=
nfig =3D {
>  };
> =20
>  static const struct mfd_cell spacemit_p1_cells[] =3D {
> +	{ .name =3D "spacemit-p1-reboot", },
>  	{ .name =3D "spacemit-p1-regulator", },
>  	{ .name =3D "spacemit-p1-rtc", },
>  };

Perhaps its safe to merge this one now that everything P1 and I2C is
already in linus tip ?

mainline + patch + dts bits enabling i2c8 on the OrangePi RV2 and R2S
allows both to soft reboot as expected.

-Yanko
