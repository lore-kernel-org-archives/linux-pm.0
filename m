From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 13:01:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005281257040.1939-100000__7456.85919323495$1275066142$gmane$org@iolanthe.rowland.org>
References: <20100528173151.2c5f6fde@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528173151.2c5f6fde@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010, Alan Cox wrote:

> > I think Arve's concern was the representation of the "I care, but only
> > a little" or "just low enough to ensure threads must run" level which
> > is what suspend blockers would map to (low enough to ensure we
> > shouldn't halt the world but not necessarily implying a hard latency
> > constraint beyond that).
> =

> That's why I suggested "manyana" (can't get accents for ma=F1ana in a
> define) or perhaps "dreckly"[1]. They are both words that mean "at some
> point" but in a very very vague and 'relax it'll happen eventually' sense.

A USA-style equivalent phrase might be "Real Soon Now".  Except that it =

conveys a strong implication that the event will never happen...

> > That makes sense -- and as I've mentioned elsewhere, we're really not
> > super picky about naming -- if it turns out that
> > wakelocks/suspendblockers were shorthand for "request a qos constraint
> > that ensures that threads are running", we'll be able to get things
> > done just as well as we do now.
> =

> Cool. I think they are or at least they are close enough that nobody will
> notice the join ;)

Why are suspend blockers needed if you're going to put all untrusted =

apps in a cgroup and freeze/stop them?  Or is that not what you're =

planning to do?

ALan Stern
