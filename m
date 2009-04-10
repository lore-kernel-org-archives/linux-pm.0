From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC Disable suspend on a specific device] This is
	a	little change in linux power scheme
Date: Fri, 10 Apr 2009 13:17:14 +0200
Message-ID: <20090410111714.GA26610@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0904071729210.307-100000@netrider.rowland.org>
	<200904072340.53638.rjw@sisk.pl>
	<20090408115330.GL20122@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090408115330.GL20122@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed 2009-04-08 12:53:30, Mark Brown wrote:
> On Tue, Apr 07, 2009 at 11:40:53PM +0200, Rafael J. Wysocki wrote:
> 
> > IMO, there is a danger that suspend will break or even the machine will crash
> > if this is used for a wrong device.  I don't think it's generally safe to add
> > switches like this on the core level, because the core doesn't really know
> > which drivers are prepared for it.
> 
> OTOH it would be good to have a standard way of exposing this behaviour
> to user space when it can be supported so that applications have some
> degree of abstraction when working with these systems and drivers don't
> have to keep on cooking up their own methods of exposing it.

Well, "standard way of exposing the behaviour" is quite useless if it
leads to kernel crashes, right? Those drivers that can do it can do it
themselves. And yes, they should all use the same interface.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
