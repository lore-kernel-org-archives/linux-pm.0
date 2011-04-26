From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
 for device PM.
Date: Tue, 26 Apr 2011 23:11:59 +0200
Message-ID: <20110426211159.GB28033__40043.2252245539$1303856920$gmane$org@elf.ucw.cz>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426131737.GA13597@suse.de>
	<20110426203853.GC27140@elf.ucw.cz>
	<201104262249.22564.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104262249.22564.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, kyungmin.park@samsung.com, MyungJoo Ham <myungjoo.ham@samsung.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > What is the root problem that this is trying to solve?
> > 
> > It is trying to fix machines that need to run periodic kernel tasks
> > even when user asked them to sleep. Zaurus needs to periodicaly wake
> > up to be able to charge battery in s2ram state, for example.
> 
> Well, if you wake up periodically, it's not S2RAM any more, I'd say.

It certainly looks a lot like s2ram to the user.

Now, your PC wakes up periodically in s2ram, too; but it is keyboard
controller that wakes up, not CPU, so you do not know.

On Zaurus, you do not know, either; nothing visible happens and
userspace is shielded from these details.

Should user really have to know if battery charger is implemented on
keyboard controller or on main cpu before he selects which interface
to use?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
