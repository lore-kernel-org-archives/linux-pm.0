From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/2] dmaengine: usb-dmac: Runtime PM Related Fixes
Date: Sat, 24 Oct 2015 19:59:11 +0200
Message-ID: <CAMuHMdW1f3h2+gxSL2ZTW13c9a_XpshN6DK_e+kj_7ydRCTXJg@mail.gmail.com>
References: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
	<20151007140124.GC3320@vkoul-mobl.iind.intel.com>
	<CAMuHMdVGq19174R=+D_hrzj-XPY8PaKvif3nB=sDq62KCuM5Xg@mail.gmail.com>
	<20151024120441.GI27370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20151024120441.GI27370@localhost>
Sender: linux-sh-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Vinod,

On Sat, Oct 24, 2015 at 2:04 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, Oct 16, 2015 at 03:10:37PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Oct 7, 2015 at 4:01 PM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Thu, Oct 01, 2015 at 09:22:16AM +0200, Geert Uytterhoeven wrote:
>> >> This series fixes a crash and an imbalance in the usb-dmac driver.
>> >
>> > Sorry this fails for me, what was this generated against
>>
>> Strange, this series still applies cleanly on top of slave-dma/next and
>> linus/master.
>
> I think I applied this to a new topic branch off rc1. But anyway since I dont
> have patches on usb-dma it should have been same :(

So how do we proceed?
Do you want me to resend the patches (they still apply to slave-dma/next)?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
