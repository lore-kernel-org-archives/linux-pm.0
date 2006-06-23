From: Greg KH <greg@kroah.com>
Subject: Re: cpufreq-related updates [WAS: Fix console handling
	during	suspend/resume]
Date: Fri, 23 Jun 2006 15:10:26 -0700
Message-ID: <20060623221026.GA30332@kroah.com>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606230926.26604.david-b@pacbell.net>
	<20060623203658.GA4264@neo.rr.com>
	<200606231448.32927.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606231448.32927.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 23, 2006 at 02:48:32PM -0700, David Brownell wrote:
> On Friday 23 June 2006 1:36 pm, Adam Belay wrote:
> > Moreover, we need similar stuff for PCI resource rebalancing =

> > (although this case would be partial tree suspending), a feature that
> > will likely become very necessary in the near future.
> =

> How about elaborating on what you mean by that?

Adam's referring to the "problem" that on some PCI hotplug systems, the
BIOS does not reserve a big enough space for all posible PCI devices
that could be plugged in while the system is running (laptop docking
stations, PCI Hotplug boxes, external PCI-E connections, etc.)  To solve
this issue, we _might_ have to stop some PCI devices while they are
running, reallocate their resources to make room for the new device, and
then resume them.

This is being touted as a feature in some future release of Vista (not
the first one), so for now the BIOS authors need to handle the issue
themselves and we are safe.  But the time may come that we need to
address this ourselves.  I'm guessing that Adam is thinking that the
suspend/freeze/whatever-you-want-to-call-it model might be the one to
help with this issue.

thanks,

greg k-h
