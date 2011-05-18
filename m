From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] PM / Hibernate: Add sysfs knob to
 control size of memory for drivers
Date: Wed, 18 May 2011 20:36:38 +0200
Message-ID: <20110518183638.GA8887__42031.2750073665$1305744414$gmane$org@elf.ucw.cz>
References: <201105100059.25372.rjw@sisk.pl> <201105150056.55601.rjw@sisk.pl>
	<20110518172717.GA5734@elf.ucw.cz>
	<201105182009.55813.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105182009.55813.Martin@lichtvoll.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > OK, there are no comments, so my understanding is that everyone is
> > > fine with this patch and I can add it to my linux-next branch.
> > 
> > Actually no, I don't like it. Yes, knob might be useful for debugging,
> > but having it as part of official kernel interface...
> 
> Well I and people with similar setups it is actually quite useful. It 
> makes the difference between does hibernate *every time* versus does not 
> hibernate sometimes. And I don't see why it can't go again, when the issue 
> is taken care of elsewise in the future. I think that autotuning / drivers 
> allocating their memory via whatnot is better, but until such a mechanism 
> is agreed, developed and included in official kernel I do think that this 
> knob does help.

Yes, autotuning would be better, and yes, knob is useful for you now.

I'd say the knob is for debugging and should go to debugfs somewhere.

> I think missing is some documentation so that the advanced user can figure 
> out this knob.

...so we can easily delete the knob when it is no longer neccessary.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
