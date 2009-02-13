From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 19:18:44 +0100
Message-ID: <200902131918.45842.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902131749.57728.u.luckas@road.de>
	<20090213170953.GB29902@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213170953.GB29902@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Friday, 13. February 2009, Matthew Garrett wrote:
> On Fri, Feb 13, 2009 at 05:49:57PM +0100, Uli Luckas wrote:
> > On Friday, 13. February 2009, Matthew Garrett wrote:
> > > Userland ABI would then be a single /dev/inhibit_suspend,
> > > with the counter being bumped each time an application opens it. It'll
> > > automatically be dropped if the application exits without cleaning up.
> > >
> > > This seems simpler and also avoids any arguments about the naming
> > > scheme. What am I missing?
> >
> > Opening and closing an fd sounds like a lot of overhead. Taking and
> > releasing locks if going to be a called with very highg frequency. I'd go
> > for an ioctl.
>
> Is the performance of open() really that bad compared to ioctl()? And
> what are your tasks doing that this would actually be a noticable
> performance issue? Userspace should not be taking and releasing these
> locks with high frequency. It should be doing so in response to events,
> and events occur infrequently. 
Touch screen events for example are performance critical if you want to be 
able to draw smooth curves. To get rid of timed locks, the concept might have 
to be extended to network packets, serial data, ...

> Given that the implementation in the field is writing strings into a file in
> sysfs and nobody's complained, I don't think this is a huge concern.
That's because a lot of areas are not yet under wake lock protection.

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
