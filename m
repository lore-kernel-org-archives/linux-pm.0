From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/6] ARM: shmobile: sh73a0: DT PM domain support
Date: Thu, 22 Jan 2015 11:58:19 +0900
Message-ID: <20150122025818.GB12687@verge.net.au>
References: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
 <20150114235302.GC10479@verge.net.au>
 <CAMuHMdVANePZ-fLzaLCEOm0vHR735C=u5_fDa4Uywi_P5ggjBg@mail.gmail.com>
 <20150116011315.GA7830@verge.net.au>
 <20150116024724.GA31654@verge.net.au>
 <CAMuHMdU4hj2p-N8abT-BSadznqF7=0-08o9F4_7+qjdvv6Whmw@mail.gmail.com>
 <20150116124502.GC6285@verge.net.au>
 <20150117011414.GC397@verge.net.au>
 <CAMuHMdX40LTdKt_nBb_U4eXWMuPXSYfC0Q4PvA42grdocCZfAA@mail.gmail.com>
 <20150122025522.GJ31170@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150122025522.GJ31170@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 22, 2015 at 11:55:22AM +0900, Simon Horman wrote:
> On Sat, Jan 17, 2015 at 03:12:19PM +0100, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Sat, Jan 17, 2015 at 2:14 AM, Simon Horman <horms@verge.net.au> wrote:
> > >> > If you add patch 6 to sh-drivers-for-v3.20 and merge it in -next,
> > >> > everything is fine!
> > >>
> > >> Thanks, I thought I had that one but I must have missed it somehow.
> > >
> > > I have made a second attempt and this time I hope that I haven't missed
> > > anything. Please see renesas-next-20150117-v3.19-rc1.
> > 
> > Thanks, looks better!
> 
> For the record: Olof has asked for review comments for the BSC driver and
> binding patches. Accordingly I have dropped them, and these patches which
> depend on them, from next.
> 
> This dependency may be due to the way the branches are arranged, rather
> than actual dependencies of the code. But regardless I am dropping all
> effected branches for now.

To clarify, only patches 5 and 6 of this series are affected by the above
statement.

[PATCH v2 5/6] ARM: shmobile: sh73a0 dtsi: Add PM domain support
[PATCH v2 6/6] drivers: sh: Disable PM runtime for multi-platform sh73a0 with genpd
