From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Hibernation considerations
Date: Sun, 29 Jul 2007 08:53:52 +0200
Message-ID: <20070729065352.GB17084__14122.4228930243$1185692108$gmane$org@suse.cz>
References: <200707151433.34625.rjw@sisk.pl> <20070715125855.GA1737@gallifrey>
	<200707160038.12943.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707160038.12943.rjw@sisk.pl>
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
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 16, 2007 at 12:38:11AM +0200, Rafael J. Wysocki wrote:

> > Or the user unplugs their flash drive after hibernation rather than before.
> > 
> > Two things which I think would be nice to consider are:
> >    1) Encryption - I'd actually prefer if my luks device did not
> >        remember the key accross a hibernation; I want to be forced to
> >        reenter the phrase.  However I don't know what the best thing
> >        to do to partitions/applications using the luks device is.
> 
> Encryption is possible with both the userland hibernation (aka uswsusp) and
> TuxOnIce (formerly known as suspend2).  Still, I don't consider it as a "must
> have" feature for a framework to be generally useful (many users don't use it
> anyway).

If a user uses an encrypted filesystem, then he also needs an encrypted
swap and encrypted hibernation image: Otherwise the fileystem encryption
is not very useful.

Forgetting the filesystem/swap decryption keys before hibernation is
probably harder to do - there may be sensitive data in the kernel memory
image that weren't cleared - even if the key itself is not there.

In my opinion, encrypted hibernation is what every notebook user should
want - that's the only way how to make sure data from the notebook
aren't available when the notebook is physically stolen.

-- 
Vojtech Pavlik
Director SuSE Labs
