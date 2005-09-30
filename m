From: Alan Stern <stern@rowland.harvard.edu>
Subject: [RFC 0/3] Runtime PM support for named power states
Date: Fri, 30 Sep 2005 16:14:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============95431951083192379=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============95431951083192379==
Content-Type: TEXT/PLAIN; charset=US-ASCII

This series of patches presents the beginnings of serious runtime PM
support.  It's not meant to be applied as is; the code is more like a
proof-of-principle.  It would be surprising if people didn't have a number
of suggestions for improvements.  And in any case, one portion of it is
far from complete.

What these patches do is introduce support for named power states.  The
first patch contains the core changes, and the other two contain updates
for PCI and USB respectively.  Note that the PCI update is barely
functional; the only PCI driver I changed is the one for the PCI USB
controllers.  Other PCI drivers won't understand the new data fields, so
you shouldn't try to change their power levels using the new named states!

Updated documentation, comments, and the code itself explain pretty well
how this works.  In brief, the dev_pm_info structure has a new field
containing a pointer to a null-terminated list of state names.  There's
also a pointer to the name of the state to be used for a generic runtime
suspend.  The sysfs routines will display these names and match input
against them.  They will also continue to recognize the old state numbers
(0 - 3) and will use them for devices without support for named power
states.

There are at least two more patches on the way, to implement state change 
notifications and auto-suspend/resume.  Stay tuned...

Although it may not show up very clearly, these patches -- especially the 
first -- are running up against the limitations and bad design choices 
originally made for the PM core.

Particularly vexing was the use of a pm_message_t to store a device's
current state.  The event field in pm_message_t doesn't represent a power
state; it represents a _reason_ for a state transition.  Nevertheless, the
current code insists on using it to identify states.  This means that even
though a runtime change may leave a device in the state needed for system
suspend, the core won't realize it because the state was entered for the
wrong reason!  This is so widespread I didn't try to change it.  Instead I
decided that PM_EVENT_ON would be synonymous with the default (i.e., first
or full-power) entry in the state name array.

A consequence of this folly shows up when a device has been put in a
low-power state using sysfs and then suspend-to-disk is done.  The device
will first be woken up, just so it can be frozen, then woken up again, and
finally suspended -- ending up in the very state it started from!

The runtime PM routines insist on storing values in
dev->power.power_state.  This seems foolish since the system PM routines 
don't do it.  In any case, what gets stored there should be decided by the 
driver, not by the core.  Presumably these stores could be removed, but I 
wasn't sure so I left them in.

Finally, there's no obvious mapping between the PM_EVENT_FROZEN and 
PM_EVENT_SUSPENDED values and the new named states.  Obviously devices 
will be left in _some_ state, but the PM core can't tell which.  This will 
show up in the sysfs file if you write a number from 1 to 3; instead of 
displaying a named state the file will now just display the number.

Alan Stern


--===============95431951083192379==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============95431951083192379==--
