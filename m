From: Greg KH <greg@kroah.com>
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Date: Thu, 22 Jun 2006 14:11:57 -0700
Message-ID: <20060622211157.GA15669@kroah.com>
References: <449AFFAD.2030601@gmail.com>
	<Pine.LNX.4.44L0.0606221706450.5772-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606221706450.5772-100000@iolanthe.rowland.org>
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
Cc: linux-pm@osdl.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 22, 2006 at 05:09:43PM -0400, Alan Stern wrote:
> On Thu, 22 Jun 2006, Jiri Slaby wrote:
> =

> > > ages.  The "bogus requests" are attempts by the user to suspend a USB
> > > device (by writing to /sys/devices/.../power/state) without first
> > > suspending all its children and interfaces.
> > > =

> > > (This can't happen when doing a global suspend because the PM core =

> > > iterates through the entire device tree.  It matters only for "runtim=
e" or =

> > > "selective" suspend.)
> > =

> > But everything I did is:
> > echo reboot > /sys/power/disk
> > echo disk > /sys/power/state
> > =

> > No writing anywhere else.
> =

> You misunderstood.  I meant that attempts to suspend a USB device without =

> first suspending all its children and interfaces can't happen when doing =
a =

> global suspend.  That's still true.
> =

> Your problem occurred because even though the PM core did _attempt_ to =

> suspend the new children added by Greg's patch, it didn't _succeed_ =

> because the patch did not provide suspend or resume methods.

Which because they are virtual "devices" they do not need a suspend or
resume method, so not having any is just fine.  If we abort because of
something like this, the core logic is quite broken...

thanks,

greg k-h
