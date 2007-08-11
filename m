From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: encrypted hibernation (was Re: Hibernation
	considerations)
Date: Sun, 12 Aug 2007 00:43:56 +0100
Message-ID: <20070811234356.GA19183__8101.68201937831$1187015131$gmane$org@gallifrey>
References: <200707151433.34625.rjw@sisk.pl> <20070715125855.GA1737@gallifrey>
	<200707160038.12943.rjw@sisk.pl> <20070729065352.GB17084@suse.cz>
	<20070805195628.GA1947@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070805195628.GA1947@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, Al Boldi <a1426z@gawab.com>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Vojtech Pavlik <vojtech@suse.cz>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, seife@suse.de, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

* Pavel Machek (pavel@ucw.cz) wrote:
> Hi!
> 
> > > > Two things which I think would be nice to consider are:
> > > >    1) Encryption - I'd actually prefer if my luks device did not
> > > >        remember the key accross a hibernation; I want to be forced to
> > > >        reenter the phrase.  However I don't know what the best thing
> > > >        to do to partitions/applications using the luks device is.
> > > 
> > > Encryption is possible with both the userland hibernation (aka uswsusp) and
> > > TuxOnIce (formerly known as suspend2).  Still, I don't consider it as a "must
> > > have" feature for a framework to be generally useful (many users don't use it
> > > anyway).
> > 
> > If a user uses an encrypted filesystem, then he also needs an encrypted
> > swap and encrypted hibernation image: Otherwise the fileystem encryption
> > is not very useful.
> 
> Actually, we can do most of that stuff already. 
> 
> We can encrypt filesystems, encrypt swaps (LVM), and encrypt hibernation.

But can you do what my original question was; find a way to lose a luks
encrypted device key and cleanly unmount the filesystem that was
using it?  (and preferably put it all back together after resume).

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
