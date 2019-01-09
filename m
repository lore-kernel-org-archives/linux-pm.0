From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v7 0/6] arm64: dts: Add sdm845 GPU/GMU and SMMU
Date: Wed, 9 Jan 2019 14:16:28 -0500
Message-ID: <CAF6AEGvuzcFxsNv+MO_B50eA8ztemc0VXe0dSQLARPprTvyAbQ@mail.gmail.com>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <CAD=FV=XLWUwkQLStKzV5DGji0WNEk44ft51NTWJmQNG7GW4Rkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAD=FV=XLWUwkQLStKzV5DGji0WNEk44ft51NTWJmQNG7GW4Rkg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Doug Anderson <dianders@chromium.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Jordan Crouse <jcrouse@codeaurora.org>, vireshk@kernel.org, Andy Gross <andy.gross@linaro.org>, freedreno <freedreno@lists.freedesktop.org>, Georgi Djakov <georgi.djakov@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 9, 2019 at 1:20 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi Rob,
>
> On Tue, Dec 18, 2018 at 10:32 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Now that more of the sdm845 bindings are headed upstream this a refresh of
> > of https://patchwork.freedesktop.org/series/39308/ to add bindings and nodes
> > for the GPU/GMU and GPU SMMU for sdm845. v7 of this patchset also removes
> > interrupt-names from the driver and the existing DT changes per feedback from
> > Rob Herring.
> >
> > This is based on :
> > git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next
> >
> > with:
> > https://lore.kernel.org/patchwork/patch/1018365/
> >
> > This change requires the following dependencies:
> >
> > include/dt-bindings/power/qcom-rpmpd.h:
> > https://patchwork.kernel.org/patch/10711119/
> >
> > qcom,smmu-v2 binding:
> > https://patchwork.kernel.org/patch/10581911/
> >
> > v7: Add patches to remove interrupt-names, add version specific compatible
> >     string for gmu
> > v6: Update GPU bindings for a6xx and make the examples match the nodes and vice
> >  versa.  Clean up types and rebase on
> >  https://lore.kernel.org/patchwork/patch/1018365/ to help facilitate merging.
> > v5: Use symbolic names for the RPMH power levels defined in OPP table,
> >  move the opp tables as children of their respective nodes and rename
> >  the iommu device.
> > v4: Rebase
> > v3: Split GMU PDC region into two GPU specific sections, fix indentation,
> >   really use qcom,gmu for the phandle name
> > v2: changed qcom,arc-level to qcom,level following discussion with Viresh;
> >   change gmu phandle to qcom,gmu per Rob
> >
> > Jordan Crouse (6):
> >   drm/msm/gpu: Remove hardcoded interrupt name
> >   drm/msm: drop interrupt-names
> >   ARM: dts: qcom: Removed unused interrupt-names from GPU node
> >   arm64: dts: qcom: msm8916: Remove unused interrupt-names from GPU
> >   dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings
> >   arm64: dts: sdm845: Add gpu and gmu device nodes
>
> I know it's been holidays and everyone (including me) has been on
> vacation, but just wanted to make sure the current status of this
> series was explicitly called out.  :-)
>
>
> I believe patches #1 and #2 are ready to land and will go through your tree.
>
> Patches #3 and #4 should probably go through Andy's tree and are not
> urgent (they are just cleanup).  They can sit on the back burner until
> patches #1 and #2 have hit mainline.  That's a good reason to land #1
> and #2 sooner.  ;-)
>
> I think patch #5 is also ready to land.  There's been some
> bikeshedding about the exact format for the opp table, but none of
> that bikeshedding affects the bindings that Jordan wrote.  If you
> agree that this is OK to land, it would also be nice to get in.
>
> ...then Jordan can spin patch #6 (once Rob H Acks Rajendra's opp
> bindings) alone at a future date.
>

I've picked up 1+2 and 5..  I assume it makes more sense for agross to
pick up the rest?

BR,
-R
