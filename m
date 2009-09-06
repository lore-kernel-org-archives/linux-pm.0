From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 10 update 2x] PM: Measure suspend and resume
	times for individual devices
Date: Sun, 6 Sep 2009 14:13:43 +0200
Message-ID: <200909061413.43683.rjw__11613.9066558846$1252239265$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908292043500.26533-100000@netrider.rowland.org>
	<200909042356.59024.rjw@sisk.pl> <20090906044440.GA29963@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090906044440.GA29963@elte.hu>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 September 2009, Ingo Molnar wrote:
> 
> Thanks Rafael, the code looks a lot more natural IMHO.
> 
> this bit:
> 
> > +#ifdef DEBUG
> > +static void dbg_get_time(struct timeval *start)
> > +{
> > +	do_gettimeofday(start);
> > +}
> 
> is a plain wrapper over gettimeofday so you might want to inline 
> it. (although GCC will do it too most of the time)

I have a rule of not using 'inline' except for in headers.  In this case,
however, it's almost like a header, so I'll follow your suggestion.

Thanks,
Rafael
