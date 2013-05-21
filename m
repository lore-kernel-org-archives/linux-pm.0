From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] Thermal: spear: Fix compilation error
Date: Tue, 21 May 2013 15:05:16 +0530
Message-ID: <CAKohpomWx3OtGF=iUJumkPHEg9ykTX_L5tpYd4+wGxZHOUFytQ@mail.gmail.com>
References: <1369128041-23403-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:37478 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab3EUJfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2013 05:35:17 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so490079oag.8
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2013 02:35:16 -0700 (PDT)
In-Reply-To: <1369128041-23403-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, Vincenzo Frascino <vincenzo.frascino@st.com>

On 21 May 2013 14:50, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Fixes the following compilation error introduced by commit 253e3ae170
> (Thermal: spear_thermal: convert to devm_ioremap_resource).
> drivers/thermal/spear_thermal.c: In function =91spear_thermal_probe=92=
:
> drivers/thermal/spear_thermal.c:123:46: error: =91dev=92 undeclared
> (first use in this function)
> stdev->thermal_base =3D devm_ioremap_resource(dev, res);
>
> While at it also remove the error message as devm_ioremap_resource()
> provides its own error messages.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Compile tested and based on linux-next (20130521).
> ---
>  drivers/thermal/spear_thermal.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
