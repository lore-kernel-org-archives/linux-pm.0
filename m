From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation	patchset against -rc6)
Date: Wed, 19 Mar 2008 21:24:12 +0100
Message-ID: <20080319202412.GB1811__5960.4088114158$1205958550$gmane$org@elf.ucw.cz>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
	<20080318225201.GA2115@elf.ucw.cz>
	<alpine.LFD.1.00.0803181736340.3020@woody.linux-foundation.org>
	<20080319101947.GA2963@elf.ucw.cz>
	<alpine.LFD.1.00.0803190741490.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803190741490.3020@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-03-19 07:42:36, Linus Torvalds wrote:
> 
> 
> On Wed, 19 Mar 2008, Pavel Machek wrote:
> >
> > > > It will take a while. My .git directory is 7G, and I'd like to do a
> > > > backup before playing with git.
> > > 
> > > Ouch, what have you done? It should be about 200MB, not 7GB.
> > 
> > And 10 minutes later, .git directory is 200MB. Thanks!
> 
> It strikes me that the only way I can think of that you could have gotten 
> a 7GB .git directory without really working at it is if you use one of the 
> so-called "dumb" git protocols that just copy whole packfiles from 
> kernel.org when you pull.
> 
> So do you happen to perhaps use http:// or rsync:// when you fetch git 
> data? That would not only be horribly slow occasionally (you'd fetch 

I was using rsync... should be fixed now. Thanks!

> all-new packs and re-download about 200MB of data when I repack the kernel 
> repo on kernel.org, which happens about once or twice every release 
> cycle), but it would also explain how it ballooned to 7GB for you (because 
> you have all these duplicate packs!).

Well, I thought that it is pulling a bit too much, but I attributed
that to our fast development ;-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
