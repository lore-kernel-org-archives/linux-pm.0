From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [suspend/resume] Re: userspace notification from
	module
Date: Mon, 4 Jan 2010 20:45:44 +0100
Message-ID: <201001042045.44372.rjw__1228.68075636706$1262634376$gmane$org@sisk.pl>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001040045.39517.rjw@sisk.pl> <4B41E318.4050809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B41E318.4050809@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Borkmann <danborkmann@googlemail.com>
Cc: =?iso-8859-2?q?Bart=B3omiej_Zimo=F1?= <uzi18@o2.pl>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, awalls@radix.net
List-Id: linux-pm@vger.kernel.org

On Monday 04 January 2010, Daniel Borkmann wrote:
> Rafael J. Wysocki wrote:
> > On Monday 04 January 2010, Bart=B3omiej Zimo=F1 wrote:
> >> And what do You think about sending extra signals to processes?
> > =

> > I don't see a problem with this in principle, although I don't think si=
gnals
> > are very suitable for this particular purpose, because you need two-way
> > communication between the power manager and the processes it's going to
> > notify (because it has to wait for the processes to finish their prepar=
ations
> > and to tell it that they are ready).
> =

> Again, just to abandon some thoughts... do you really need that "two-way
> communication"? I mean if the kernel delivers that specific signal to
> the process/task_struct [do_signal():handle_signal()] it has to save the
> original execution context that will later on be restored after the
> non-default signal handling function returns. This is our ACK /
> notification for the successful return of the programs "suspend
> handler". The kernel module (if such exists) could be notified about
> that for instance by a simple notifier hook within kernelspace. I mean
> if I see this right, the "two-way" is just for the ACK isn't it?

_If_ the kernel sends the signals, which is not I think should be done.

Please keep that in the user space.  Really.

I don't see _any_ good reason for putting such things into the kernel.

Rafael
