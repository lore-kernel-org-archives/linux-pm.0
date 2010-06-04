From: Brian Swetland <swetland@google.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 03:11:12 -0700
Message-ID: <AANLkTilUG7xbTVk7n6w91lnEuTG3tonO_S6colNFKBYQ__18208.1657149412$1275646596$gmane$org@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<1275645245.27810.39493.camel@twins>
	<20100604100306.GB3324@elte.hu>
	<1275646103.27810.39526.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275646103.27810.39526.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 4, 2010 at 3:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, 2010-06-04 at 12:03 +0200, Ingo Molnar wrote:
>
>> > The only 'interesting' issue I can see here is that if you create 1000
>> > CLOCK_MONOTONIC namepaces, we'd need to have a tree of trees in order to
>> > efficiently find the leftmost timer.
>>
>> Realistically Android userspace would create just a single such namespace for
>> all the untrusted/unknown/uncontrolled apps, right?
>
> Possibly, yeah.

Definitely, at least initially.  If we had the ability to do more fine
grained control, we might be tempted to experiment with it, but to
start with we'd feel safer using the big hammer as we are today.

Brian
