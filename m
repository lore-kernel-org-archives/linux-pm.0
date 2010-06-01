From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 22:12:30 +0200
Message-ID: <20100601221230.7f7d892b__11145.8391220824$1275423211$gmane$org@schatten.dmk.lab>
References: <AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
	<Pine.LNX.4.44L0.1005292026080.6300-100000@netrider.rowland.org>
	<AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc@mail.gmail.com>
	<201005312338.55109.rjw@sisk.pl> <20100531232617.GF31155@gvim.org>
	<20100601090737.4bc243d9@schatten.dmk.lab>
	<20100601140519.GC1281@gvim.org>
	<20100601220035.6b47d57d@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100601220035.6b47d57d@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Jun 2010 22:00:35 +0200
Florian Mickler <florian@mickler.org> wrote:

> On Tue, 1 Jun 2010 07:05:19 -0700
> mark gross <640e9920@gmail.com> wrote:
> 
> > 
> > Only works 1/2 the time, but I like the idea!  
> > It fails to get the righ answer when constraints are reduced.  But, this
> > idea is a good improvement i'll roll into the next pm_qos update!
> > 
> > thanks!
> > 
> > --mgross
> 
> outch. shure. i had the binary block/unblock case in my mind. (where
> the comparitor would be just the logical &&)

And even there it wouldn't work in general. What about keeping the list
sorted? (Or using the rbtree implementation). Well, I'm getting some
sleep and tomorrow I will think about it some more. 

> cheers,
> Flo
> 
