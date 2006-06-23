From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 16:36:58 -0400
Message-ID: <20060623203658.GA4264@neo.rr.com>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
	<1151019097.4046.69.camel@localhost.localdomain>
	<200606230926.26604.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606230926.26604.david-b@pacbell.net>
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

On Fri, Jun 23, 2006 at 09:26:26AM -0700, David Brownell wrote:
> On Thursday 22 June 2006 4:31 pm, Benjamin Herrenschmidt wrote:
> >  - cpufreq (this is a design bug with cpufreq with the "core/midlayer"
> > trying to get in charge instead of the driers and registering a sysdev
> > which is very wrong).
> =

> That could stand some elaboration in a separate thread; there are folk
> working to enhance cpufreq so that it handles other frequency/voltage
> scaling approaches.  I happened to notice that cpufreq isn't even using
> the driver model very well, too ...

On a related note, let's remember that cpufreq needs a sort of "FREEZE"
functionality, on some platforms, before transitioning the cpu operating
point.  Moreover, we need similar stuff for PCI resource rebalancing
(although this case would be partial tree suspending), a feature that
will likely become very necessary in the near future.  It would be nice
if the suspend model was robust enough to handle these runtime device
suspend cases as well.

Thanks,
Adam
