From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 GART: Add resume handling (was: Re: >3G
	=> iommu	=> suspend problems -- was Re: SB600 AHCI: Hard Disk
	Corruption)
Date: Thu, 12 Jun 2008 11:34:30 +0200
Message-ID: <20080612093430.GA641__33404.8739322045$1213263514$gmane$org@elte.hu>
References: <1211717435.6038.53.camel@localhost.localdomain>
	<20080609124630.GA28799@elte.hu> <200806100010.49194.rjw@sisk.pl>
	<200806101203.01836.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806101203.01836.rjw@sisk.pl>
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
Cc: Pavel Machek <pavel@suse.cz>, the arch/x86 maintainers <x86@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > Okay, appended is the patch rebased on tip/x86/gart with (mainline) 
> > commit cd76374e9de4501acc74f833dc6cb5e7a5dca115 "suspend-vs-iommu: 
> > prevent suspend if we could not resume" (which appears to be missing 
> > from tip/x86/gart) applied.
> > 
> > This version of the patch doesn't break compilation, but it hasn't 
> > been really tested yet.
> 
> Now it has been (successfully) tested too. :-)

applied to tip/x86/gart, thanks Rafael.

	Ingo
