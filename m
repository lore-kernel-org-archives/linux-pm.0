From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] why do we need run disk sync before	entering?S3
Date: Sat, 23 May 2009 10:50:18 +0200
Message-ID: <20090523085018.GA8782__40538.0645687275$1243068758$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	<1242631507.16529.107.camel@rzhang-dt>
	<20090522153356.GB27655@elf.ucw.cz>
	<200905230959.23018.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905230959.23018.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat 2009-05-23 09:59:22, Oliver Neukum wrote:
> Am Freitag, 22. Mai 2009 17:33:57 schrieb Pavel Machek:
> > > Take ACPI for example, ACPI defines two ACPI battery states, one is
> > > "low" and another is "critical".
> > > OS enters S3/S4 when battery is low, while it performs an emergency
> > > shutdown when battery is in critical state. (ACPI spec 3.0b 3.9.4)
> > > So I'm wondering if it's right to enter S3 when we know that the system
> > > may lost power at anytime.
> >
> > Well, battery only lasts like 30 hours in S3. So if you leave your
> > notebook unattended for 30 hours, you'll loose recent changes.
> 
> Even if the battery is very low you get 30 hours?

That will of course be less. 30 hours is really best case, on "good"
notebook.

What I was trying to point out is that even if you go into s3 with
machine fully charged, you'll loose your data after like 30 hours.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
