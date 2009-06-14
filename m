From: Greg KH <greg@kroah.com>
Subject: Re: 2.6.30 enabling cpu1 on resume fails after suspend
	to memory
Date: Sun, 14 Jun 2009 09:12:57 -0700
Message-ID: <20090614161257.GB9235__35901.6409413472$1244996347$gmane$org@kroah.com>
References: <200906141415.16949.rjw@sisk.pl>
	<20090614143708.32ec250c@pluto-lenny.milky.way>
	<alpine.LFD.2.00.0906141444500.2800@localhost.localdomain>
	<7E82351C108FA840AB1866AC776AEC4669244187@orsmsx505.amr.corp.intel.com>
	<alpine.LFD.2.00.0906141514120.2800@localhost.localdomain>
	<7E82351C108FA840AB1866AC776AEC466924418A@orsmsx505.amr.corp.intel.com>
	<alpine.LFD.2.00.0906141548490.2800@localhost.localdomain>
	<alpine.LFD.2.00.0906141644190.2800@localhost.localdomain>
	<20090614170334.3fcfb2ee@pluto-lenny.milky.way>
	<alpine.LFD.2.00.0906141741180.2800@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0906141741180.2800@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "js@sig21.net" <js@sig21.net>, Matthew Wilcox <matthew@wil.cx>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Benjamin S." <sbenni@gmx.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 14, 2009 at 05:41:50PM +0200, Thomas Gleixner wrote:
> On Sun, 14 Jun 2009, Benjamin S. wrote:
> 
> > On Sun, 14 Jun 2009 16:45:10 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > can you please test the patch below.
> > 
> > It works. 
> 
> I queue it up. Thanks,

Make sure to add a tag to get it sent to the stable tree too please :)

thanks,

greg k-h
