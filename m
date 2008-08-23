From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug #11279] 2.6.27-rc0 Power Bugs with HP/Compaq
	Laptops
Date: Sat, 23 Aug 2008 12:26:38 +0200
Message-ID: <200808231226.39080.rjw__36979.9115149819$1219487240$gmane$org@sisk.pl>
References: <DLWXHEp37wB.A.duD.yZzpIB@albercik>
	<200808230019.09040.rjw@sisk.pl>
	<680ad8bc0808230032g458319b6nbcaddd24ad84f7a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <680ad8bc0808230032g458319b6nbcaddd24ad84f7a4@mail.gmail.com>
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
To: Matt Parnell <mparnell@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Kernel Testers List <kernel-testers@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 23 of August 2008, you wrote:
> Arrgh...I spoke too soon. It'll boot if I disable hrtimers, but I also
> have to make it use jiffies as the clocksource...so I guess we're back
> to square one. If i have hrtimers enabled, with or without
> clocksource=jiffies, I end up getting segfaults...so, I'm pretty much
> not sure what to do at this point, but relay this message to the pros.

Well, thanks for the update again.

I've added some CCs to the message, perhaps someone will have an idea what to
do next.

Thanks,
Rafafel
