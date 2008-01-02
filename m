From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64 (rev. 2)
Date: Wed, 2 Jan 2008 12:41:08 +0100
Message-ID: <20080102114108.GA24329__17262.465079739$1199274401$gmane$org@elte.hu>
References: <200712302313.52483.rjw@sisk.pl> <20080102000222.GA2404@ucw.cz>
	<200801020023.58040.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200801020023.58040.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > > Document the fact that __save_processor_state() has to save all 
> > > CPU registers referred to by the kernel in case a different kernel 
> > > is used to load and restore a hibernation image containing it.
> > > 
> > > Sigend-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > ACK.
> 
> Thanks!
> 
> Ingo, can you please take this patch for 2.6.25 or should I forward it 
> to Len?

sure, applied it to x86.git. I've also zapped the cr8 elimination patch.

	Ingo
