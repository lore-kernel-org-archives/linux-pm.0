From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.30 enabling cpu1 on resume fails after suspend
	to memory
Date: Sun, 14 Jun 2009 14:43:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906141440440.2800__26522.58529929$1244983455$gmane$org@localhost.localdomain>
References: <20090614120950.116536fa@pluto-lenny.milky.way>
	<200906141400.27331.rjw@sisk.pl>
	<alpine.LFD.2.00.0906141405450.2800@localhost.localdomain>
	<200906141415.16949.rjw@sisk.pl>
	<20090614143708.32ec250c@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090614143708.32ec250c@pluto-lenny.milky.way>
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
Cc: js@sig21.net, Matthew Wilcox <matthew@wil.cx>, Linux PCI <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 14 Jun 2009, Benjamin S. wrote:
>  19:          0         17   IO-APIC-fasteoi   ehci_hcd:usb4, HDA Intel
>  24:       4830          0  HPET_MSI-edge      hpet2

This is probably the culprit. Try booting with hpet=disble and check
whether your resume works.

Thanks,

	tglx
