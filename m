From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Toward runtime power management in Linux
Date: Mon, 1 Aug 2005 10:16:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508011008180.4961-100000@iolanthe.rowland.org>
References: <1122896686.2647.32.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============84482948764668109=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1122896686.2647.32.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============84482948764668109==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 1 Aug 2005, Amit Kucheria wrote:

> Per-device idle-timeouts are IMHO important in embedded space where one
> wants finer-grained control. e.g. Sometimes it might be better to just
> let a device be active to avoid wake-up latencies from power-save mode.
> Also, some application usage profiles might dictate changes in
> idle-timeout values to allow optimisation for the common use-cases.

There's no question about having per-device idle timeouts, or about
letting userspace set the timeout values (or make the value be infinite so
there is no idle timeout ever).  The question is how to implement them:
using kernel timers or using a kernel thread?  Note that having some sort
of thread available will be necessary in any case, since the actual
suspend/resume function calls require a process context.

> Whether the idle-timeout is implemented using kernel timers or a kernel
> thread checking for timeout values, is a more difficult question.
> Ideally, we would want to avoid unnecessary (processor) wakeups simply
> to check a list of timeout values. Dynamic tick patch allows us to
> wakeup the processor only when there is work to do - timers set to go
> off. So, that's one strike against the kernel thread approach. 
> 
> But it needs more thinking.

Yes, it's complex.  Constantly updating the timer expirations every time 
a device carries out an activity can also be expensive.


> If I tell a bus to power down, couldn't the PM framework take care of
> recursively sending 'power down' message to all children, wait for
> confirmation, and then power itself down?

Well sure, we _could_.  The question is, _should_ we?  Or should the 
kernel force you to tell each of the bus's children to power down before 
telling the bus?

Alan Stern


--===============84482948764668109==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============84482948764668109==--
