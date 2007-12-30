From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Sun, 30 Dec 2007 21:51:04 +0100
Message-ID: <20071230205104.GB26120__42007.6096001596$1199047967$gmane$org@elte.hu>
References: <200712281353.37976.rjw@sisk.pl> <20071230142109.GK16946@elte.hu>
	<200712302204.56977.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712302204.56977.rjw@sisk.pl>
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
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > But i'm wondering - are we really ever resuming to a different 
> > kernel version, for this to be an issue?
> 
> The boot kernel may be different from the kernel within the image, if 
> that's what you're asking for.

how different can it be, for resume to work? I mean, we'll have deeply 
kernel version dependent variables in RAM. Am i missing something 
obvious?

	Ingo
