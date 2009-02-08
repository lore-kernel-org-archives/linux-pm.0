From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 00:44:04 +0100
Message-ID: <200902090044.04962.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902081450.46584.rjw@sisk.pl> <20090208210401.GE6369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090208210401.GE6369@elf.ucw.cz>
Content-Disposition: inline
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Pavel Machek wrote:
> Hi!
> 
> > > > This is completely wrong, IMO.
> > > > 
> > > > Removing an interface that has existed forever just because it happens to
> > > > be incompatible with your new shiny feature is not acceptable to me.
> > > 
> > > Agreed. AFAICS this patch can be just dropped, or maybe kept specially
> > > for android if those few bytes matter to them.
> > 
> > Just to make things crystal clear, in fact I don't like any patches in this
> > series.
> > 
> > The wakelocks seem to be overdesigned to me and the "early suspend" thing
> 
> Well, it is true that wakelocks could be single atomic_t ... but they
> would make them undebuggable. Ok, wakelock interface sucks. But I
> believe something like that is neccessary.
> 
> (In fact, I invented something similar for sleepy linux patches).

Something like this, yes.

Perhaps it's a good occasion to discuss that and reach an agreement on how to
implement it.

Thanks,
Rafael
