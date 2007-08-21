From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 2/4] Hibernation: Turn on ACPI
	during restore if necessary
Date: Wed, 22 Aug 2007 01:36:29 +0200
Message-ID: <20070821233629.GA3706@elf.ucw.cz>
References: <200708201510.03734.rjw@sisk.pl> <200708201516.03537.rjw@sisk.pl>
	<20070821075755.GF7258@elf.ucw.cz> <200708211639.02204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708211639.02204.rjw@sisk.pl>
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
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Tue 2007-08-21 16:39:01, Rafael J. Wysocki wrote:
> On Tuesday, 21 August 2007 09:57, Pavel Machek wrote:
> > Hi!
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > If the boot kernel doesn't support ACPI and ACPI is not enabled by the platform
> > > boot code, it may be possible to enable ACPI after restoring the system memory
> > > from a hibernation image.  Implement that.
> > 
> > ACK... and I guess this should go in early. It is possible to test w/o
> > rest of patches, (just pass acpi=off to resume kernel, no?),
> 
> Yup, that might work.
> 
> > and it  should get lot of testing.
> 
> Why do you think so?

Anything that touches acpi is almost guaranteed to produce nice
fireworks :-). Okay, maybe I'm too paranoid.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
