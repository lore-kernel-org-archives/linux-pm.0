From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86 ACPI: normalize segment descriptor
	register on resume
Date: Thu, 26 Jun 2008 10:39:59 +0200
Message-ID: <200806261040.00646.rjw__33076.1611847722$1214470967$gmane$org@sisk.pl>
References: <200806242303.49498.rjw@sisk.pl>
	<20080626011716.e8c412dd.akpm@linux-foundation.org>
	<20080626082943.GC10973@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080626082943.GC10973@elte.hu>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 26 of June 2008, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > Len seems to think that Rafael seems to think that Ingo seems to think 
> > that this patch broke one of his boxes.
> > 
> > Is it so?
> 
> No! :-)
> 
> it found a pre-existing suspend+resume breakage on a testbox. (I.e. the 
> debug patch worked as i'd expect it to work. Every good debug patch 
> starts its lifetime with a sharp spike of breakages it finds.)

Does it mean that the $subject patch doesn't break your test box after all?

Rafael
