From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 0/3] Runtime PM support for named power states
Date: Wed, 19 Oct 2005 10:34:57 +1000
Message-ID: <1129682098.7620.160.camel@gaston>
References: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============87326229006812661=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============87326229006812661==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-09-30 at 16:14 -0400, Alan Stern wrote:

> Updated documentation, comments, and the code itself explain pretty well
> how this works.  In brief, the dev_pm_info structure has a new field
> containing a pointer to a null-terminated list of state names.  There's
> also a pointer to the name of the state to be used for a generic runtime
> suspend.  The sysfs routines will display these names and match input
> against them.  They will also continue to recognize the old state numbers
> (0 - 3) and will use them for devices without support for named power
> states.

A couple of things: Is it worth adding some void* with every state to be
used by the device ? (Or maybe to be made bus specific) that provides
additional infos that can be defined per bus ?

Things like operational power consumption per state, stuff like that ? 

Also, you don't expose any state dependency here. How do you plan to
handle that ?

> Particularly vexing was the use of a pm_message_t to store a device's
> current state.  The event field in pm_message_t doesn't represent a power
> state; it represents a _reason_ for a state transition. 

Yes. One of the reason it was changed to "int state" to "pm_message_t"
was to make the type more explicitely matching what it really is. As I
wrote several times, I woudl prefer _different_ callbacks for the new
names state mecanism.

>  Nevertheless, the
> current code insists on using it to identify states.  This means that even
> though a runtime change may leave a device in the state needed for system
> suspend, the core won't realize it because the state was entered for the
> wrong reason!  This is so widespread I didn't try to change it.  Instead I
> decided that PM_EVENT_ON would be synonymous with the default (i.e., first
> or full-power) entry in the state name array.

No, I'd rather fix it all :)

> A consequence of this folly shows up when a device has been put in a
> low-power state using sysfs and then suspend-to-disk is done.  The device
> will first be woken up, just so it can be frozen, then woken up again, and
> finally suspended -- ending up in the very state it started from!
> 
> The runtime PM routines insist on storing values in
> dev->power.power_state.  This seems foolish since the system PM routines 
> don't do it.  In any case, what gets stored there should be decided by the 
> driver, not by the core.  Presumably these stores could be removed, but I 
> wasn't sure so I left them in.

Yes, there is some inconsistency there

> Finally, there's no obvious mapping between the PM_EVENT_FROZEN and 
> PM_EVENT_SUSPENDED values and the new named states.  Obviously devices 
> will be left in _some_ state, but the PM core can't tell which.  This will 
> show up in the sysfs file if you write a number from 1 to 3; instead of 
> displaying a named state the file will now just display the number.

That's why I'd like to have the old routines do the mapping (or do
nothing) and separate new routines to handle named states.

Ben.



--===============87326229006812661==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============87326229006812661==--
