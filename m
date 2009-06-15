From: Johannes Stezenbach <js@sig21.net>
Subject: Re: 2.6.30 enabling cpu1 on resume fails after suspend
	to memory
Date: Mon, 15 Jun 2009 15:12:40 +0200
Message-ID: <20090615131240.GA4917__24714.4043133178$1245079735$gmane$org@sig21.net>
References: <alpine.LFD.2.00.0906141405450.2800@localhost.localdomain>
	<200906141415.16949.rjw@sisk.pl>
	<20090614143708.32ec250c@pluto-lenny.milky.way>
	<alpine.LFD.2.00.0906141444500.2800@localhost.localdomain>
	<7E82351C108FA840AB1866AC776AEC4669244187@orsmsx505.amr.corp.intel.com>
	<alpine.LFD.2.00.0906141514120.2800@localhost.localdomain>
	<7E82351C108FA840AB1866AC776AEC466924418A@orsmsx505.amr.corp.intel.com>
	<alpine.LFD.2.00.0906141548490.2800@localhost.localdomain>
	<alpine.LFD.2.00.0906141644190.2800@localhost.localdomain>
	<20090614170334.3fcfb2ee@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090614170334.3fcfb2ee@pluto-lenny.milky.way>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 14, 2009 at 05:03:34PM +0200, Benjamin S. wrote:
> On Sun, 14 Jun 2009 16:45:10 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > can you please test the patch below.
> 
> It works. 

I can report that it works for me, too.

Thank you for fixing this while I was away.


Johannes
