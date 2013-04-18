From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] intel_idle: additional Haswell CPU-id
Date: Thu, 18 Apr 2013 11:11:08 +0200
Message-ID: <516FB8AC.6070102@linaro.org>
References: <1366238537-14443-1-git-send-email-lenb@kernel.org> <0b15841b0bbbde75134a777c543dc51fe6187108.1366238380.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:64617 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3DRJLL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 05:11:11 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so591779bkc.30
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 02:11:09 -0700 (PDT)
In-Reply-To: <0b15841b0bbbde75134a777c543dc51fe6187108.1366238380.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On 04/18/2013 12:42 AM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>=20
> There is an additional HSW CPU-id, 0x46,
> which has C-states exactly like CPU-id 0x45.
>=20
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/idle/intel_idle.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 5d66750..1a38dd7 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -465,6 +465,7 @@ static const struct x86_cpu_id intel_idle_ids[] =3D=
 {
>  	ICPU(0x3c, idle_cpu_hsw),
>  	ICPU(0x3f, idle_cpu_hsw),
>  	ICPU(0x45, idle_cpu_hsw),
> +	ICPU(0x46, idle_cpu_hsw),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);

Hi Len,

I jump on the opportunity to remind you, we are waiting for your
ack/nack for the patch:

http://permalink.gmane.org/gmane.linux.ports.tegra/10422

Thanks
  -- Daniel



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

