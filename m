From: Brian Swetland <swetland@google.com>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 11:44:16 -0700
Message-ID: <AANLkTilRbTVbjAt9uodpzecHLUmcDQEKT_EVpjyrSIwn__45407.7040813447$1275849914$gmane$org@mail.gmail.com>
References: <1275834706.7227.545.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
	<1275844114.7227.552.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061932240.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006061932240.2933@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 6, 2010 at 11:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Right, so the sooner we make it easier for the drivers to use the kernel
>> as their main repository, the better.
>
> Yep, the fastest way is to provide two stub inlines in pm.h and let
> the driver flood come in.

As mentioned previously, we didn't know this was an option (stubs
without an implementation behind them).  If it is, and thus we can
simplify the driver merging process short-term while sorting out a
long-term implementation or replacement for suspend blockers, then I
think we're making real progress.

There is no reason that drivers that support suspend blockers cannot
(or should not) support regular suspend/resume or runtime
suspend/resume, so that shouldn't be a worry.  The various operating
modes complement, not compete with each other (we want the lowest
possible power consumption in all states, be that fully active, fully
suspended, or anything in between -- I think everyone involved agrees
with this).

> I think all of us involved in that can do with a break, where we sit
> back, calm down and rethink w/o time pressure.

Total agreement.

Brian
