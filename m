From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PULL REQUEST] PM / devfreq, for Linux 4.1
Date: Mon, 13 Apr 2015 16:44:58 +0200
Message-ID: <552BD66A.7010409@collabora.com>
References: <710482662.140561427784841523.JavaMail.weblogic@epmlwas02b>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:33507 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbbDMOpE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 10:45:04 -0400
In-Reply-To: <710482662.140561427784841523.JavaMail.weblogic@epmlwas02b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?B?7LWc?= =?UTF-8?B?7LCs7Jqw?= <cw00.choi@samsung.com>

On 03/31/2015 08:54 AM, MyungJoo Ham wrote:
> Dear Rafael,
> 
> Here goes a pull request from devfreq including device driver updates and style fixes.

Hello,

looks like this has been dropped in today's linux-next. Is there
anything I can help with?

Regards,

Tomeu

> Cheers,
> MyungJoo
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The following changes since commit e42391cd048809d903291d07f86ed3934ce138e9:
> 
>   Linux 4.0-rc6 (2015-03-29 15:26:31 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20150331
> 
> for you to fetch changes up to 358b615f5812e28dd763d2aa1297563927a2f89d:
> 
>   PM / devfreq: tegra: Register governor on module init (2015-03-31 13:17:15 +0900)
> 
> - ----------------------------------------------------------------
> Pull Request for Rafael, Targeting Linux 4.1
> 
> This set includes tegra driver update and style fixes.
> 
> - ----------------------------------------------------------------
> Chanwoo Choi (1):
>       PM / devfreq: event: Add const keyword for devfreq_event_ops structure
> 
> MyungJoo Ham (1):
>       PM / devfreq: correct misleading comment
> 
> Tomeu Vizoso (6):
>       PM / devfreq: tegra: Update to v5 of the submitted patches
>       PM / devfreq: tegra: Use clock rate constraints
>       PM / devfreq: tegra: remove operating-points
>       PM / devfreq: tegra: Set drvdata before enabling the irq
>       PM / devfreq: tegra: Enable interrupts after resuming the devfreq monitor
>       PM / devfreq: tegra: Register governor on module init
> 
>  drivers/devfreq/devfreq.c           |   1 -
>  drivers/devfreq/event/exynos-ppmu.c |   2 +-
>  drivers/devfreq/tegra-devfreq.c     | 509 ++++++++++++++++++++----------------
>  include/linux/devfreq-event.h       |   2 +-
>  4 files changed, 290 insertions(+), 224 deletions(-)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> 
> iQIcBAEBAgAGBQJVGiKFAAoJEBOhurvWBoCK7QgP/RNvr0fw+FVlouP3cdn5/P43
> Tf+HDeWFC2X+XIYeYiUaGlRgTAVxa0KOobRMllOcns2x42S4KP41s3Ru5AkTyT6T
> xwF274guV/EyjMNILCwm0MBY+DZF/9ftrNEqJg771k6dKqjxGKKlR1lpT0LUVqvl
> 4hTqJHTFk4zdP0BtnvQ/X+Ys+WbdK96o99e+27cy9UbZ12e3qKzEmHMHXdtbGxFc
> VIB/qtQZ/ReJegO851/aSdixTtbTrY2DxebMrDmPnK+Qdoarss0rYzGUl4tc2u8M
> 0tkdGQsTPp185xM8xhsM4ajc19QdBqkxuESEqT3ZtU87tBJoLky/2NolfLOyIXsd
> bEInuImZwU+aoNg8dXKz+jCH7XOxTcgHJenaUPkoqSjGME8Iu7D+fRKexcdGAaSC
> O8NrvMg93MzWG6kEwJ3ZVFuI8HosycluxZketXGPGFIeQ8bTmz35pmWCzXonNBZZ
> ccs/RhuTrUUhHKt4VnuXRE0vv5uyjtngJ1QFphQqtSKsp1z5l+uMMQMrfm2YHu0Y
> wdi7d9shl9bIofwbr7TlVQNl/bCItZc6rwlOxt3nKd3vNpB6lqxRw7+xmtd9u000
> ictPhyZECkppEXgKFDB1/LwoKANqZAsUyxNre1Jt8shfdtOcoNFIBOqJb6oFLoUW
> aIXhxUfd5QU3UxE3lenY
> =XLGI
> -----END PGP SIGNATURE-----
> 

