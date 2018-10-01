From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
Date: Mon, 1 Oct 2018 12:36:09 -0500
Message-ID: <CAL_Jsq+dSGXCiWsjLt00wu=s-ZW8M1pkQqKFWboc54M8gHFTYg@mail.gmail.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-5-vivek.gautam@codeaurora.org> <20181001121857.GA31488@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001121857.GA31488@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, alex.williamson@redhat.com, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Clark <robdclark@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>, Stephen Boyd <sboyd@kernel.org>, Tomasz Figa <tfiga@chromium.org>, Jordan Crouse <jcrouse@codeaurora.org>, Sricharan <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 1, 2018 at 7:18 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Aug 30, 2018 at 08:15:40PM +0530, Vivek Gautam wrote:
> > Add bindings doc for Qcom's smmu-v2 implementation.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.txt         | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
>
> It would be nice to have an Ack from a DT maintainer on this, since it's
> adding new compatible strings...

I did...

Rob
