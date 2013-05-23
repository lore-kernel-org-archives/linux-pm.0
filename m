From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] drivers: idle: comment DEBUG
Date: Thu, 23 May 2013 08:27:36 +0800
Message-ID: <1369268856.5142.157.camel@liguang.fnst.cn.fujitsu.com>
References: <1366873227-920-1-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:42918 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab3EWA1l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 May 2013 20:27:41 -0400
In-Reply-To: <1366873227-920-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

ping ...

=E5=9C=A8 2013-04-25=E5=9B=9B=E7=9A=84 15:00 +0800=EF=BC=8Cliguang=E5=86=
=99=E9=81=93=EF=BC=9A
> seems we should comment DEBUG as above comment said:
> "/* un-comment DEBUG to enable pr_debug() statements */"
>=20
> now, pr_debug is already enabled as DEBUG been defined.
>=20
> Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
> ---
>  drivers/idle/intel_idle.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 5d66750..9618586 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -51,7 +51,7 @@
>   */
> =20
>  /* un-comment DEBUG to enable pr_debug() statements */
> -#define DEBUG
> +/* #define DEBUG */
> =20
>  #include <linux/kernel.h>
>  #include <linux/cpuidle.h>


