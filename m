From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Tue, 3 Feb 2009 15:30:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902031526040.2272-100000@iolanthe.rowland.org>
References: <d6200be20902022018k7fda9120yb7321f5341050ce8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902022018k7fda9120yb7321f5341050ce8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Mon, 2 Feb 2009, Arve Hj=F8nnev=E5g wrote:

> >> Also, what do you mean by a runtime PM interface?
> >
> > I'm making a distinction between system PM and runtime (also known as
> > dynamic) PM.  With system PM the entire system goes into a low-power
> > state -- that's what we mean when we talk about suspend or hibernation.
> > With runtime PM the system as a whole remains running while selected
> > devices are individually put into a low-power state.
> >
> > For example, right now Linux will put a USB host controller into a
> > low-power state if no USB devices are plugged into it.  This runtime PM
> > interface is described in Documentation/usb/power-management.txt.  You
> > might want to use some of those mechanisms for controlling your
> > devices.
> =

> OK, but I don't think this affects our use of wakelocks.

No, but it might very well affect your implementation of early-suspend.

> I'll make a change to make any write to /sys/power/state disable
> wakelocks. I'll probably also add a config option to remove
> /sys/power/state.
> =

> Before I post another patch series I have a few questions:
> - Should I merge the wakelock and early-suspend api patches with their
> implementations? (I initially implemented the api on top of the old
> android_power driver, but we not longer use this)

It depends how big the patches are.  If they're not too large, go ahead =

and merge the API patch with the implementation.  But if they're =

difficult to read because they are rather big, keep them separate.

> - Once wakelocks are disabled by writing to /sys/power/state, is there
> any demand for re-enabling wakelock support?

I don't know.  You might as well re-enable it as soon as the system =

resumes.

> - Are there any objections to using /sys/power/request_state to
> specify the state to enter when all wakelocks unlocked.

Okay with me.

Alan Stern
