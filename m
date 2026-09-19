Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192D1A262A
	for <linux-pm@vger.kernel.org>; Sat, 19 Sep 2026 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837429; cv=none; b=pHyTapJVnme+7BMTkGxtkRph178B5s0WUcFOy5KyBuOV9nrJ/3WXjMresrG70fR8TF+bEVE4yCGrVPyZiRE8N6qaD9TsWhYzDTamAphh+8ON57FqItrJPKVZUEXvb3GuK8qHIoKtYdeDV1gga7JGOD1880ftwE1bz2rte0RMeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837429; c=relaxed/simple;
	bh=KWSR8Bvpxfsi7RbIUntAdMkvFkSjbvbdEFF7rLLLzyA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PkBj+GucHoxB16NeZYp7m5+e5QyH1cq6nZbvan/S64w0+x8YkLq3o+n8xujO8QLH/cUDJkZI+NO/lArJiStrVudTdeceoaPSHg+/yUG36yce9T37QBj3vvIddGUxrB7fPns7yrkTTFK09xq4ACtTMccRTfyvk5KBgHyNDlu5sC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=csj04AZ2; arc=none smtp.client-ip=91.218.175.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="csj04AZ2"
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KWSR8Bvpxfsi7RbIUntAdMkvFkSjbvbdEFF7rLLLzyA=;
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789837423; v=1; x=1790442223;
 b=csj04AZ2bvi58tnLcxmIG9SmyQ4TTv44Lukhz1GNNUTqnxXi3wh6kIXOHXylyFw2s7pnL1+c
 Xa0ynPXjKXIxqrTxCNMGPQqJL04aFdR6HXww0OdyZQ0rCd5NLSAxXw977PZto+ywOJgxAigpij6
 TlvQA2t9q9m2iAvufaKPp0SMXbCPjXFS7wdYLlOP08BeNw3K9f8qC8o2hlvuKNaEVYTb+gOaO/r
 361iHmOVzRX9Q2r2WwhERr1fD1nHmBI5ir2+TwjCgQsvpshfsTM4Ygpb2V+EKGEorBv/rjj8AWi
 x1rB/Vk84uhCOiANcN3iXkTmLG+2GLbV2AU95lzm5TJ2Q==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e9fc09ffbada4e66;
	Sat, 19 Sep 2026 17:03:33 +0000
X-Mizu-Trace-ID: e9fc09ffbada4e66
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 19:03:22 +0200
Message-Id: <DLJGENL5TFXO.TT10VQFGVB8S@cknow-tech.com>
Cc: "Sebastian Reichel" <sebastian.reichel@collabora.com>,
 <linux-pm@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] pmdomain: rockchip: fix clock leak on domain
 probe failure
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Shawn Lin" <shawn.lin@rock-chips.com>, "Ulf Hansson" <ulfh@kernel.org>,
 "Heiko Stuebner" <heiko@sntech.de>
X-Mailer: aerc 0.22.0-24-g39041fd9f179
References: <1789778111-173149-1-git-send-email-shawn.lin@rock-chips.com>
 <1789778111-173149-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1789778111-173149-3-git-send-email-shawn.lin@rock-chips.com>

On Sat Sep 19, 2026 at 2:35 AM CEST, Shawn Lin wrote:
> When of_clk_get() failed in the middle of the loop, the references of
> the clocks acquired so far were leaked instead of being released by
> the error path.
>
> Also switch the clks array allocation from devm_kcalloc() to
> devm_kzalloc() so that clk_bulk_put() cannot run over uninitialized
> entries.
>
> Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>
> Changes in v2:
> - switch to use devm_kzalloc()
> - add Sebastian's tag
>
>  drivers/pmdomain/rockchip/pm-domains.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 068dd4b3..43fdb7f 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -825,7 +825,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
> =20
>  	pd->num_clks =3D of_clk_get_parent_count(node);
>  	if (pd->num_clks > 0) {
> -		pd->clks =3D devm_kcalloc(pmu->dev, pd->num_clks,
> +		pd->clks =3D devm_kzalloc(pmu->dev, pd->num_clks,
>  					sizeof(*pd->clks), GFP_KERNEL);

/media/nvme/dev/debian/salsa/kernel-team/linux/drivers/pmdomain/rockchip/pm=
-domains.c: In function =E2=80=98rockchip_pm_add_one_domain=E2=80=99:
/media/nvme/dev/debian/salsa/kernel-team/linux/drivers/pmdomain/rockchip/pm=
-domains.c:840:28: error: too many arguments to function =E2=80=98devm_kzal=
loc=E2=80=99; expected 3, have 4
  840 |                 pd->clks =3D devm_kzalloc(pmu->dev, pd->num_clks,
      |                            ^~~~~~~~~~~~
In file included from /media/nvme/dev/debian/salsa/kernel-team/linux/includ=
e/linux/device.h:31,
                 from /media/nvme/dev/debian/salsa/kernel-team/linux/includ=
e/linux/platform_device.h:13,
                 from /media/nvme/dev/debian/salsa/kernel-team/linux/driver=
s/pmdomain/rockchip/pm-domains.c:13:
/media/nvme/dev/debian/salsa/kernel-team/linux/include/linux/device/devres.=
h:48:21: note: declared here
   48 | static inline void *devm_kzalloc(struct device *dev, size_t size, g=
fp_t gfp)
      |                     ^~~~~~~~~~~~

Seems legit:
https://elixir.bootlin.com/linux/v7.3-rc3/source/include/linux/device/devre=
s.h#L48

Cheers,
  Diederik

>  		if (!pd->clks)
>  			return -ENOMEM;
> @@ -842,7 +842,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
>  			dev_err(pmu->dev,
>  				"%pOFn: failed to get clk at index %d: %d\n",
>  				node, i, error);
> -			return error;
> +			goto err_put_clocks;
>  		}
>  	}
> =20


