From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: Toward runtime power management in Linux
Date: Mon, 01 Aug 2005 14:44:46 +0300
Message-ID: <1122896686.2647.32.camel@localhost>
References: <Pine.LNX.4.44L0.0507302219250.13423-100000@netrider.rowland.org>
	<20050801021054.GA30859@best.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============54545936633207126=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050801021054.GA30859@best.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============54545936633207126==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-07-31 at 19:10 -0700, ext Leo L. Schwab wrote:

<snip>

> 
> > Idle-timeout RTPM: We certainly should have an API whereby userspace
> > can inform the kernel of an idle-timeout value to use for
> > autosuspending.  (In principle there could be multiple timeout values,
> > for successively deeper levels of power saving.)  This cries out to be
> > managed in a centralized way rather than letting each driver have its
> > own API.  It's not so clear what the most efficient implementation
> > will be.  Should every device have its own idle-timeout kernel timer?
> > (That's a lot of kernel timers.)

Per-device idle-timeouts are IMHO important in embedded space where one
wants finer-grained control. e.g. Sometimes it might be better to just
let a device be active to avoid wake-up latencies from power-save mode.
Also, some application usage profiles might dictate changes in
idle-timeout values to allow optimisation for the common use-cases.

> 	Whether you do it in user space or kernel space, you're going to
> potentially schedule a lot of timers.
> > Or should the RTPM kernel thread
> > wake up every second to scan a list of devices that may have exceeded
> > their idle timeouts?
> >
> 	This could potentially make performance-conscious apps "hiccup"
> once every second as this thread goes walking the list looking for
> candidates to shut off.  Try to avoid this; if nothing is happening, nothing
> should be running.

Whether the idle-timeout is implemented using kernel timers or a kernel
thread checking for timeout values, is a more difficult question.
Ideally, we would want to avoid unnecessary (processor) wakeups simply
to check a list of timeout values. Dynamic tick patch allows us to
wakeup the processor only when there is work to do - timers set to go
off. So, that's one strike against the kernel thread approach. 

But it needs more thinking.

> > Userspace support: It's easy to see how userspace could use sysfs to
> > request a single device state change.  But what if the user wants to
> > suspend an entire subtree?  [ ... ]
> 
> 	If you wanted to get really fancy, you could establish via a
> userspace API a named "device collection" which acts as a virtual device.
> You then apply the state change to the device collection, and the kernel
> percolates it through all the actual devices, taking locking into account.
> 
> 					Schwab

If I tell a bus to power down, couldn't the PM framework take care of
recursively sending 'power down' message to all children, wait for
confirmation, and then power itself down?

Regards,
Amit
-- 
Amit Kucheria <amit.kucheria@nokia.com>
Nokia

--===============54545936633207126==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============54545936633207126==--
