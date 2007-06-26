From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target
	method in pm_ops
Date: Tue, 26 Jun 2007 10:55:13 +0200
Message-ID: <20070626085513.GD4594@elf.ucw.cz>
References: <200706242239.05678.rjw@sisk.pl> <200706242240.40476.rjw@sisk.pl>
	<1182806886.6644.4.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1182806886.6644.4.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2007-06-25 23:28:06, Johannes Berg wrote:
> On Sun, 2007-06-24 at 22:40 +0200, Rafael J. Wysocki wrote:
> 
> > + * @set_target: Tell the platform which system sleep state is going to be
> > + *	entered.  The information passed to @set_target should be disregarded
> > + *	by the platform as soon as @finish() is executed and if	@prepare()
> > + *	fails.
> > + *	This callback is optional.  However, if it is implemented, the
> > + *	argument passed to @prepare(), @enter and @finish() must be ignored.
> 
> I don't understand the point in mandating that then the argument to
> enter() is to be ignored, why bother? It doesn't look as though we can
> possibly do anything with the semantics here that would mean the state
> set by set_target is different to the state passed to enter(), can we?

That's what 4/4 does, AFAICT.



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
