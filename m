From: Len Brown <lenb@kernel.org>
Subject: Re: turbostat: fix Skylake server package
Date: Sat, 5 Aug 2017 03:07:44 -0400
Message-ID: <CAJvTdKk6eo3Z=52AvV842T_scm4HYdk_w0zyAyV-gwHrS=dVbw@mail.gmail.com>
References: <20170804154223.16223-1-artem.bityutskiy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33618 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdHEHHq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Aug 2017 03:07:46 -0400
Received: by mail-qt0-f194.google.com with SMTP id u19so3487299qtc.0
        for <linux-pm@vger.kernel.org>; Sat, 05 Aug 2017 00:07:45 -0700 (PDT)
In-Reply-To: <20170804154223.16223-1-artem.bityutskiy@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

Applied!

thanks,
-Len

On Fri, Aug 4, 2017 at 11:42 AM, Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
> This patch fixes the problem of turbostat not reporting any package C-sta=
tes on
> Skylake Xeon processor when the deepest package C-stated is configured as=
 "no
> limit" in the UEFI firmware configuration menu.
>
> The lowest 3 bits of the MSR_PKG_CST_CONFIG_CONTROL (0x000000e2) register
> contain 7 in this case, meaning "No Package C state limits" (see Intel SD=
M, vol
> 4, Table 2-41 - MSRs Supported by Intel=C2=AE Xeon=C2=AE Processor Scalab=
le Family with
> DisplayFamily_DisplayModel 06_55H).
>
> The problem was that turbostat's internal array of supported package C-sa=
tes
> (skx_pkg_cstate_limits) marked position #7 as "PCLRSV" (reserved), instea=
d of
> "PCLUNL" (not limited). Instead, position #8 was incorrectly marked as "P=
CLUNL"
> (probably due to a typo).
>
> This patch fixes the issue by marking position #7 as "not limited", and
> position #8 as "reserved".
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/turbostat.c b/turbostat.c
> index 6c185a9..1c4d3e2 100644
> --- a/turbostat.c
> +++ b/turbostat.c
> @@ -1816,7 +1816,7 @@ int slv_pkg_cstate_limits[16] =3D {PCL__0, PCL__1, =
PCLRSV, PCLRSV, PCL__4, PCLRSV,
>  int amt_pkg_cstate_limits[16] =3D {PCLUNL, PCL__1, PCL__2, PCLRSV, PCLRS=
V, PCLRSV, PCL__6, PCL__7, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, =
PCLRSV, PCLRSV};
>  int phi_pkg_cstate_limits[16] =3D {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRS=
V, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, =
PCLRSV, PCLRSV};
>  int bxt_pkg_cstate_limits[16] =3D {PCL__0, PCL__2, PCLUNL, PCLRSV, PCLRS=
V, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, =
PCLRSV, PCLRSV};
> -int skx_pkg_cstate_limits[16] =3D {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRS=
V, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, =
PCLRSV, PCLRSV};
> +int skx_pkg_cstate_limits[16] =3D {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRS=
V, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, =
PCLRSV, PCLRSV};
>
>
>  static void
> --
> 2.9.3



--=20
Len Brown, Intel Open Source Technology Center
