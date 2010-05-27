From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 11:44:13 -0700
Message-ID: <87d3whi3r6.fsf__29961.6809854799$1274986393$gmane$org@deeprootsystems.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271915540.3032@localhost.localdomain>
	<20100527173118.GE2468@srcf.ucam.org>
	<1274981680.27810.5636.camel@twins>
	<20100527174019.GA3187@srcf.ucam.org>
	<20100527190515.08be091a@lxorguk.ukuu.org.uk>
	<20100527181533.GH3543@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100527181533.GH3543@srcf.ucam.org> (Matthew Garrett's message
	of "Thu\, 27 May 2010 19\:15\:33 +0100")
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
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

Matthew Garrett <mjg59@srcf.ucam.org> writes:

> On Thu, May 27, 2010 at 07:05:15PM +0100, Alan Cox wrote:
>
>> I'd prefer we avoided mixing them up. Everyone seems fairly happy with
>> the current operator ordered suspend behaviour I believe ?
>
> No. The current mechanism can lose wakeup events.

And the proposed solution (suspend blockers) does nothing to solve the
loss of wakeup events during forced suspend.

Kevin
