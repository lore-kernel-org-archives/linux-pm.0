From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 10 update 2x] PM: Measure suspend and resume
	times for	individual devices
Date: Sun, 6 Sep 2009 06:44:40 +0200
Message-ID: <20090906044440.GA29963__31373.7401426353$1252212406$gmane$org@elte.hu>
References: <Pine.LNX.4.44L0.0908292043500.26533-100000@netrider.rowland.org>
	<200909041642.03774.rjw@sisk.pl> <20090904191205.GA28408@elte.hu>
	<200909042356.59024.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909042356.59024.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


Thanks Rafael, the code looks a lot more natural IMHO.

this bit:

> +#ifdef DEBUG
> +static void dbg_get_time(struct timeval *start)
> +{
> +	do_gettimeofday(start);
> +}

is a plain wrapper over gettimeofday so you might want to inline 
it. (although GCC will do it too most of the time)

	Ingo
