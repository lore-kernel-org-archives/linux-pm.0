From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 4/4] Hibernation: Pass CR3 value in
	hibernation header on x86_64
Date: Tue, 21 Aug 2007 10:01:18 +0200
Message-ID: <20070821080118.GH7258@elf.ucw.cz>
References: <200708201510.03734.rjw@sisk.pl> <200708201518.52765.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708201518.52765.rjw@sisk.pl>
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
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
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

> @@ -283,7 +290,8 @@ int arch_hibernation_header_save(void *a
>  	if (max_size < sizeof(struct restore_data_record))
>  		return -EOVERFLOW;
>  	rdr->jump_address = restore_jump_address;
> -	rdr->control = (restore_jump_address ^ RESTORE_MAGIC);
> +	rdr->cr3 = restore_cr3;
> +	rdr->control = (restore_jump_address ^ (restore_cr3 ^ RESTORE_MAGIC));
>  	return 0;

Does control want to be renamed as "crc"? Or perphaps we want to just
store MAGIC there, w/o any obfuscation, since obfuscation does not
really buy us anything?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
