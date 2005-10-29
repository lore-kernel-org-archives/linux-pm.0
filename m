From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 3/6] swsusp: introduce the swap map
	structure and interface functions
Date: Sun, 30 Oct 2005 00:57:08 +0200
Message-ID: <20051029225708.GD14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292232.35403.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7788295462150574=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510292232.35403.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============7788295462150574==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the main part.  It introduces a new data structure for the
> swap-handling part of swsusp (the swap map structure, described in a comment)
> and new functions for writing the image data to and reading them from swap.
> It also introduces the interface functions allowing the snapshot-handling part
> to communicate with the swap-handling part and modifies the struct pbe
> structure (the swap_address member of it is no longer needed as the
> swap-handling part uses its own independent data structures).

One small comment. I miss "a" in "swap". Pretty please...

> + * Rafael J. Wysocki <rjw@sisk.pl>
> + * Added the swap map data structure and reworked the handling of swap
> + *

Feel free to add yourself to CREDITS, too. CREDITS are going to stay,
but this does not really belong here, and may have to be moved
somewhere else in future.

> + *	During resume we only need to use one swp_map_page structure
> + *	at a time, which means that we only need to use two memory pages for
> + *	reading the image - one for reading the swp_map_page structures
> + *	and the second for reading the data pages from swap.
>   */

Nice...

> +struct swp_map_page {
> +	swp_entry_t		entries[MAP_PAGE_SIZE];
> +	swp_entry_t		next_swp;
> +	struct swp_map_page	*next;
> +};
> +
> +typedef struct swp_map_page swp_map_t;

Please don't. Just use "struct swap_map_page" instead.

> +extern unsigned snapshot_pages_to_save(void);
> +extern unsigned snapshot_image_pages(void);

Make it "extern unsigned int". (That is in more than one place).

> +int snapshot_recv_init(unsigned nr_pages, unsigned img_pages)

Please, usefull words, that's receive_init and image_pages....

Otherwise it looks good. I'll check it once more...

							Pavel
-- 
Thanks, Sharp!

--===============7788295462150574==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============7788295462150574==--
