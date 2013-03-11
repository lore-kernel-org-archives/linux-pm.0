From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3 V2] intel_idle: Removing the redundant calculating
 for dev->state_count
Date: Mon, 11 Mar 2013 10:08:51 +0100
Message-ID: <513D9F23.5050705@linaro.org>
References: <1362674529.31506.17.camel@cliu38-desktop-build>  <1362754926.31506.42.camel@cliu38-desktop-build>  <1362755074.31506.45.camel@cliu38-desktop-build> <1362998657.31506.52.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:49674 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab3CKJIz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Mar 2013 05:08:55 -0400
Received: by mail-bk0-f45.google.com with SMTP id i18so1558188bkv.18
        for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2013 02:08:54 -0700 (PDT)
In-Reply-To: <1362998657.31506.52.camel@cliu38-desktop-build>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: lenb@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/11/2013 11:44 AM, Chuansheng Liu wrote:
>=20
> In function intel_idle_cpu_init() and intel_idle_cpuidle_driver_init(=
),
> they are having the same for(;;) loop to count the ->state_count.
>=20
> Although intel_idle_cpu_init() can be called at runtime CPU HOTPLUG c=
ase,
> but max_cstate can not be changed at runtime.
>=20
> So the dev->state_count should be =3D=3D drv->state_count, in the fun=
ction
> cpuidle_register_device() has done the initialization.
>=20
> Here we can clean up these pieces of code.
>=20
> Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>




--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

