From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor
	register on	resume
Date: Thu, 26 Jun 2008 10:51:10 +0200
Message-ID: <20080626085110.GA18599__24187.0253034451$1214470627$gmane$org@elte.hu>
References: <200806242303.49498.rjw@sisk.pl>
	<20080626011716.e8c412dd.akpm@linux-foundation.org>
	<20080626082943.GC10973@elte.hu> <200806261040.00646.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806261040.00646.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Thursday, 26 of June 2008, Ingo Molnar wrote:
> > 
> > * Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > Len seems to think that Rafael seems to think that Ingo seems to think 
> > > that this patch broke one of his boxes.
> > > 
> > > Is it so?
> > 
> > No! :-)
> > 
> > it found a pre-existing suspend+resume breakage on a testbox. (I.e. 
> > the debug patch worked as i'd expect it to work. Every good debug 
> > patch starts its lifetime with a sharp spike of breakages it finds.)
> 
> Does it mean that the $subject patch doesn't break your test box after 
> all?

it doesnt break it - i get the same suspend+resume breakage without that 
patch as well, if i do it manually.

	Ingo
