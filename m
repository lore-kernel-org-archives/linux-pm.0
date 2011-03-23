From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: [PATCH 3/6] PCI / Intel IOMMU: Use syscore_ops
 instead of sysdev class and sysdev
Date: Wed, 23 Mar 2011 08:48:45 +0100
Message-ID: <20110323074845.GE20444__27302.8481788517$1300897963$gmane$org@amd.com>
References: <201103100131.58206.rjw@sisk.pl> <201103220036.17824.rjw@sisk.pl>
	<20110322105738.GC20444@amd.com> <201103222307.21983.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103222307.21983.rjw@sisk.pl>
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, "H. Peter
	Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 22, 2011 at 06:07:21PM -0400, Rafael J. Wysocki wrote:
> On Tuesday, March 22, 2011, Joerg Roedel wrote:
> > On Mon, Mar 21, 2011 at 07:36:17PM -0400, Rafael J. Wysocki wrote:
> > >  drivers/pci/intel-iommu.c |   38 +++++++++-----------------------------
> > >  1 file changed, 9 insertions(+), 29 deletions(-)
> > 
> > Looks good.
> 
> May I take that as an ACK?

Sure :-)
 
> > I prepare a patch to convert AMD IOMMU to syscore_ops too.
> 
> Already done.  :-)
> 
> It's a part of patch [1/6].

I see, saves me work, thanks :-)

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
