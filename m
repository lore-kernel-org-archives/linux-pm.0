From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: comments on irc log
Date: Fri, 18 Mar 2005 11:56:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503181147110.1099-100000@ida.rowland.org>
References: <1111113131.25179.73.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============47094714442081043=="
In-Reply-To: <1111113131.25179.73.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============47094714442081043==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 18 Mar 2005, Benjamin Herrenschmidt wrote:

> I have this crazy idea that we could have a single "new" enter_state(), and keep
> suspend/resume for system state transitions.
> 
> Basically, my idea there is that enter_state() is the actual low level driver
> state change function. It is called when userland picks a state in sysfs, or
> we could deal with the various bus state dependencies if we want etc...
> 
> We could keep suspend/resume separate for the system-wide suspend, and have
> them implement the policy of converting a system wide suspend/resume into the
> appropriate enter_state() for the driver.
> 
> "Old" or "Simple" drivers would just suspend/resume and not implement
> enter_state, more complex/subtle drivers would do the above.
> 
> I haven't quite thought out the implications, it's just an idea that came to mind
> as I was reading the log...

This sounds like a reasonable thing to do.  We do need distinct ways to
tell drivers "Go to this system state" and "Go to this bus/device state".  
Whether they are implemented by 1, 2, or 3 different callbacks doesn't
really matter (except that we might want to minimize the number of 
function pointers stored in the driver structures).

> Yes, partial tree suspend. It was decided that we would bother about it when we have the stuff
> working well enough as it is though :) If we start going to device local states, sysfs originated
> transitions, etc, though, we'll probably end up with a mecanism capable of that. That is
> triggering a wake of the storage device which will "cascade" upward along the tree.

Absolutely; something like that is needed for runtime resume-on-demand.

> Note that entering FREEZE and exiting it is very fast. Currently, we suspend everything tho, but
> once drivers start knowing the difference, it will be as there is no HW PM to be done.

Usually very fast.  Unfortunately for some kinds of USB host controllers 
it can be relatively slow, since quiescing the controller has an 
unavoidable side effect of suspending all devices on the bus.

Alan Stern


--===============47094714442081043==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============47094714442081043==--
