From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/4] Hibernation: Pass CR3 in the
	image header on x86_64
Date: Wed, 22 Aug 2007 10:28:25 +0200
Message-ID: <20070822082825.GC2479__6131.03596629134$1187795238$gmane$org@elf.ucw.cz>
References: <200708221015.16493.rjw@sisk.pl> <200708221020.34988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708221020.34988.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Since we already pass the address of restore_registers() in the image header,
> we can also pass the value of the CR3 register from before the hibernation in
> the same way.  This will allow us to avoid using init_level4_pgt page tables
> during the restore.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

> @@ -253,10 +262,13 @@ int arch_hibernation_header_save(void *a
>  {
>  	struct restore_data_record *rdr = addr;
>  
> -	if (max_size < sizeof(struct restore_data_record))
> +	if (max_size < sizeof(*rdr))
>  		return -EOVERFLOW;
>  	rdr->jump_address = restore_jump_address;
> -	rdr->control = (restore_jump_address ^ RESTORE_MAGIC);
> +	rdr->cr3 = restore_cr3;
> +	rdr->magic = RESTORE_MAGIC;
> +	rdr->crc = 0;
> +	rdr->crc = crc32_le(0, addr, sizeof(*rdr));
>  	return 0;
>  }

No, I do not think I like that. I believe both -> control and -> crc
is just useless paranoia. Bitflip in this area is not going to be any
worse than bitflip anywhere else, we should not pretend this is
somehow "more important".

-> control should really be "protocol version"... probably should
contain some field that is easy to increment.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
