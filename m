From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/7] ARM: shmobile: Add IRQC clock to device tree
Date: Tue, 28 Apr 2015 09:52:38 +0900
Message-ID: <20150428005237.GB557@verge.net.au>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
 <20150319014328.GJ14051@verge.net.au>
 <CAMuHMdXOBPZe6JDccvq88asPJ4D-hA_HPOv0pnUhk9rVwuF6cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXOBPZe6JDccvq88asPJ4D-hA_HPOv0pnUhk9rVwuF6cg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 27, 2015 at 04:15:14PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Mar 19, 2015 at 2:43 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Mar 18, 2015 at 07:55:54PM +0100, Geert Uytterhoeven wrote:
> >> This patch series adds the IRQC clock to the device tree on SoCs that
> >> have such a clock (r8a73a4 and r8a779x), and adds mininal runtime PM
> >> support to the renesas-irqc driver, to make sure the clock is enabled
> >> when needed by the external IRQ controller(s).
> >> Before, the clock was assumed enabled by the bootloader or reset state.
> >>
> >> As usual when involving clocks, the DTS changes depend stricly on the
> >> driver changes. Else the clock will be disabled as assumed unused,
> >> breaking the boot.
> >>
> >> This was tested on r8a73a4/ape6evm and r8a7791/koelsch.
> >
> > I will defer the DTS changes until the irqchip changes, which I
> > have reviewed, are accepted.
> 
> The irqchip changes are upstream. Do you want me to resend the DTS
> changes, or will you apply the original patches?

THanks, I have located the original patches and queued them up for v4.2.
