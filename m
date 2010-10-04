From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 08/23] Hibernation: Generic extents support.
Date: Mon, 4 Oct 2010 19:51:22 +0200
Message-ID: <20101004175122.GB1518__16655.8971781798$1286217325$gmane$org@ucw.cz>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-9-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1285566238-10966-9-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> Separate out the extent storage and manipulation into a separate
> file and make them more generic, so we can also use extents for
> recording what sectors are used and (later) support multiple
> storage devices more easily.
> 
> Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>

> @@ -0,0 +1,125 @@
> +/*
> + * linux/kernel/power/extents.c
> + *
> + * This file provides functions for storing and using a series of
> + * extents.
> + *
> + * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@suse.cz>

That address is no longer valid :-(. Jiri Kosina should already have
patches to remove it elsewhere in the tree.


> +/**
> + *	free_all_swap_pages - free swap pages allocated for saving image data.
> + *	It also frees the extents used to register which swap entres had been
> + *	allocated.
> + */
> +
> +void hib_extents_clear(struct hib_extent_state *pos)

Comment does not match function.



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
