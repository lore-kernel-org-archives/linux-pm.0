From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC PATCH 2/4] ACPI: introduce the mechanism to
	save/restore ACPI NVS memory
Date: Tue, 8 Jul 2008 21:35:59 +0200
Message-ID: <20080708193558.GC8694__20566.8679242537$1215614717$gmane$org@ucw.cz>
References: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com>
	<200807040134.15094.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807040134.15094.rjw@sisk.pl>
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
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@zh-kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >  static int acpi_hibernation_begin(void)
> >  {
> >  	acpi_target_sleep_state = ACPI_STATE_S4;
> >  
> > -	return 0;
> > +	/* allocate pages for ACPI NVS memory before swsusp_shrink_memory */
> > +	return acpi_allocate_nvs_pages();
> 
> I think we shouldn't abort hibernation because of that.
> 
> This may be an emergency hibernation due to critical battery status and we
> surely don't want to about that.

I disagree here. If spec says 'you must save this', and we don't, we
are asking for subtle, dangerous, and very hard to repoduce problems.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
