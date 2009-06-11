From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] pm: Move nvs routines into a seperate
	file.
Date: Fri, 12 Jun 2009 01:28:07 +0200
Message-ID: <20090611232807.GA19752__47460.4191877463$1244762949$gmane$org@elf.ucw.cz>
References: <20090604161847.513682672@de.ibm.com>
	<200906112346.28782.rjw@sisk.pl>
	<20090611220517.GF27376@elf.ucw.cz>
	<200906120030.00425.rjw@sisk.pl>
	<20090611232224.GB18682@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090611232224.GB18682@elf.ucw.cz>
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
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

> > > > > > To fix this add some empty inline functions for !GENERIC_HARDIRQS.
> > > > > 
> > > > > I don't think that's right fix. If architecture does not use
> > > > > GENERIC_HARDIRQS, it may want to implement *_device_irqs()
> > > > > itself. Before your patch, it could, after your patch, it can not.
> > > > > 
> > > > > Better put those empty functions in arch/s390/include?
> > > > 
> > > > If any of the affected architectures wants to implement *_device_irqs()
> > > > itself, it can do the appropriate change in future.  For now, let's not break
> > > > compilation on them, shall we?
> > > 
> > > Well, if one of those architectures will want to implement
> > > *_device_irqs(), it will have to either modify s390, and all other
> > > !GENERIC_HARDIRQS architectures.
> > 
> > Why will it?  I think it will be sufficient to modify the header changed by
> > this patch and the architecture in question.
> 
> Hmm, how? Putting #ifndef MY_ARCH into generic header? Inventing
> CONFIG_NON_GENERIC_HARDIRQS_BUT_I_NEED_DEVICE_IRQS?

Maybe playing with attribute((weak)) is the cleanest solution?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
