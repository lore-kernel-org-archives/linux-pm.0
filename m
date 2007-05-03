From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Thu, 3 May 2007 21:47:30 +0200
Message-ID: <200705032147.31370.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705031401580.7259-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705031401580.7259-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 20:33, Alan Stern wrote:
> On Thu, 3 May 2007, Rafael J. Wysocki wrote:
> 
> > > In fact, shouldn't the poweroff at the end of a hibernate be exactly the 
> > > same as a normal non-hibernate poweroff?
> > 
> > Not quite (see (*) below).
> 
> > The problem, generally speaking, is that we have to prepare devices for waking
> > up the system.  On an ACPI system this is done, among other things, by
> > executing the devices' _PSW control methods after the system-level _PTS method
> > has run.  For this purpose the devices must be in (low) power states from which
> > the wake is possible, so in particular they must not be powered off.  Later, by
> > making the platform enter the suspend-to-disk (ACPI S4) state we prevent it
> > from powering off the wake-up devices, among other things.

The last sencence in the above paragraph is not actually true, sorry for the
confusion.

> > That's why I'm thinking that it might be a good idea to do a
> > suspend-before-poweroff, but it doesn't mean that device drivers would be
> > allowed to make any assumptions regarding the state of the device after the
> > resume.  IMO, if this is a resume from disk, devices should be initialized from
> > scratch.
> 
> I generally agree with your last sentence, but with one reservation (see 
> below).
> 
> As for the rest, you missed my point.  Granted that all these special 
> activities are required on ACPI systems in order to support proper 
> operation of wakeup devices -- Why shouldn't these same steps also be 
> followed during a normal poweroff?
> 
> There really are two orthogonal issues here:
> 
> 	(1) Is this a "hibernate" poweroff (as opposed to a "normal" 
> 	    poweroff)? 
> 
> 	(2) Should some devices remain minimally powered and be capable
> 	    of waking up the system?
> 
> I don't see any necessary relation between the answers to (1) and (2).  In 
> particular, I don't see why a Yes answer to (1) should imply a Yes answer 
> to (2).
> 
> This suggests that the poweroff methods be completely independent of
> hibernation_ops (or whatever you are now calling it).  Perhaps there
> should be a separate sysfs attribute controlling whether or not wakeup is
> enabled.  If it is then poweroff should go through all the ACPI (or the
> platform's equivalent) hoops, otherwise everything should just be turned
> off completely.  Regardless of whether the poweroff is part of a
> hibernate sequence.

Well, after reviewing the code once again I see that we already do it this
way on ACPI systems, since the 'normal' power off is done by entering the
ACPI S5 state.  Moreover, there shouldn't be any difference between
ACPI S4 and 'power off' with respect to the wake-up devices, so you're
absolutely right.

It seems, though, that we need to do acpi_enter_sleep_state(ACPI_STATE_S4)
to finish the hibernation in order to avoid problems like (*) and for this purpose
we need to use hibernation_ops earlier during the hibernation.

> > (*) Another issue is that, for example, on my notebook the status of the AC
> > power supply (and sometimes of the battery too) is not reported correctly by
> > the platform after the resume if the suspend-to-disk (ACPI S4) state has not
> > been entered during the hibernation. I don't understand why this happens, but
> > I'm going to find out.
> 
> Hopefully it's not directly related to the matter under discussion. :-)
> 
> 
> There remains one issue associated with always reinitializing devices 
> during resume from hibernation.  In the one area I know a lot about (USB) 
> this actually does matter, at least a little.
> 
> The USB specs include the notion of a "power session", which is
> essentially an uninterrupted continuous connection between the host and
> the device.  As long as a power session exists, the host is guaranteed
> that the device has not been unplugged or replaced with a different
> device.
> 
> On most systems, hibernation breaks power sessions.  When the system wakes 
> back up it sees a bunch of USB devices connected, but it is not allowed 
> (by the spec!) to assume that these are the same devices as were attached 
> before.  In fact, some of them might not be.
> 
> Mostly this doesn't make any difference, but for mass-storage it does.  
> Memory mappings and filesystem mounts will be disrupted when the
> underlying logical device goes away, even if the same physical device is
> still attached to the same port.  This has caused significant headaches
> for USB users in the past.
> 
> On the other hand, some systems are designed cleverly enough to maintain
> power sessions across hibernation.  Not many -- the only ones I've heard
> about were all PPC Macs.  The USB drivers have always tried to keep power
> sessions intact across hibernation whenever the hardware and firmware
> would permit, but of course reinitializing the USB controller would
> destroy them.

That seems to be one of the really rare cases in which a device driver can
actually make sure that the device is in certain state after the hibernation on
the basis of information provided by the device itself, so it doesn't need to
make any assupmtions.  In such cases it might be possible not to reinitialize
the device, but that would have to be handled with much care.

Greetings,
Rafael
