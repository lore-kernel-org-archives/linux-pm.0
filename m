From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] intel_idle: set the state_tables array as __initdata
 to save mem
Date: Sat, 09 Mar 2013 04:01:01 +0100
Message-ID: <513AA5ED.2030300@linaro.org>
References: <1362674529.31506.17.camel@cliu38-desktop-build>  <1362754926.31506.42.camel@cliu38-desktop-build> <1362755169.31506.47.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58454 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850Ab3CIDBF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Mar 2013 22:01:05 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so1840790pbc.15
        for <linux-pm@vger.kernel.org>; Fri, 08 Mar 2013 19:01:05 -0800 (PST)
In-Reply-To: <1362755169.31506.47.camel@cliu38-desktop-build>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: lenb@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/08/2013 04:06 PM, Chuansheng Liu wrote:
>=20
> Currently, in intel_idle.c, there are 5 state_tables array, every
> array size is sizeof(struct cpuidle_state) * CPUIDLE_STATE_MAX.
>=20
> As in intel_idle_cpuidle_driver_init(), we have copied the data into
> intel_idle_driver->state[], so do not need to keep state_tables[]
> there any more after system init.
>=20
> It will save about 3~4k memory, also benefits mobile devices.
> Here changing them as __initdata, also removing global var
> cpuidle_state_table pointer.
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

