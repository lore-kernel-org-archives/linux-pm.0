From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v6 00/11] qcom: Add support for TSENS driver
Date: Thu, 28 Jul 2016 16:55:20 +0800
Message-ID: <1469696120.2367.107.camel@intel.com>
References: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
	 <575A57F8.6060004@codeaurora.org> <576391B3.7090508@codeaurora.org>
	 <57749F20.4010700@codeaurora.org> <1469694828.2367.102.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1469694828.2367.102.camel@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, edubezval@gmail.com, andy.gross@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

On =E5=9B=9B, 2016-07-28 at 16:33 +0800, Zhang Rui wrote:
> Hi, Rajendra,
>=20
> On =E5=9B=9B, 2016-06-30 at 09:55 +0530, Rajendra Nayak wrote:
> >=20
> > Rui,
> >=20
> > On 06/17/2016 11:29 AM, Nayak, Rajendra wrote:
> > >=20
> > >=20
> > > Hey Eduardo,
> > >=20
> > > On 6/10/2016 11:32 AM, Rajendra Nayak wrote:
> > > >=20
> > > >=20
> > > > Eduardo,
> > > >=20
> > > > On 05/05/2016 02:21 PM, Rajendra Nayak wrote:
> > > > >=20
> > > > >=20
> > > > > Current set of patches apply on 4.6-rc6. Fixes for the nvmem
> > > > > apis
> > > > > are now posted [1] and queued in -next [2]
> > > > > Patches [1-6] will need to be merged via thermal
> > > > > tree/Eduardo.
> > > > Any plans to pull these in for 4.8?
> > > These patches have been on the list for quite a while, and they
> > > do not have any outstanding dependencies or comments to be
> > > addressed. I would really hope to see these in for 4.8.
> > > Let me know if there is something you want me to address before
> > > you pull them in.
> > Would you be able to pull this driver in? I haven't heard back
> > anything from Eduardo despite multiple pings.
> > These patches (v6) have been on the list for a couple months now,
> > which address all issues/concerns that were raised by Eduardo
> > in his previous reviews.
> >=20
> Sorry for my late response as I took medical leave earlier this month
> for a noise surgery and I'm just back to work.
>=20
> I synced with Eduardo yesterday, he was also really busy recently,
> but
> he will go through the pending patches soon.
> So, for this patch set, I still prefer to let Eduardo to take it if
> he
> has time, and I will take them if you still don't get feedback from
> Eduardo after the merge window, does this sound okay for you?
>=20
Hah, it seems that Eduardo has already took your patches, sorry for the
noise. :)

thanks,
rui
> thanks,
> rui
>=20
> >=20
> > regards,
> > Rajendra
> >=20
> > >=20
> > >=20
> > >=20
> > > regards,
> > > Rajendra
> > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > regards,
> > > > Rajendra
> > > >=20
> > > > >=20
> > > > >=20
> > > > > Patches [7-11] will need to go via qcom-msm tree/Andy.
> > > > >=20
> > > > > Changes since v5:
> > > > > * Minor review fixes from Eduardo
> > > > >=20
> > > > > Changes since v4:
> > > > > * dropped qcom,tsens-slopes binding, used coefficients
> > > > > instead
> > > > > * dropped qcom,sensor-id binding
> > > > > * Added support for msm8996 family
> > > > > * Other minor review fixes from v4
> > > > >=20
> > > > > Changes since v3:
> > > > > * Dropped 'clk: qcom: create virtual child device for TSENS'
> > > > > which
> > > > > is picked up by Stephen
> > > > > * Updated GCC bindings with optional TSENS properties
> > > > >=20
> > > > > Changes since v2:
> > > > > * Minor review fixes from Stephen/Punit and rebase on 4.3-rc4
> > > > >=20
> > > > > Changes since v1:
> > > > > * Created virtual tsens device from gcc driver for 8960,
> > > > > with DT having a single node for gcc and tsens
> > > > > * Minor fixes with rebasing on 4.3-rc1
> > > > >=20
> > > > > Changes since RFC:
> > > > > * Added support for 8916 and 8084
> > > > > * Based off the latest nvmem framework patches [1]
> > > > > * Minor review fixes for comments mostly from Lina
> > > > >=20
> > > > > This is an attempt to have a single TSENS driver for
> > > > > the different versions of the TSENS IP that exist, on
> > > > > different qcom msm/apq SoCs'
> > > > > Support is added for msm8916, msm8960, msm8974 and msm8996
> > > > > families.
> > > > >=20
> > > > > A lot of the work is based of original code from Stephen Boyd
> > > > > and Siddartha Mohanadoss. I have also picked some of what
> > > > > Narendran Rajan did in his attempt to upstream the support
> > > > > for 8960 family. I could not keep the original authorship on
> > > > > any of the patches because I ended up moving the code around
> > > > > quite a bit in an effort to have a single driver for the
> > > > > various devices. I would be glad to change the authorship
> > > > > for any of the patches if needed.
> > > > >=20
> > > > > [1] https://lkml.org/lkml/2016/4/24/103
> > > > > [2]
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> > > > > misc.git char-misc-next
> > > > >=20
> > > > > Rajendra Nayak (11):
> > > > > =C2=A0=C2=A0=C2=A0thermal: qcom: tsens: Add a skeletal TSENS =
drivers
> > > > > =C2=A0=C2=A0=C2=A0thermal: qcom: tsens-8916: Add support for =
8916 family of
> > > > > SoCs
> > > > > =C2=A0=C2=A0=C2=A0thermal: qcom: tsens-8974: Add support for =
8974 family of
> > > > > SoCs
> > > > > =C2=A0=C2=A0=C2=A0thermal: core: export apis to get slope and=
 offset
> > > > > =C2=A0=C2=A0=C2=A0thermal: qcom: tsens-8960: Add support for =
8960 family of
> > > > > SoCs
> > > > > =C2=A0=C2=A0=C2=A0thermal: qcom: tsens-8996: Add support for =
8996 family of
> > > > > SoCs
> > > > > =C2=A0=C2=A0=C2=A0arm: dts: msm8974: Add thermal zones, tsens=
 and qfprom
> > > > > nodes
> > > > > =C2=A0=C2=A0=C2=A0arm: dts: apq8064: Add thermal zones, tsens=
 and qfprom
> > > > > nodes
> > > > > =C2=A0=C2=A0=C2=A0arm: dts: apq8084: Add thermal zones, tsens=
 and qfprom
> > > > > nodes
> > > > > =C2=A0=C2=A0=C2=A0arm64: dts: msm8916: Add thermal zones, tse=
ns and qfprom
> > > > > nodes
> > > > > =C2=A0=C2=A0=C2=A0arm64: dts: msm8996: Add thermal zones, tse=
ns and qfprom
> > > > > nodes
> > > > >=20
> > > > > =C2=A0 .../devicetree/bindings/clock/qcom,gcc.txt=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A018 ++
> > > > > =C2=A0 .../devicetree/bindings/thermal/qcom-tsens.txt=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A021 ++
> > > > > =C2=A0 Documentation/thermal/sysfs-api.txt=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A012 +
> > > > > =C2=A0 arch/arm/boot/dts/qcom-apq8064.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 103
> > > > > ++++++++
> > > > > =C2=A0 arch/arm/boot/dts/qcom-apq8084.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 103
> > > > > ++++++++
> > > > > =C2=A0 arch/arm/boot/dts/qcom-msm8974.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 103
> > > > > ++++++++
> > > > > =C2=A0 arch/arm64/boot/dts/qcom/msm8916.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A064
> > > > > +++++
> > > > > =C2=A0 arch/arm64/boot/dts/qcom/msm8996.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A092
> > > > > +++++++
> > > > > =C2=A0 drivers/thermal/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A0=C2=A05 +
> > > > > =C2=A0 drivers/thermal/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=
=C2=A01 +
> > > > > =C2=A0 drivers/thermal/qcom/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A011 +
> > > > > =C2=A0 drivers/thermal/qcom/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +
> > > > > =C2=A0 drivers/thermal/qcom/tsens-8916.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 113
> > > > > ++++++++
> > > > > =C2=A0 drivers/thermal/qcom/tsens-8960.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 292
> > > > > +++++++++++++++++++++
> > > > > =C2=A0 drivers/thermal/qcom/tsens-8974.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| 244
> > > > > +++++++++++++++++
> > > > > =C2=A0 drivers/thermal/qcom/tsens-8996.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A084
> > > > > ++++++
> > > > > =C2=A0 drivers/thermal/qcom/tsens-common.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| 141
> > > > > ++++++++++
> > > > > =C2=A0 drivers/thermal/qcom/tsens.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 200
> > > > > ++++++++++++++
> > > > > =C2=A0 drivers/thermal/qcom/tsens.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A092
> > > > > +++++++
> > > > > =C2=A0 drivers/thermal/thermal_core.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A030
> > > > > +++
> > > > > =C2=A0 include/linux/thermal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A0=C2=A08 +
> > > > > =C2=A0 21 files changed, 1739 insertions(+)
> > > > > =C2=A0 create mode 100644
> > > > > Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/Kconfig
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/Makefile
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/tsens-8916.c
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/tsens-8960.c
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/tsens-8974.c
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/tsens-8996.c
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/tsens-common.c
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/tsens.c
> > > > > =C2=A0 create mode 100644 drivers/thermal/qcom/tsens.h
> > > > >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
