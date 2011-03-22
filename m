From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] Do not use sysdevs for implementing
	"core" PM operations on x86
Date: Tue, 22 Mar 2011 21:33:13 +0100
Message-ID: <201103222133.14054.rjw__36661.966951988$1300826325$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl> <201103220031.22729.rjw@sisk.pl>
	<20110322103258.GC4448@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110322103258.GC4448@elte.hu>
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
Cc: kvm@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, cpufreq@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 22, 2011, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > > If there are no objectsions, I'd like to push these patches through the suspend
> > > tree.
> > 
> > [1/8] has been merged in the meantime and [3/8] has been included into the
> > ACPI tree.  if there are no objections, I'm going to push the following
> > patches to Linus this week through the suspend-2.6 tree:
> > 
> > [1/6] - Convert sysdev users in arch/x86 to using struct syscore_ops.
> > 
> > [2/6] - Make timekeeping use struct syscore_ops for suspend/resume.
> >  
> > [3/6] - Make Intel IOMMU use struct syscore_ops for suspend/resume.
> > 
> > [4/6] - Make KVM use struct syscore_ops for suspend/resume.
> > 
> > [5/6] - Make cpufreq use struct syscore_ops for boot CPU suspend/resume.
> > 
> > [6/6] - Introduce config switch allowing architectures to skip sysdev
> >         suspend/resume/shutdown code.
> 
> The x86 bits look fine.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Thanks!

> The patches affect a lot of hardware so please make sure they are tested well 
> before pushing them to Linus :-)

I have tested the majority, but unfortunately I have no hardware to test
the Intel IOMMU patch on it.

Thanks,
Rafael
