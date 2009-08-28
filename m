From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 8] PM: Allow user space to change
	the	power.async_suspend flag of devices
Date: Fri, 28 Aug 2009 09:01:25 +0200
Message-ID: <20090828070124.GB27928__38462.6196967021$1251442969$gmane$org@elf.ucw.cz>
References: <200908262217.19609.rjw@sisk.pl> <200908272120.56021.rjw@sisk.pl>
	<20090827203634.372EC526EC9@mailhub.coreip.homeip.net>
	<200908280024.06082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908280024.06082.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-08-28 00:24:06, Rafael J. Wysocki wrote:
> On Thursday 27 August 2009, Dmitry Torokhov wrote:
> > Hi Rafael,
> > 
> > On Thu, Aug 27, 2009 at 09:20:55PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Add sysfs attribute power/async for every device allowing the user
> > > space to access the device's power.async_suspend flag and modify it,
> > > if necessary.
> > > 
> > 
> > I don't think we should let users meddle with individual devices;
> > one global flag should be enough to work around "broken-at-the-moment"
> > issues.
> 
> Well, this patch is handy for testing if anyone is interested, so I posted it.
> 
> It isn't exactly safe, though, you're right.

I guess it would be acceptable to let the users disable it
per-driver... but if we can get without that, it would be better.

(it is obviously ok for debugging).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
