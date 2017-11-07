From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/2] scripts: coccinelle: api: detect identical chip data arrays
Date: Tue, 7 Nov 2017 09:21:11 +0900
Message-ID: <CAK7LNAQKOK5fbkq9AcSzmHc+qJLxAwB0Hy5eYy389uMnvah7uA@mail.gmail.com>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr> <1507490321-24900-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507490321-24900-3-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

2017-10-09 4:18 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
> within a single structure.  It is currently specific to the file
> drivers/power/supply/bq27xxx_battery.c.  Nevertheless, having the script in
> the kernel will allow others to check their code if the data structures
> change in the future.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>

Applied to linux-kbuild/misc.

-- 
Best Regards
Masahiro Yamada
