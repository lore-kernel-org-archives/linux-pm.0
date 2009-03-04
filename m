From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 4 Mar 2009 14:41:46 +0100
Message-ID: <200903041441.47146.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200903021453.19482.u.luckas@road.de>
	<20090303140215.GD5060@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090303140215.GD5060@elf.ucw.cz>
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

> > > > On the otherhand if you consider ioctl nasty, maybe write() is an
> > > > option?
> > >
> > > You want sleepvetos to be automatically unlocked/freed on close and
> > > process exit/kill, so neither write nor ioctl is the right interface.
> >
> > An application opens a device node and then writes 1s to take the lock
> > and 0s to release it.
>
> For example doing binary 0/1 writes from shell is hard...
> 									Pavel
If you have a strategy to hold an fd open from a shell, we can always agree on 
writing '0's and '1's to that fd.

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
