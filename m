From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] intel_idle: mark states tables with __initdata tag
Date: Mon, 02 Sep 2013 11:26:06 +0200
Message-ID: <522459AE.3040201@linaro.org>
References: <3627555.yC4BdJJnVe@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:57996 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756098Ab3IBJ0I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2013 05:26:08 -0400
Received: by mail-bk0-f48.google.com with SMTP id my13so1449567bkb.21
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2013 02:26:06 -0700 (PDT)
In-Reply-To: <3627555.yC4BdJJnVe@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

:0
:0
On 08/30/2013 12:26 PM, Bartlomiej Zolnierkiewicz wrote:
> States tables are only accessed during driver initialization so they
> can be marked with __initdata tag.
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Len Brown <lenb@kernel.org>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

