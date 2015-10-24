From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] dmaengine: usb-dmac: Runtime PM Related Fixes
Date: Sun, 25 Oct 2015 04:14:16 +0530
Message-ID: <20151024224416.GJ27370@localhost>
References: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
 <20151007140124.GC3320@vkoul-mobl.iind.intel.com>
 <CAMuHMdVGq19174R=+D_hrzj-XPY8PaKvif3nB=sDq62KCuM5Xg@mail.gmail.com>
 <20151024120441.GI27370@localhost>
 <CAMuHMdW1f3h2+gxSL2ZTW13c9a_XpshN6DK_e+kj_7ydRCTXJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW1f3h2+gxSL2ZTW13c9a_XpshN6DK_e+kj_7ydRCTXJg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Oct 24, 2015 at 07:59:11PM +0200, Geert Uytterhoeven wrote:
> Hi Vinod,
> 
> On Sat, Oct 24, 2015 at 2:04 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Fri, Oct 16, 2015 at 03:10:37PM +0200, Geert Uytterhoeven wrote:
> >> On Wed, Oct 7, 2015 at 4:01 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> >> > On Thu, Oct 01, 2015 at 09:22:16AM +0200, Geert Uytterhoeven wrote:
> >> >> This series fixes a crash and an imbalance in the usb-dmac driver.
> >> >
> >> > Sorry this fails for me, what was this generated against
> >>
> >> Strange, this series still applies cleanly on top of slave-dma/next and
> >> linus/master.
> >
> > I think I applied this to a new topic branch off rc1. But anyway since I dont
> > have patches on usb-dma it should have been same :(
> 
> So how do we proceed?
> Do you want me to resend the patches (they still apply to slave-dma/next)?

Yes please and also as a backup can you push a branch with these...

-- 
~Vinod
