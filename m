From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Subject: Re: [PATCH 0/2] thermal: rcar_thermal: tidyup rebind issue
Date: Tue, 10 Nov 2015 14:15:13 +0900
Message-ID: <56417D61.80407@jinso.co.jp>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
 <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www1246.sakura.ne.jp ([219.94.162.56]:26493 "EHLO
	www1246.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbbKJFPW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 00:15:22 -0500
In-Reply-To: <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, cm-hiep@jinso.co.jp

Hi,

I have tested rcar_thermal funstion on stable linux v4.3.
It is good with this patchs.

Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>

Best regards
Nguyen Viet Dung

On 2015=E5=B9=B411=E6=9C=8810=E6=97=A5 11:11, Kuninori Morimoto wrote:
> Hi Zhang, Eduardo
> Cc: Dung, Hiep
>
> rcar_thermal doesn't work after unbind/re-bind today.
> These patches are cosmetic, and tidyup it
>
> Kuninori Morimoto (2):
>        thermal: rcar_thermal: remove redundant operation
>        thermal: rcar_thermal: use pm_runtime_put_sync()
>
>   drivers/thermal/rcar_thermal.c | 49 +++++++++++++++++++++----------=
------------------
>   1 file changed, 21 insertions(+), 28 deletions(-)
>
>
> Best regards
> ---
> Kuninori Morimoto
>

