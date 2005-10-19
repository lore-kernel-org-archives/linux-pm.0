From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 0/3] Runtime PM support for named power states
Date: Wed, 19 Oct 2005 11:17:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510191055190.5049-100000@iolanthe.rowland.org>
References: <1129682098.7620.160.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19662908726843753=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1129682098.7620.160.camel@gaston>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============19662908726843753==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 19 Oct 2005, Benjamin Herrenschmidt wrote:

> On Fri, 2005-09-30 at 16:14 -0400, Alan Stern wrote:
> 
> > Updated documentation, comments, and the code itself explain pretty well
> > how this works.  In brief, the dev_pm_info structure has a new field
> > containing a pointer to a null-terminated list of state names.  There's
> > also a pointer to the name of the state to be used for a generic runtime
> > suspend.  The sysfs routines will display these names and match input
> > against them.  They will also continue to recognize the old state numbers
> > (0 - 3) and will use them for devices without support for named power
> > states.
> 
> A couple of things: Is it worth adding some void* with every state to be
> used by the device ? (Or maybe to be made bus specific) that provides
> additional infos that can be defined per bus ?
> 
> Things like operational power consumption per state, stuff like that ? 

Remember that this was just a preliminary patch.  It made minimal changes; 
the stuff you're talking about can always be added on later.

On the other hand, I'm not sure where this additional information should
be displayed.  The sysfs power/state file wouldn't be a good place; I'm
already pushing the limits of what you're supposed to put in these files
by listing all the available states with aliases and a "current-state"  
indicator.  Maybe you'd like to add a new attribute file under the power/
directory for this?

> Also, you don't expose any state dependency here. How do you plan to
> handle that ?

The PM core can't handle it, since the core doesn't know what the
requirements are for each kind of device.  Drivers will have to handle
intra-device dependencies themselves, by returning an error code when
asked to make a state transition they can't perform.

Inter-device dependencies will be handled by a mechanism I haven't coded 
up yet.  It will amount to a bus- or device-specific way for a driver to 
receive notifications from the drivers of its device's children.  The 
driver will then be able to change the device's state to meet the 
requirements of the children.

> > Particularly vexing was the use of a pm_message_t to store a device's
> > current state.  The event field in pm_message_t doesn't represent a power
> > state; it represents a _reason_ for a state transition. 
> 
> Yes. One of the reason it was changed to "int state" to "pm_message_t"
> was to make the type more explicitely matching what it really is. As I
> wrote several times, I woudl prefer _different_ callbacks for the new
> names state mecanism.

I don't see why.  Most of the work these callbacks have to do would end up
being the same.  Besides, do you then want to add even more callbacks for
suspend caused by inactivity timeout and resume caused by I/O requests?  
No, I think we're better off with minimal callbacks and the "event" code
in pm_message_t indicating the reason for the callback.

> >  Nevertheless, the
> > current code insists on using it to identify states.  This means that even
> > though a runtime change may leave a device in the state needed for system
> > suspend, the core won't realize it because the state was entered for the
> > wrong reason!  This is so widespread I didn't try to change it.  Instead I
> > decided that PM_EVENT_ON would be synonymous with the default (i.e., first
> > or full-power) entry in the state name array.
> 
> No, I'd rather fix it all :)

That will be hard to do until all the drivers are converted.  My proposal 
at least lets us implement the changes a piece at a time.

> > The runtime PM routines insist on storing values in
> > dev->power.power_state.  This seems foolish since the system PM routines 
> > don't do it.  In any case, what gets stored there should be decided by the 
> > driver, not by the core.  Presumably these stores could be removed, but I 
> > wasn't sure so I left them in.
> 
> Yes, there is some inconsistency there

I've decided to take out the lines where the runtime PM routines overwrite 
the value in dev->power.power_state.  Drivers alone should maintain that 
field.

> > Finally, there's no obvious mapping between the PM_EVENT_FROZEN and 
> > PM_EVENT_SUSPENDED values and the new named states.  Obviously devices 
> > will be left in _some_ state, but the PM core can't tell which.  This will 
> > show up in the sysfs file if you write a number from 1 to 3; instead of 
> > displaying a named state the file will now just display the number.
> 
> That's why I'd like to have the old routines do the mapping (or do
> nothing) and separate new routines to handle named states.

There's no reason the old routines can't do the mapping when the event
code is PM_EVENT_SUSPEND or PM_EVENT_FREEZE, while still using the
explicit named state when the event is PM_EVENT_RUNTIME.  This can even be
handled at the bus-level, so that individual drivers won't have to worry
about it.

Alan Stern


--===============19662908726843753==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============19662908726843753==--
