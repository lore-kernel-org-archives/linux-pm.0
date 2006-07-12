From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Wed, 12 Jul 2006 12:03:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607121200280.7363-100000@iolanthe.rowland.org>
References: <200607120845.47410.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607120845.47410.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Jul 2006, David Brownell wrote:

> > Is that last bit really right?  The PM core records each device's power =

> > state when beginning a system sleep, and it tries to arrange to leave t=
he =

> > device in that same state when the sleep ends.  This may involve a =

> > transition through the fully-on state...  I'm not clear on the details.
> =

> I think the PM core should stop recording _its_ notion of the power state,
> but that's a different discussion.
> =

> Yes that bit is right, it's just emphasizing that there _is_ a state mach=
ine
> in the driver (or should be!), and that with runtime power management it's
> not going to be in lock-step with system suspend/resume transitions.  That
> is after all the whole point of runtime device PM:  to decouple from those
> system-wide transitions so that "system on" needn't imply "device on".

One oddity worth mentioning somewhere is that the PM core will never ask a
driver to make a transition between two states unless one of them is ON.  =

This can sometimes lead to unexpected effects, some of which might show up =

during a system resume.

Alan Stern
