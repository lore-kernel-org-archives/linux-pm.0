From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Mon, 2 Mar 2009 14:53:19 +0100
Message-ID: <200903021453.19482.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902271507.14747.u.luckas@road.de>
	<20090227203252.GB1397@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090227203252.GB1397@ucw.cz>
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
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Friday, 27. February 2009, Pavel Machek wrote:
> On Fri 2009-02-27 15:07:14, Uli Luckas wrote:
> > On Friday, 27. February 2009, Pavel Machek wrote:
> > > On Fri 2009-02-13 17:49:57, Uli Luckas wrote:
> > > > On Friday, 13. February 2009, Matthew Garrett wrote:
> > > > > Userland ABI would then be a single /dev/inhibit_suspend,
> > > > > with the counter being bumped each time an application opens it.
> > > > > It'll automatically be dropped if the application exits without
> > > > > cleaning up.
> > > > >
> > > > > This seems simpler and also avoids any arguments about the naming
> > > > > scheme. What am I missing?
> > > >
> > > > Opening and closing an fd sounds like a lot of overhead. Taking and
> > > > releasing locks if going to be a called with very highg frequency.
> > > > I'd go for an ioctl.
> > >
> > > Ehm?
> > >
> > > And introduce nasty interface, and probably slower too since open() is
> > > time-critical and ioctl() is not? Or do you have benchmarks?
> >
> > No, just specualting as open() needs to do a directory lookup. It also
> > needs to do book keeping. I'd be surprised if open was faster then ioctl.
>
> Unless you measure how much slower it is...
>
OK. Opening /dev/null 100000 times readonly takes 365 ms on my machine. 
Opening it once and then, 100000 times writing 1 byte takes 32 ms.
Why exactly did you think I had to provide numbers???

> > On the otherhand if you consider ioctl nasty, maybe write() is an option?
>
> You want sleepvetos to be automatically unlocked/freed on close and
> process exit/kill, so neither write nor ioctl is the right interface.
An application opens a device node and then writes 1s to take the lock and 0s 
to release it.
Why does that make it impossible to auto-release the lock on close?

Uli


-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
