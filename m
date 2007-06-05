From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 2.6.22-rc4
Date: Tue, 5 Jun 2007 12:50:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706051245190.4921@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706042040350.23741@woody.linux-foundation.org>
	<4665B169.2030803@googlemail.com>
	<alpine.LFD.0.98.0706051219560.4921@woody.linux-foundation.org>
	<20070605193718.GB24877@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070605193718.GB24877@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
List-Id: linux-pm@vger.kernel.org



On Tue, 5 Jun 2007, Ingo Molnar wrote:
> 
> isnt the refrigerator() suspend related? Perhaps suspend disables irqs 
> somewhere that we forgot to track?

There _is_ something strange there. For that whole sequence to trigger, 
the current task has to have the TIF_FREEZE bit set, but I don't see why 
it would be during shutdown.

		Linus
