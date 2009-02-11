From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 11 Feb 2009 09:40:54 +0100
Message-ID: <200902110940.55788.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<20090210202507.GE1382@ucw.cz>
	<20090211044736.GB9980@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090211044736.GB9980@bulgaria.corp.google.com>
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
To: Brian Swetland <swetland@google.com>
Cc: ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 11. February 2009, Brian Swetland wrote:
> [Pavel Machek <pavel@ucw.cz>]
>
> > > wake_lock never blocks.
> >
> > Wakelock is really bad name: it is not a lock and it does not protect
> > wake. I'd say we need better name here.
>
> I agree with you here -- I've had this discussion with Arve previously,
> but have been unable to offer a compelling alternative name.  Anybody
> have a good idea?
>
> Some people use "sleep vote" for a similar mechanism (though usually
> you're voting against sleep, which makes it feel backwards to me).
>
Which makes it a veto.


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
