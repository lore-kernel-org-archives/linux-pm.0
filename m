From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Memory consumption difference between in-kernel
	and	userspace hibernation
Date: Sat, 21 Nov 2009 10:29:12 +0100
Message-ID: <20091121092911.GA1932@ucw.cz>
References: <20091112210155.0f9bbe5d@surf> <200911122152.02671.rjw@sisk.pl>
	<20091112221223.3459b8cc@surf> <200911132105.07812.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911132105.07812.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2009-11-13 21:05:07, Rafael J. Wysocki wrote:
> On Thursday 12 November 2009, Thomas Petazzoni wrote:
> > Hello,
> > 
> > Thanks for your feedback.
> > 
> > Le Thu, 12 Nov 2009 21:52:02 +0100,
> > "Rafael J. Wysocki" <rjw@sisk.pl> a ??crit :
> > 
> > > The userspace interface doesn't really allow you to write to a file.
> > > You can write into the area the file occupies on the partition, but
> > > you can't use the filesystem code for the actual writing.  At least
> > > you shouldn't do that.
> > 
> > Ah. But it seems to work fairly nicely. Why can't the filesystem code
> > could be used to store the resume image ? Note that my file is stored
> > in a separate partition, fully dedicated to storing the resume file and
> > mounted only at very specific points in the system lifetime.
> 
> That doesn't really matter.
> 
> The problem is that the image is likely to contain filesystem data (eg.
> superblocks etc.) that correspond to the state before the image has been
> created.  Now, your using the filesystem code for writing the image modifies
> the on-disk metadata which become inconsistent with the filesystem data in
> the image.  This inconsistencies may very well result in an unfixable
> corruption of the file system after the resume (that actually happened to
> a number of people, so it's not just pure theory).
> 
> That really depends on the fileystem used, though.

But based on  his description... if fs is only mounted after atomic
snapshot... it actually should be safe.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
