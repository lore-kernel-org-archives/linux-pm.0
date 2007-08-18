From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: encrypted hibernation (was Re: Hibernation
	considerations)
Date: Sat, 18 Aug 2007 20:37:34 +0100
Message-ID: <20070818193733.GC16635__22609.5674829141$1187466040$gmane$org@gallifrey>
References: <200707151433.34625.rjw@sisk.pl> <20070805195628.GA1947@elf.ucw.cz>
	<20070811234356.GA19183@gallifrey> <200708130012.27412.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708130012.27412.rjw@sisk.pl>
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
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, Al Boldi <a1426z@gawab.com>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Vojtech Pavlik <vojtech@suse.cz>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, seife@suse.de, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Sunday, 12 August 2007 01:43, Dr. David Alan Gilbert wrote:
> > * Pavel Machek (pavel@ucw.cz) wrote:
> > > Hi!
> > > 
> > > > > > Two things which I think would be nice to consider are:
> > > > > >    1) Encryption - I'd actually prefer if my luks device did not
> > > > > >        remember the key accross a hibernation;
> 
> Why exactly (assuming that the hibernation image is encrypted)?

I was assuming the hibernation image was not encrypted.
Certainly if it meant a penalty during normal operation (e.g. encrypted swap)
it wouldn't be.

(I have a small amount of encrypted data in a luks partition,
most of the time it isn't used, only rarely do apps have it open
and I'm not actually worried about crawling through swap to find out
what is there - this is just a personal laptop; I appreciate these
concerns are different depending what you are storing).

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
