From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Mon, 31 Dec 2007 18:57:33 +0100
Message-ID: <200712311857.34445.rjw__35000.4436601468$1199122776$gmane$org@sisk.pl>
References: <200712281353.37976.rjw@sisk.pl> <200712302337.23896.rjw@sisk.pl>
	<20071231104311.GA30003@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071231104311.GA30003@elte.hu>
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

On Monday, 31 of December 2007, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > > ok, just to make sure we are talking about the same thing. Do you 
> > > mean we can restore an image saved by v2.6.12 into v2.6.24? I.e. a 
> > > 2.6.24 kernel will be able to run a 2.6.12 kernel's hibernation 
> > > image, with all the kernel internal data from v2.6.12, etc? No way 
> > > can that work.
> > 
> > Well, not exactly.  The support for different boot and image kernels 
> > has only been merged recently, but we can use the current git to 
> > restore 2.6.24-rc6-mm1, for example.
> > 
> > The trick is to pass a little additional information in the image 
> > header that can be used by the boot kernel to locate the entry point 
> > to the image kernel and the image kernel's page tables.
> 
> ok - i thought you meant that there's a general capability to resume 
> across kernel versions. (which would be close to impossible without some 
> major surgery.)

Well, there will be one. :-)  For example, one should be able to use a 2.6.25+
boot kernel to load the image containing 2.6.24-rc6 and restore the memory
state from it.

> btw., in what way is this different from kexec?

Not that much different indeed.  The hibernation code is more focused on
restoring the pre-hibernation state of the system rather than anything else,
plus on ACPI systems we try to handle the platform in accordance with the
specification (to some extent - you'd have to use a non-ACPI boot kernel to
follow the specification literally, which is possible but not straightforward).

Rafael
