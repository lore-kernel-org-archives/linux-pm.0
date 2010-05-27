From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 23:35:12 +0100
Message-ID: <20100527223512.GA11364__38360.840563155$1274999891$gmane$org@srcf.ucam.org>
References: <20100527170740.GA1980@srcf.ucam.org>
	<1274980391.27810.5552.camel@twins>
	<20100527171644.GA2468@srcf.ucam.org>
	<1274980856.27810.5582.camel@twins>
	<20100527172510.GC2468@srcf.ucam.org>
	<20100527223751.7af3b5ee@lxorguk.ukuu.org.uk>
	<20100527213635.GA9916@srcf.ucam.org>
	<20100527225637.57a336ad@lxorguk.ukuu.org.uk>
	<20100527220819.GA10602@srcf.ucam.org>
	<20100527233247.37195656@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100527233247.37195656@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 11:32:47PM +0100, Alan Cox wrote:
> > The kernel performs no explicit notification to userspace. With legacy 
> 
> For a PC ACPI using type device /proc/acpi/events which wakes acpid which
> wakes gnome-power-manager which wakes half the universe

No, there's no explicit /proc/acpi/event notification on resume.

> Do we need a better more generic version of the events files - maybe but
> thats a rather different kettle of fish to suspend blockers.

It's a requirement for any reasonable alternative approach.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
