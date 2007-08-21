From: Pavel Machek <pavel@ucw.cz>
Subject: Re: encrypted hibernation (was Re: Hibernation
	considerations)
Date: Tue, 21 Aug 2007 09:29:18 +0200
Message-ID: <20070821072917.GA7258__48016.0784711645$1187689486$gmane$org@elf.ucw.cz>
References: <200707151433.34625.rjw@sisk.pl> <20070805195628.GA1947@elf.ucw.cz>
	<20070811234356.GA19183@gallifrey> <200708130012.27412.rjw@sisk.pl>
	<20070818193733.GC16635@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070818193733.GC16635@gallifrey>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, Al Boldi <a1426z@gawab.com>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Vojtech Pavlik <vojtech@suse.cz>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, seife@suse.de, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > > > Two things which I think would be nice to consider are:
> > > > > > >    1) Encryption - I'd actually prefer if my luks device did not
> > > > > > >        remember the key accross a hibernation;
> > 
> > Why exactly (assuming that the hibernation image is encrypted)?
> 
> I was assuming the hibernation image was not encrypted.
> Certainly if it meant a penalty during normal operation (e.g. encrypted swap)
> it wouldn't be.

uswsusp works the way you want. Don't encrypt normal swap, and uswsusp
will still be encrypted.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
