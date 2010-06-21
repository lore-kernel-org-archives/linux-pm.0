From: Florian Mickler <florian@mickler.org>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 22:40:23 +0200
Message-ID: <20100621224023.0b14cde7__36710.1435586393$1277152913$gmane$org@schatten.dmk.lab>
References: <20100621073233.3f874ad0@schatten.dmk.lab>
	<Pine.LNX.4.44L0.1006211244140.1687-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006211244140.1687-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Jun 2010 12:54:44 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Mon, 21 Jun 2010, Florian Mickler wrote:
> 
> > > > > What happens if an event arrives just before you read
> > > > > /sys/power/wakeup_count, but the userspace consumer doesn't realize
> > > > > there is a new unprocessed event until after the power manager checks
> > > > > it?
> > > 
> > > > I think this is not the kernel's problem.  In this approach the kernel makes it
> > > > possible for the user space to avoid the race.  Whether or not the user space
> > > > will use this opportunity is a different matter.
> > > 
> > > It is _not_ possible for userspace to avoid this race.  Help from the 
> > > kernel is needed.
> > 
> > It is possible if every (relevant) userspace program implements a
> > callback for the powermanager to check if one of it's wakeup-sources
> > got activated.
> > 
> > That way the powermanager would read /sys/power/wakeup_count, then do
> > the roundtrip to all it's registered users and only then suspend. 
> 
> After further thought, there's still a race:

Ah, yes. That's what I meant in my other mail with 'how to determine
that an wake event is in flight'. 

Read this too late.
 
> Alan Stern

Cheers,
Flo
