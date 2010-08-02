From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 07:12:24 -0700
Message-ID: <20100802141224.GC2405__35044.4531919949$1280758400$gmane$org@linux.vnet.ibm.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<20100801200655.7edcf247@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100801200655.7edcf247@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 01, 2010 at 08:06:55PM -0700, Arjan van de Ven wrote:
> On Sun, 1 Aug 2010 18:10:06 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > If I understand you correctly, a key point of agreement between you
> > and the Android guys is that both the system and the user have some
> > say over how applications are treated by the system in terms of how
> > seriously the system takes a given application's requests.
> > 
> > The Android guys also want the user to have some say about what
> > applications are permitted to have some control over "I want to go to
> > <this magic deep idle state>" requests.  Does that seem reasonable
> > to you?
> 
> I personally think it's one of those things where... well we can get a
> LONG way automatically (by just observing things); asking the users
> is very very often just caving in rather than solving the problem.
> 
> Asking the user should only be done for things the user
> 1) Can give an intelligent answer to
> and
> 2) Are something the user WANTS to be involved in.
>    (rather than 'stupid thing, why don't just do the right thing'..
>    think the Windows Vista security questions)

Combining this with your previous email, I believe that you are saying
that it is necessary for the user to be able to exert some control,
but that the UI design had better be sufficiently intelligent with
sufficiently good defaults that the user almost never actually -needs-
to exert such control.

If this is indeed what you are saying, I certainly agree.

							Thanx, Paul
