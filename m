From: Pavel Machek <pavel@suse.cz>
Subject: Re: release early... powermac g5 suspend to disk
Date: Wed, 28 Jun 2006 23:42:17 +0200
Message-ID: <20060628214217.GC30373@elf.ucw.cz>
References: <1151057810.7608.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1151057810.7608.25.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Wow. 2 days and a mostly destroyed XFS filesystem (it's still running
> but I better not touch some directories or it goes belly up, xfs_repair
> craps out too) I actually suspended my quad powermac a few times.

Congratulations! Hehe, you have nice testcase for xfs now :-).

[ext2 is the filesystem you proably want to use while hacking such code]. =


> Half of the time I'll be told by the softlockup watchdog that it locked
> up, but sometimes it actually works, that is, it suspends and resumes.
> =

> Issues: I don't save MPIC state. Hence, anything that is compiled in as
> modules will no longer get IRQs after resume. Like USB on my system. So
> I only ohci_hcd and ehci_hcd before suspend, reload later (from a
> script) and I can still use the keyboard after ;)
> =

> Same goes for tg3 even though it is built-in. Well, I held off looking
> at the MPIC because Ben said he was rewriting the whole interrupt stuff
> anyway.
> =

> Other issues: yeah, this is extremely ugly. If you like your machine,
> don't take a look.

I like my machine. I'll take a look anyway ;-). It is not _that_
bad... at least it is short :).
								Pavel


> --- linux-2.6-git.orig/kernel/power/snapshot.c	2006-06-23 11:37:23.433885=
225 +0200
> +++ linux-2.6-git/kernel/power/snapshot.c	2006-06-23 11:39:03.352985945 +=
0200
> @@ -177,7 +177,13 @@
>  		return 0;
>  =

>  	page =3D pfn_to_page(pfn);
> +/*
> +    I currently mark the physical memory that we reserve
> +    and _don't_ map for kernel access as Nosave so we won't
> +    try to save it... Not sure what to do.
> +
>  	BUG_ON(PageReserved(page) && PageNosave(page));
> +*/

I believe this is gone in -git kernels for some other reasons.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
