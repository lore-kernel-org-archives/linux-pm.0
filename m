From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
Date: Mon, 29 Apr 2019 11:36:16 -0500
Message-ID: <CAL_JsqJUNw_aDKjWf4TkJWQFhhLCrGYWbTtWpz5jkyeONRcpQw@mail.gmail.com>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
 <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
 <20190425195156.GA31128@bogus> <86715dda-c1b0-5354-17d2-419f8137cb91@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86715dda-c1b0-5354-17d2-419f8137cb91@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kees Cook <keescook@chromium.org>, Tony Lindgren <tony@atomide.com>, Joerg Roedel <jroedel@suse.de>, Thierry Reding <treding@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 7:05 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi Rob,
>
> On 4/25/19 9:51 PM, Rob Herring wrote:
> > On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
> >> The device tree bindings for LPDDR3 SDRAM memories.
> >>
> >> For specifying the AC timing parameters of the memory device
> >> the 'lpddr3' binding uses binding 'lpddr2-timings'.
> >>
> >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> >> ---
> >>   .../devicetree/bindings/lpddr3/lpddr3-timings.txt  | 57 +++++++++++++
> >>   .../devicetree/bindings/lpddr3/lpddr3.txt          | 93 ++++++++++++++++++++++
> >
> > Please rename the lpddr2 directory to 'ddr' and add these to it.
> OK, I will rename it in the nex patch set.
> >
> > Maybe whatever properties are common should be put in a common doc.
> There are maybe a few common properties, but I would not dare to merge
> lpddr2 and lpddr3 before consulting it with TI engineers who made
> LPDDR2 support.

Why not. You aren't changing anything. Just rearranging.

> Could we work on a common file after the patch set got merged?

Yes, but please still move everything to a common directory.

> >
> >>   2 files changed, 150 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
> >>   create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
> >> new file mode 100644
> >> index 0000000..ebf3e00
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
> >> @@ -0,0 +1,57 @@
> >> +* AC timing parameters of LPDDR3 memories for a given speed-bin.
> >> +* The structures are based on LPDDR2 and extended where needed.
> >> +
> >> +Required properties:
> >> +- compatible : Should be "jedec,lpddr3-timings"
> >> +- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
> >> +- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
> >> +
> >> +Optional properties:
> >> +
> >> +The following properties represent AC timing parameters from the memory
> >> +data-sheet of the device for a given speed-bin. All these properties are
> >> +of type <u32> and the default unit is ps (pico seconds).
> >> +- tRFC
> >> +- tRRD
> >> +- tRPab
> >> +- tRPpb
> >> +- tRCD
> >> +- tRC
> >> +- tRAS
> >> +- tWTR
> >> +- tWR
> >> +- tRTP
> >> +- tW2W-C2C
> >> +- tR2R-C2C
> >> +- tFAW
> >> +- tXSR
> >> +- tXP
> >> +- tCKE
> >> +- tCKESR
> >> +- tMRD
> >> +
> >> +Example:
> >> +
> >> +timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
> >
> > Since the lpddr2 version was written, we've gotten stricter about
> > allowing unit-address without reg property. Perhaps 'reg' should be the
> > max-freq instead.
> OK, so I will rename 'max-freq' to 'reg' and add a comment with:
> '/* workaround: it shows max-freq */
> Does it make sense?

Sure.

Rob
