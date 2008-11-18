From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/4] ACPI hibernate: Add a mechanism to
	save/restore ACPI NVS memory
Date: Tue, 18 Nov 2008 17:14:56 +0100
Message-ID: <20081118161456.GA3466__12671.4772348807$1227025056$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200810222249.20629.rjw@sisk.pl> <200810222252.11625.rjw@sisk.pl>
	<20081026120838.GB1607@ucw.cz> <200810261323.21293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200810261323.21293.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > >  #else /* CONFIG_HIBERNATION */
> > >  static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
> > >  static inline void swsusp_set_page_free(struct page *p) {}
> > > @@ -241,6 +246,14 @@ static inline void swsusp_unset_page_fre
> > >  static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
> > >  static inline int hibernate(void) { return -ENOSYS; }
> > >  static inline bool system_entering_hibernation(void) { return false; }
> > > +static inline int hibernate_nvs_register(unsigned long a, unsigned long b)
> > > +{
> > > +	return 0;
> > > +}
> > > +static inline int hibernate_nvs_alloc(void) { return 0; }
> > > +static inline void hibernate_nvs_free(void) {}
> > > +static inline void hibernate_nvs_save(void) {}
> > > +static inline void hibernate_nvs_restore(void) {}
> > >  #endif /* CONFIG_HIBERNATION */
> > 
> > Can someone call these for !hibernation case?
> 
> Not at the moment, but why not to add them?

Well, someone may call them, expecting them to save / restore nvs,
except that they will not be there. I'd prefer inlines not to exist
(so mistake is caught at compile time) or them to contain BUG(), so
that mistake is obvious.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
