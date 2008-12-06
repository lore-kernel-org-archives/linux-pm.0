From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
 and resume
Date: Sat, 6 Dec 2008 23:35:07 +0000
Message-ID: <20081206233507.205b8ea5__7535.78282096914$1228606774$gmane$org@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<200812062236.44111.rjw@sisk.pl>
	<alpine.LFD.2.00.0812061420190.3425@nehalem.linux-foundation.org>
	<20081206152545.326c8b67@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081206152545.326c8b67@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, pm@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> So we need to unregister + re-register to make that happen

Agreed - and to cope with coming back up with some masked IRQs for those
lovely hardware vendors whose idea of amusement is handing the resumed
system a pending IRQ. To be fair its often hardware flagging things like
'device has become ready' from power up events...
