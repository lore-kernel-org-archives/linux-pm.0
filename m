From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Tue, 24 Feb 2009 07:49:21 +1100
Message-ID: <1235422161.8805.241.camel__42466.4516620853$1235422519$gmane$org@pasglop>
References: <200902221837.49396.rjw@sisk.pl>
	<200902230048.33635.rjw@sisk.pl> <20090223083645.GA9582@elte.hu>
	<200902231229.58743.rjw@sisk.pl>  <20090223122832.GB31427@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090223122832.GB31427@elte.hu>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> That property can be implied in the function name:
> 
>    	device_power_down_irq_disable(PMSG_SUSPEND);
> 
> Open-coding it, if it looks the same in all the cases just 
> increases the chances that someone somewhere copies them 
> incorrectly.

No. Some archs need to do "special" things at the irq disable point,
leave it open coded in the caller please.

Cheers,
Ben.
