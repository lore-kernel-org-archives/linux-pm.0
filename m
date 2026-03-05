Received: from mail.bix.bg (mail.bix.bg [193.105.196.21])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7AEBE22425B
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.105.196.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730315; cv=none; b=fMpl3sRIznrns8yzGIn8MmAVGipph7/72fvex+o/oeHV032bThmvR2vrnkyUzprOyfg7QPndHHpCHA9u5djugHtDGBni3EsZ09Vqu5L611UmGc6SUWY+iIM+pIt+Oajz8YMfXgMpcOKDCu9/srgFMLTQ1LiupOA7UBUZCE3AhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730315; c=relaxed/simple;
	bh=mdJL5ts98hcUvQyaQVQeO/tAnewL4wLSrIGi0XlakG8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=esmzwM9StZ3OALS875GCBtma55cco5CLChlL5MS8miALBy9GUjEv0qKylcowKuh/jywA2j47qHb4+1DDkF0PwfgIJXcQy7HCGydMNP17DuYnSy5oTFeLBj22K9V5cpEsrNo5mUAuKf5Etz/jTtf19SFRhImDQ1YCQTJoMHQIqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com; spf=pass smtp.mailfrom=declera.com; arc=none smtp.client-ip=193.105.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=declera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=declera.com
Received: (qmail 8053 invoked from network); 5 Mar 2026 17:05:05 -0000
Received: from d2.declera.com (HELO ?212.116.131.122?) (212.116.131.122)
  by indigo.declera.com with SMTP; 5 Mar 2026 17:05:05 -0000
Message-ID: <9634c8ceb2815d8100e270e5bd80581e32020706.camel@declera.com>
Subject: Re: [PATCH v3 2/3] thermal: spacemit: k1: Add thermal sensor support
From: Yanko Kaneti <yaneti@declera.com>
To: Shuwei Wu <shuweiwoo@163.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Yixun Lan <dlan@gentoo.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Thu, 05 Mar 2026 19:05:05 +0200
In-Reply-To: <20260119-patchv2-k1-thermal-v3-2-3d82c9ebe8a4@163.com>
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
	 <20260119-patchv2-k1-thermal-v3-2-3d82c9ebe8a4@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.59.3 (3.59.3-1.fc45) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

On Mon, 2026-01-19 at 10:41 +0800, Shuwei Wu wrote:
> The thermal sensor on K1 supports monitoring five temperature zones.
> The driver registers these sensors with the thermal framework
> and supports standard operations:
> - Reading temperature (millidegree Celsius)
> - Setting high/low thresholds for interrupts
>=20
> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
...

> +config SPACEMIT_K1_TSENSOR
> +	tristate "SpacemiT K1 thermal sensor driver"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST


this should also=C2=A0
         depends on THERMAL_OF

No?


I tested the series on OrangePi RS2 and it seems to work

root@opir2s:~# sensors
cluster1_thermal-virtual-0
Adapter: Virtual device
temp1:        +52.0=C2=B0C =20

gpu_thermal-virtual-0
Adapter: Virtual device
temp1:        +52.0=C2=B0C =20

soc_thermal-virtual-0
Adapter: Virtual device
temp1:        +50.0=C2=B0C =20

cluster0_thermal-virtual-0
Adapter: Virtual device
temp1:        +53.0=C2=B0C =20

package_thermal-virtual-0
Adapter: Virtual device
temp1:        +52.0=C2=B0C =20

Regards
Yanko

