From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Sun, 30 Dec 2007 15:21:09 +0100
Message-ID: <20071230142109.GK16946__23775.3094443635$1199024578$gmane$org@elte.hu>
References: <200712281353.37976.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712281353.37976.rjw@sisk.pl>
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

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Document the fact that __save_processor_state() has to save all CPU 
> registers referred to by the kernel in case a different kernel is used 
> to load and restore a hibernation image containing it.

ok - so i guess i should drop this from x86.git:

 @@ -53,7 +53,6 @@ void __save_processor_state(struct saved
         ctxt->cr2 = read_cr2();
         ctxt->cr3 = read_cr3();
         ctxt->cr4 = read_cr4();
 -       ctxt->cr8 = read_cr8();
  }

right? But i'm wondering - are we really ever resuming to a different 
kernel version, for this to be an issue?

	Ingo
