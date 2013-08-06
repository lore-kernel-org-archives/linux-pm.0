From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH v2 0/3] ARM: TC2 big.LITTLE CPU idle driver
Date: Tue, 06 Aug 2013 09:13:01 +0200
Message-ID: <5200A1FD.6050709@linaro.org>
References: <1375709982-27148-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57986 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab3HFHNB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2013 03:13:01 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj13so2306756wib.11
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2013 00:13:00 -0700 (PDT)
In-Reply-To: <1375709982-27148-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Amit Kucheria <amit.kucheria@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jon Medhurst <tixy@linaro.org>

On 08/05/2013 03:39 PM, Lorenzo Pieralisi wrote:
> This patch is v2 of a previous posting:
>=20
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/18635=
2.html
>=20
> v2 changes:
>=20
> - removed duplicated idle statistics and irq enabling
> - use MPIDR masks to compute cluster and cpu ids

Hi Lorenzo,

I don't think this patch is still in RFC but ready for merging if nobod=
y
complains :)

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

