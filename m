From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Sun, 30 Dec 2007 22:04:56 +0100
Message-ID: <200712302204.56977.rjw__45631.6720847555$1199047583$gmane$org@sisk.pl>
References: <200712281353.37976.rjw@sisk.pl> <20071230142109.GK16946@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071230142109.GK16946@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 30 of December 2007, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Document the fact that __save_processor_state() has to save all CPU 
> > registers referred to by the kernel in case a different kernel is used 
> > to load and restore a hibernation image containing it.
> 
> ok - so i guess i should drop this from x86.git:
> 
>  @@ -53,7 +53,6 @@ void __save_processor_state(struct saved
>          ctxt->cr2 = read_cr2();
>          ctxt->cr3 = read_cr3();
>          ctxt->cr4 = read_cr4();
>  -       ctxt->cr8 = read_cr8();
>   }
> 
> right?

Well, if cr8 is used for anything that matters, then yes.

> But i'm wondering - are we really ever resuming to a different  
> kernel version, for this to be an issue?

The boot kernel may be different from the kernel within the image, if that's
what you're asking for.

Rafael
