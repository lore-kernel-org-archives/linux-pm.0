From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] why do we need run disk sync before	entering?S3
Date: Sat, 23 May 2009 11:45:18 +0200
Message-ID: <20090523094518.GB8782__6426.66373537413$1243072081$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	<200905230959.23018.oliver@neukum.org>
	<20090523085018.GA8782@elf.ucw.cz>
	<200905231105.03828.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905231105.03828.oliver@neukum.org>
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

Hi!

> > That will of course be less. 30 hours is really best case, on "good"
> > notebook.
> >
> > What I was trying to point out is that even if you go into s3 with
> > machine fully charged, you'll loose your data after like 30 hours.
> 
> OK, I see so this was an argument for syncing. Sorry for
> misunderstanding.

Yes; we need to sync.

> But we'd still loose RAM. Which makes me wonder whether S3 and STD
> really need to be mutually exclusive. Couldn't we write a snapshot to disk
> just in case. All it would take is the STR code to mark the snapshot invalid
> before any alteration of the filesystems.

suspend.sf.net, program s2both :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
