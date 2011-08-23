From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4] PM: Reference counting of
	power.subsys_data
Date: Tue, 23 Aug 2011 22:09:55 +0200
Message-ID: <20110823200955.GA13184__25919.7573447183$1314130369$gmane$org@atrey.karlin.mff.cuni.cz>
References: <201108090028.12698.rjw@sisk.pl> <201108090031.42691.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108090031.42691.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!
> Since the power.subsys_data device field will be used by multiple
> filesystems, introduce a reference counting mechanism for it to avoid
> freeing it prematurely or changing its value at a wrong time.
> 
> Make the PM clocks management code that currently is the only user of
> power.subsys_data use the new reference counting.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/base/power/Makefile    |    2 
>  drivers/base/power/clock_ops.c |   24 ++---------
>  drivers/base/power/common.c    |   86 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm.h             |    3 +
>  4 files changed, 95 insertions(+), 20 deletions(-)
> 
> Index: linux-2.6/drivers/base/power/common.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/drivers/base/power/common.c
> @@ -0,0 +1,86 @@
> +/*
> + * drivers/base/power/common.c - Common device power management code.
> + *
> + * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.

This looks like you now work for Renesas....?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
