From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 4/4] Hibernation: Pass CR3 value in
	hibernation header on x86_64
Date: Tue, 21 Aug 2007 16:46:20 +0200
Message-ID: <200708211646.21192.rjw@sisk.pl>
References: <200708201510.03734.rjw@sisk.pl> <200708201518.52765.rjw@sisk.pl>
	<20070821080118.GH7258@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070821080118.GH7258@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 21 August 2007 10:01, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Since we already pass the address of restore_registers() in the image header,
> > we can also pass the value of the CR3 register from before the hibernation in
> > the same way.  This will allow us to avoid using init_level4_pgt page tables
> > during the restore.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > @@ -283,7 +290,8 @@ int arch_hibernation_header_save(void *a
> >  	if (max_size < sizeof(struct restore_data_record))
> >  		return -EOVERFLOW;
> >  	rdr->jump_address = restore_jump_address;
> > -	rdr->control = (restore_jump_address ^ RESTORE_MAGIC);
> > +	rdr->cr3 = restore_cr3;
> > +	rdr->control = (restore_jump_address ^ (restore_cr3 ^ RESTORE_MAGIC));
> >  	return 0;
> 
> Does control want to be renamed as "crc"?

I think we should use CRC here, but I need to figure out how to get the
dependencies right.

> Or perphaps we want to just store MAGIC there, w/o any obfuscation, since
> obfuscation does not really buy us anything?

Well, the idea is to avoid using corrupted cr3 value or the jump address ...

Greetings,
Rafael
