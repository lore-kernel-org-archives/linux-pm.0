From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v6 0/3] Stingray thermal driver support
Date: Fri, 15 Feb 2019 09:50:51 +0530
Message-ID: <CABe79T4bcNs9efLRt1OsTekT+9PHq837x0fngf0kGUdkC5mMsA@mail.gmail.com>
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
 <a6113115-453c-4606-f99d-c79263d8f4bb@broadcom.com> <20190205235811.GA19687@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205235811.GA19687@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Ray Jui <ray.jui@broadcom.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

Could you please provide your review comments?

Regards,
Srinath.

On Wed, Feb 6, 2019 at 5:28 AM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hello,
>
> On Mon, Feb 04, 2019 at 04:16:19PM -0800, Ray Jui wrote:
> > Hi Zhang/Eduardo,
> >
> > Can this patch series be merged? It looks like Srinath has addressed all
> > review comments?
>
> I will take a look. Side note, thermal patches are reviewed on
> linux-pm@vger.kernel.org. Copying that list it does help because that
> is how the patches get assigned in patchwork.kernel.org.
>
> >
> > The following tag should be added to the binding document patch:
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Thanks,
> >
> > Ray
> >
> > On 1/3/2019 12:55 AM, Srinath Mannam wrote:
> > > These patches adds the stingray thermal driver and its
> > > corresponding DT nodes with documentation.
> > >
> > > Changes from v5
> > >   - Addressed Eduardo Valentin comments.
> > >
> > > Changes from v4
> > >   - Addressed Rob Herring comments on DT parameters and
> > >     thermal driver architecture.
> > >   - Removed brcm,max-crit-temp DT parameter
> > >   - Changed driver to thermal sensor registration model.
> > >   - Added trip DT properties.
> > >
> > > Changes from v3
> > >   - Addressed Daniel lezcano comments.
> > >   - Elaborated commit description of thermal driver patch.
> > >   - Added brcm,max-crit-temp DT parameter.
> > >
> > > Changes from v2:
> > >   - All stingray TMON DT nodes are combine together into single.
> > >     Temperature registers are combined into one mem resource.
> > >     brcm,tmon-mask parameter has available TMONs mask value.
> > >   - All available TMONs are initialized together in single
> > >     instance of driver probe call.
> > >
> > > Changes from v1:
> > >   - Fixed auto build sparce warning.
> > >
> > > Pramod Kumar (3):
> > >   dt-bindings: thermal: Add binding document for SR thermal
> > >   thermal: broadcom: Add Stingray thermal driver
> > >   arm64: dts: stingray: Add Stingray Thermal DT support.
> > >
> > >  .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++++
> > >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++++
> > >  drivers/thermal/Kconfig                            |   3 +-
> > >  drivers/thermal/broadcom/Kconfig                   |   9 ++
> > >  drivers/thermal/broadcom/Makefile                  |   1 +
> > >  drivers/thermal/broadcom/sr-thermal.c              | 122 +++++++++++++++++++++
> > >  6 files changed, 328 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> > >  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> > >
