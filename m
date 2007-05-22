From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 3/4] swsusp: Introduce restore platform
	operations
Date: Tue, 22 May 2007 22:03:47 +0200
Message-ID: <200705222203.48568.rjw__6373.96221650324$1179864304$gmane$org@sisk.pl>
References: <200705180019.35548.rjw@sisk.pl>
	<20070521233848.GN10714@elf.ucw.cz>
	<200705220155.44430.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705220155.44430.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 22 May 2007 01:55, Rafael J. Wysocki wrote:
> On Tuesday, 22 May 2007 01:38, Pavel Machek wrote:
> > Hi!
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > At least on some machines it is necessary to prepare the ACPI firmware for the
> > > restoration of the system memory state from the hibernation image if the
> > > "platform" mode of hibernation has been used.  Namely, in that cases we need to
> > > disable the GPEs before replacing the "boot" kernel with the "frozen" kernel.
> > > After the restore they will be re-enabled by hibernation_ops->finish(), but if
> > > the restore fails, they have to be re-enabled by the restore code explicitly.
> > > 
> > > For this purpose we can introduce two additional hibernation operations, called
> > > pre_restore() and restore_cleanup() and call them from the restore code path.
> > > Still, they should be called if the "platform" mode of hibernation has been
> > > used, so we need to pass the information about the hibernation mode from the
> > > "frozen" kernel to the "boot" kernel in the image header.
> > 
> > I don't quite like this one... passing flags from frozen to boot
> > kernel makes it more complex.

BTW, we've been doing this for months in the userland version, so why not to do
it here?
 
> > Is it really neccessary?
> 
> I think so.
> 
> > Could we do the same steps as the first thing when the frozen kernel
> > wakes up?
> 
> At that time we do hibernate_ops->finish() which enables the GPEs anyway
> in the right place.
> 
> > What machines does it fix?
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7887

Some more clarification is necessary, I think.

Apparently, we can't drop the disabling of GPEs before the restore because of
Bug #7887 .  We also can't do it unconditionally, because the GPEs wouldn't be
enabled after a successful restore if the suspend was done in the 'shutdown' or
'reboot' mode.

In principle we could (and probably should) unconditionally disable the GPEs
before each snapshot creation *and* before the restore, but then we'd have to
unconditionally enable them after the snapshot creation as well as after the
restore (or restore failure)   Still, for this purpose we'd need to modify
acpi_enter_sleep_state_prep() and acpi_leave_sleep_state() and we'd have to
introduce some mechanism synchronizing the disablind/enabling of the GPEs with
the device drivers' .suspend()/.resume() routines and with
disable_/enable_nonboot_cpus().  The problem with this approach is that it
affects the suspend (ie. s2ram) code as well as the hibernation, which I'd like
to avoid, for now.

Moreover, I'm not quite certain in which points the GPEs should actually be
disabled and enabled.  For example, there are some testing data indicating that
the enabling of GPEs should be done after all of the device drivers' .resume()
callbacks have run.  For this reason we need to have a (temporary) flexible
design that would allow us to try different variants until we are sure which
one is correct.  I regard this particular patch as a step in that direction.

Greetings,
Rafael
