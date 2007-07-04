From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 2/2] PM: Introduce pm_power_off_prepare
Date: Wed, 4 Jul 2007 23:39:10 +0200
Message-ID: <20070704213910.GA1836__4035.32142886451$1183585200$gmane$org@elf.ucw.cz>
References: <200707012051.48338.rjw@sisk.pl> <200707012054.31782.rjw@sisk.pl>
	<20070704195231.GI2728@elf.ucw.cz> <200707042342.27427.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707042342.27427.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Introduce the pm_power_off_prepare() callback that can be registered by the
> > > interested platforms in analogy with pm_idle() and pm_power_off(), used for
> > > preparing the system to power off (needed by ACPI).
> > > 
> > > This allows us to drop acpi_sysclass and device_acpi that are only defined in
> > > order to register the ACPI power off preparation callback, which is needed by
> > > pm_power_off() registered in a much different way.
> > 
> > Well, the acpi way works with more than one piece of code "listening"
> > for powerdowns... and does not seem that ugly to me.
> > 
> > Okay, so accessing system_state is not _that_ nice... aha, and perhaps
> > I understand why 1/2 of this series is right... it called prepare for
> > S4 even when we had shutdown in /sys/power/disk, right?
> > 
> > Hmm. Okay, I think I can ACK both of these patches, but ACPI people
> > should have chance to comment, and it probably needs to stay in -mm
> > for a while.
> 
> Well, linux-acpi in on the CC list and I see no comments from them. :-)

Hmm, that's bad. We can try adding "APM rocks" into subject line to
get their attetion or something...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
