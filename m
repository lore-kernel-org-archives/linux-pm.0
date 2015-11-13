From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 0/3] Fixes for twl4030 charger
Date: Fri, 13 Nov 2015 11:28:50 +0100
Message-ID: <F2CD8FEF-DFE1-4A11-8000-7127CDEE63B7@goldelico.com>
References: <cover.1446463652.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446463652.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

ping.

Am 02.11.2015 um 12:27 schrieb H. Nikolaus Schaller <hns@goldelico.com>:

> Changes V2:
> * worked in comments by Nishanth Menon <nm@ti.com>
> * added another patch which solves a probing/boot stall problem (irq allocation vs. -EPROBE_DEFER)
> 
> V1:
> 4.3-rc1 introduced a new charger driver for the twl4030.
> 
> While making it operable and testing on GTA04 and OpenPandora
> we have found some issues.
> 
> 
> H. Nikolaus Schaller (3):
>  drivers:power:twl4030-charger: fix problem with EPROBE_DEFER
>  drivers:power:twl4030-charger: don't return after allocating irq
>  drivers:power:twl4030-charger: don't check if battery is present
> 
> drivers/power/twl4030_charger.c | 39 ++++++++++++++++++---------------------
> 1 file changed, 18 insertions(+), 21 deletions(-)
> 
> -- 
> 2.5.1
> 
