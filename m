From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 22:28:19 +0200
Message-ID: <201005052228.19851.rjw__15030.6700067178$1273094792$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005051554490.1885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005051554490.1885-100000@iolanthe.rowland.org>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 05 May 2010, Alan Stern wrote:
> On Wed, 5 May 2010, Matthew Garrett wrote:
> 
> > On Wed, May 05, 2010 at 03:20:40PM -0400, Alan Stern wrote:
> > 
> > > One the face of it, a runtime-PM solution would dictate that the
> > > codec's driver ought to turn off the codec whenever the driver thinks
> > > it isn't being used.  Ergo, if the driver didn't know when a call was
> > > in progress, it would use runtime PM to turn off the codec during a
> > > call.
> > 
> > Well, part of the problem is that right now most of our beliefs about 
> > imposed constraints tend to be based on what userspace is doing - "Don't 
> > power down the audio codec when userspace has it open", for instance. 
> > But that goes away with opportunistic suspend. In most cases you don't 
> > want the audio codec to stay awake just because userspace was using it 
> > to make bouncing cow noises, especially if you've just frozen userspace. 
> > So the problem becomes more complicated than it would otherwise be.
> 
> It sounds like the problem can be stated simply enough: At the moment, 
> nobody knows when the codec should be powered down!  Userspace might 
> have some idea, but even if its ideas are right it has no way of 
> communicating them to the kernel.
> 
> The power/control sysfs attribute was intended for just that purpose,
> although it was aimed at runtime PM rather than system PM.  
> Nevertheless, it or something like it could be used.  Of course, there 
> would still remain the issue of userspace telling the kernel not to 
> power down the codec while making bouncing cow noises -- but at this 
> point it's not really a kernel problem any more.

We'd need a separate control, I think.  The problem is, though, that the
Android user space, for example, doesn't use the sysfs attributes of devices,
so this control wouldn't be particularly useful for it.

> P.S.: What happens if a suspend occurs while a call is in progress, so
> the codec is left powered up, and then the call ends?  Does the system
> wake up at that point?  Or does it stay suspended with the codec still
> powered, even though it's not needed any more?

I guess you end up telling the user that the call ended, so the system wakes up.
That's only a guess, though.

Rafael
