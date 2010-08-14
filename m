From: David Brownell <david-b@pacbell.net>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 14 Aug 2010 11:15:43 -0700 (PDT)
Message-ID: <302795.95811.qm__37377.2443891086$1281809917$gmane$org@web180309.mail.gq1.yahoo.com>
References: <20100814095351.6a996187@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100814095351.6a996187@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com, Arjan van de Ven <arjan@infradead.org>
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, swmike@swm.pp.se
List-Id: linux-pm@vger.kernel.org



--- On Sat, 8/14/10, Arjan van de Ven <arjan@infradead.org> wrote:


> however I think you're making an assumption
> that there is a real difference between a deep idle state and "off"....
> 
> For modern x86 hardware, that assumption isn't
> really valid.

For ARM processors it's not unrealistic.  THey
tend to have idle states that place constraints on
peripherals and clocks which allow peripherals to run independently of CPUs.

I recall for example various processors that allow
USB to continue operating in one or more idle states, if the right clocks are active (and RAM).
Similarly with some other peripherals.  It may be
desirable to have I/O active while CPUs are idle.

Not all low power states map to x86/ACPI models;
and Linux hasn't accomodated that reality well.
