From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 04/13] dt-bindings: ddr: rename lpddr2 directory
Date: Tue, 7 May 2019 11:57:03 -0500
Message-ID: <20190507165703.GA20137@bogus>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654@eucas1p2.samsung.com>
 <1557155521-30949-5-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557155521-30949-5-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon,  6 May 2019 17:11:52 +0200, Lukasz Luba wrote:
> Change directory name to be ready for new types of memories.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/ddr/lpddr2-timings.txt     |  52 +++++++++++
>  Documentation/devicetree/bindings/ddr/lpddr2.txt   | 102 +++++++++++++++++++++
>  .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |  52 -----------
>  .../devicetree/bindings/lpddr2/lpddr2.txt          | 102 ---------------------
>  4 files changed, 154 insertions(+), 154 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
>  create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2.txt
>  delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
>  delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
