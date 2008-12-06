From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] PCI: Suspend and resume PCI Express
 ports with interrupts disabled
Date: Sat, 6 Dec 2008 09:15:22 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812060914100.3425__32279.4603220702$1228583948$gmane$org@nehalem.linux-foundation.org>
References: <200812020320.31876.rjw@sisk.pl> <200812061505.33815.rjw@sisk.pl>
	<200812061508.00277.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812061508.00277.rjw@sisk.pl>
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
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:
> 
> I don't see why the suspend and resume of PCI Express ports should be
> handled with interrupts enabled and it may even lead to problems in
> some situations.

Absolutely. A PCI Express port is really just a PCI bridge, with some odd 
rules. We need to enable them early, exacly like regular PCI bridges, or 
we cannot walk the PCI bus hierarchy correctly.

Anyway, ack, ack, ack for the whole series.

			Linus
