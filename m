From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 05/13] dt-bindings: ddr: add LPDDR3 memories
Date: Tue, 7 May 2019 12:00:04 -0500
Message-ID: <20190507170004.GA20489@bogus>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838@eucas1p1.samsung.com>
 <1557155521-30949-6-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557155521-30949-6-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

On Mon, May 06, 2019 at 05:11:53PM +0200, Lukasz Luba wrote:
> Specifies the AC timing parameters of the LPDDR3 memory device.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/ddr/lpddr3-timings.txt     | 58 +++++++++++++
>  Documentation/devicetree/bindings/ddr/lpddr3.txt   | 97 ++++++++++++++++++++++
>  2 files changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
>  create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
> 
> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
> new file mode 100644
> index 0000000..3a2ef3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
> @@ -0,0 +1,58 @@
> +* AC timing parameters of LPDDR3 memories for a given speed-bin.
> +
> +The structures are based on LPDDR2 and extended where needed.
> +
> +Required properties:
> +- compatible : Should be "jedec,lpddr3-timings"
> +- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
> +- reg : maximum DDR clock frequency for the speed-bin. Type is <u32>
> +
> +Optional properties:
> +
> +The following properties represent AC timing parameters from the memory
> +data-sheet of the device for a given speed-bin. All these properties are
> +of type <u32> and the default unit is ps (pico seconds).
> +- tRFC
> +- tRRD
> +- tRPab
> +- tRPpb
> +- tRCD
> +- tRC
> +- tRAS
> +- tWTR
> +- tWR
> +- tRTP
> +- tW2W-C2C
> +- tR2R-C2C
> +- tFAW
> +- tXSR
> +- tXP
> +- tCKE
> +- tCKESR
> +- tMRD
> +
> +Example:
> +
> +timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {

Now the unit-address should be @800000000

With that and the other example fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +	compatible	= "jedec,lpddr3-timings";
> +	reg		= <800000000>; /* workaround: it shows max-freq */
> +	min-freq	= <100000000>;
