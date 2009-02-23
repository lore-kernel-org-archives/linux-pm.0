From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Mon, 23 Feb 2009 09:28:02 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902230926030.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
	<20090223083645.GA9582@elte.hu> <200902231229.58743.rjw@sisk.pl>
	<20090223171630.GA28651@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090223171630.GA28651@elte.hu>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 23 Feb 2009, Ingo Molnar wrote:
> 
> Linus, do you have a strong opinion about which variant we 
> should use?

Strong? No. I think mine is better just because _if_ another CPU is busy 
handling an interrupt that we're just now disabling, we'll just go on to 
the next interrupt. Waiting for them all at the end is always more 
efficient.

But does it really matter? No. In this case I think we've shut down all 
other CPU's anyway, so the whole "serialize_irq()" should probably not 
even be needed. 

		Linus
