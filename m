From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: add newer cpu ids
Date: Thu, 15 May 2014 17:02:42 +0800
Message-ID: <1400144562.2273.32.camel@rzhang1-toshiba>
References: <1398756954-26442-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35333 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbaEOJDA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 May 2014 05:03:00 -0400
In-Reply-To: <1398756954-26442-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On =E4=BA=8C, 2014-04-29 at 00:35 -0700, Jacob Pan wrote:
> Add support for Broadwell and Valleyview CPUs
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/intel_powerclamp.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/int=
el_powerclamp.c
> index a084325..95cb7fc 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -681,8 +681,10 @@ static const struct x86_cpu_id intel_powerclamp_=
ids[] =3D {
>  	{ X86_VENDOR_INTEL, 6, 0x2d},
>  	{ X86_VENDOR_INTEL, 6, 0x2e},
>  	{ X86_VENDOR_INTEL, 6, 0x2f},
> +	{ X86_VENDOR_INTEL, 6, 0x37},
>  	{ X86_VENDOR_INTEL, 6, 0x3a},
>  	{ X86_VENDOR_INTEL, 6, 0x3c},
> +	{ X86_VENDOR_INTEL, 6, 0x3d},
>  	{ X86_VENDOR_INTEL, 6, 0x3e},
>  	{ X86_VENDOR_INTEL, 6, 0x3f},
>  	{ X86_VENDOR_INTEL, 6, 0x45},


