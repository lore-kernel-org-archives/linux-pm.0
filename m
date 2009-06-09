From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] pm: Move nvs routines into a seperate
	file.
Date: Tue, 9 Jun 2009 21:58:13 +0200
Message-ID: <20090609195813.GA1388__31481.4001358629$1244577595$gmane$org@ucw.cz>
References: <20090604161847.513682672@de.ibm.com>
	<20090608063501.GC1444@ucw.cz> <20090608173611.16238cf9@gondolin>
	<200906082048.28779.rjw@sisk.pl> <20090609104003.50830165@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090609104003.50830165@gondolin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2009-06-09 10:40:03, Cornelia Huck wrote:
> The *_nvs_* routines in swsusp.c make use of the io*map()
> functions, which are only provided for HAS_IOMEM, thus
> breaking compilation if HAS_IOMEM is not set. Fix this
> by moving the *_nvs_* routines into hibernation_nvs.c, which
> is only compiled if HAS_IOMEM is set.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -0,0 +1,135 @@
> +/*
> + * linux/kernel/power/hibernation_nvs.c
> + *
> + * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
> + *
> + * Routines for NVS memory handling
> + */

Specifying  GPLv2 here would be nice. If it contains copyright, it
should contain license, too.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
