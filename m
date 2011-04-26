From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
	for device PM.
Date: Tue, 26 Apr 2011 22:49:22 +0200
Message-ID: <201104262249.22564.rjw__7870.25287650085$1303856526$gmane$org@sisk.pl>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426131737.GA13597@suse.de>
	<20110426203853.GC27140@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110426203853.GC27140@elf.ucw.cz>
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
Cc: Len Brown <len.brown@intel.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, kyungmin.park@samsung.com, MyungJoo Ham <myungjoo.ham@samsung.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 26, 2011, Pavel Machek wrote:
> Hi!
> 
> > > To conclude, I'm not sure about the approach.  In particular, I'm not sure
> > > if the benefit is worth the effort and the resulting complications (ie. the
> > > possibility of having to deal with wakeup signals not requested by user
> > > space) seem to be a bit too far reaching.
> > > 
> > > Greg, what do you think?
> > 
> > I agree with you in that I don't think that this type of feature is
> > valid at the moment.
> 
> Our current "solution" is low level suspend code on Zaurus directly
> looking at charger state and doing the "wakeup or not" decision by hand. 
> 
> > I don't understand why our current situation doesn't work, what are we
> > lacking that is needed for these systems that we have not seen
> > before?
> 
> It works, but it is ugly; and it seems samsung now needs similar
> hacks.
> 
> > What is the root problem that this is trying to solve?
> 
> It is trying to fix machines that need to run periodic kernel tasks
> even when user asked them to sleep. Zaurus needs to periodicaly wake
> up to be able to charge battery in s2ram state, for example.

Well, if you wake up periodically, it's not S2RAM any more, I'd say.

Thanks,
Rafael
