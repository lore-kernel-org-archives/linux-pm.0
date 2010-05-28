From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 15:20:17 +0200
Message-ID: <1275052817.1645.64.camel__36384.294255595$1275052961$gmane$org@laptop>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
	<20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
	<AANLkTilYHKKmQePBGW3LVLjUZy7HXHQku2Iub-LWGBm6@mail.gmail.com>
	<20100528132138.2d802d77@lxorguk.ukuu.org.uk>
	<1275049836.1645.1.camel@laptop>
	<20100528140236.3214929e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528140236.3214929e@lxorguk.ukuu.org.uk>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-05-28 at 14:02 +0100, Alan Cox wrote:
> On Fri, 28 May 2010 14:30:36 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, 2010-05-28 at 13:21 +0100, Alan Cox wrote:
> > > [Total kernel changes
> > > 
> > >         Ability to mark/unmark a scheduler control group as outside of
> > >         some parts of idle consideration. Generically useful and
> > >         localised. Group latency will do most jobs fine (Zygo is correct
> > >         it can't solve his backup case elegantly I think)
> > > 
> > >         Test in the idling logic to distinguish the case and only needed
> > >         for a single Android specific power module. Generically useful
> > >         and localised] 
> > 
> > I really don't like this..
> > 
> > Why can't we go with the previously suggested: make bad apps block on
> > QoS resources or send SIGXCPU, SIGSTOP, SIGTERM and eventually SIGKILL
> 
> Ok. Are you happy with the QoS being attached to a scheduler control
> group and the use of them to figure out what is what ?

Up to a point, but explicitly not running runnable tasks complicates the
task model significantly, and interacts with fun stuff like bandwidth
inheritance and priority/deadline inheritance like things -- a subject
you really don't want to complicate further.

We really want to do our utmost best to make applications block on
something without altering our task model.

If applications keep running despite being told repeatedly to cease, I
think the SIGKILL option is a sane one (they got SIGXCPU, SIGSTOP and
SIGTERM before that) and got ample opportunity to block on something.

Traditional cpu resource management treats the CPU as an ever
replenished resource, breaking that assumption (not running runnable
tasks) puts us on very shaky ground indeed.
