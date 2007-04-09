From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Mon, 09 Apr 2007 22:07:46 +0200
Message-ID: <461A9D12.1060106@gmail.com>
References: <460B6E4B.3060004@gmail.com> <200704022318.28451.rjw@sisk.pl>
	<46120449.7070302@gmail.com> <200704031250.07307.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704031250.07307.rjw@sisk.pl>
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
Cc: linux-pm@lists.osdl.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki napsal(a):
> Thanks for testing.
[...]
> --- linux-2.6.21-rc5.orig/kernel/power/swsusp.c
> +++ linux-2.6.21-rc5/kernel/power/swsusp.c
> @@ -229,13 +229,13 @@ int swsusp_shrink_memory(void)
>  		size +=3D highmem_size;
>  		for_each_zone (zone)
>  			if (populated_zone(zone)) {
> +				tmp +=3D snapshot_additional_pages(zone);
>  				if (is_highmem(zone)) {
>  					highmem_size -=3D
>  					zone_page_state(zone, NR_FREE_PAGES);
>  				} else {
>  					tmp -=3D zone_page_state(zone, NR_FREE_PAGES);
>  					tmp +=3D zone->lowmem_reserve[ZONE_NORMAL];
> -					tmp +=3D snapshot_additional_pages(zone);

I have bad news for you :(. I thought I had unpatched kernel, but it happens
in -rc6 too.

Next, when this occurs, kernel CPU1 is not brought up and next suspend hangs
on "Suspending consoles".

regards,
-- =

http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

Hnus <hnus@fi.muni.cz> is an alias for /dev/null
