From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] PCI: Suspend and resume PCI Express
	ports with interrupts disabled
Date: Sat, 6 Dec 2008 18:25:59 +0100
Message-ID: <200812061825.59914.rjw__42754.6737519608$1228584531$gmane$org@sisk.pl>
References: <200812020320.31876.rjw@sisk.pl> <200812061508.00277.rjw@sisk.pl>
	<alpine.LFD.2.00.0812060914100.3425@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0812060914100.3425@nehalem.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 6 of December 2008, Linus Torvalds wrote:
> 
> On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:
> > 
> > I don't see why the suspend and resume of PCI Express ports should be
> > handled with interrupts enabled and it may even lead to problems in
> > some situations.
> 
> Absolutely. A PCI Express port is really just a PCI bridge, with some odd 
> rules. We need to enable them early, exacly like regular PCI bridges, or 
> we cannot walk the PCI bus hierarchy correctly.
> 
> Anyway, ack, ack, ack for the whole series.

Thanks! :-)

I think it should go through Jesse?

Rafael
