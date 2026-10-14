Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102A4CB8BC;
	Wed, 14 Oct 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980442; cv=none; b=i7kfuDCbahH0ovJoTAY3v8BD0/stvx6sY8frJBI2UjB7WEibGXltuNkuggY8BoEpF6F0GFyozL7kIOdSk8jCrj+pVXB6Ofrbtcisd++Xr5wOTFazvRkkc2N33IlZ1QRciK97oLb++YiEvhMaTczGgHYwlsVDQwVy5zDofAoQwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980442; c=relaxed/simple;
	bh=zOm0X0tNaeAbnH7T3HAeYVTqaME7q0cfX2ex2l5d7wo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=foIffZGUOIFTzy2DWJ5Mjooeccc0nvdePbPtVNLIJxXUq96lqmmioRDbsHztwnwjGE2O2AQPftOftnTJX6hm2LALSHsUc+xc1XyJRdujkRjCuPUG9dCSDwW1RzljAQB68hV729eL1PNxxz6B3sEyizSrk9bfXusqfZ3QFZN8XzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em9Xr0VW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em9Xr0VW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB741F000FF;
	Wed, 14 Oct 2026 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980440;
	bh=LZMVl0gBatkpFu1QINon5X3rRt2sPBbkS2s6o8Q7mYY=;
	h=From:Subject:Date:To:Cc;
	b=Em9Xr0VWgz7fLLZruCMyT+DbbOSUeVaiV+SsY0QLocaMFk2Rvo96LyPVjAnc/aaFd
	 e95z8g3aeL5Oo6GHuwJnAFh7GWNp3st/Y70jxxlTcSzoPd0l94uGyXZwT/rd4e03tb
	 7qvSaBYqkCtX/S1NUqT9mtZgGum3+BO+HWZHSCq25an2dAoiZJya7IGEnEXQ0fu8P8
	 hj5XOr1ZWTkW1FqTwbgAE04HZr0N+17DZvFrZ7EFEDZT700mCFNdYqS/+ucNqLnVp5
	 k0XkzArD3N0bpldfPotbqPjx8HieT8lVPw1lDVZ7MNEjbE6Bp8MJ7lJbuKq10Wn47L
	 v8qGFO7hoz1kQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [RFC PATCH 00/16] Centralize the ownership of power rail votes for
 Qualcomm clocks
Date: Wed, 14 Oct 2026 14:19:00 +0200
Message-Id: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1h1IhCr2KiLSxoxNK2onVgTx7
 o66fIv/VzAJKgaPZIUgs5oOfQTdEuD3s2/FaRMNKaYZIZKbhlHZ/bjm7ls3szcnvsDc473IiCB
 2YxCvy/ksq8v2f32Ep2ME27YDFuABxnUAAAA=
X-Change-ID: 20261001-topic-qc_clk_dvfs-ef907f059611
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=11004;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=zOm0X0tNaeAbnH7T3HAeYVTqaME7q0cfX2ex2l5d7wo=;
 b=98u7KzSIWTvY9Kg9mUGPBxk4uWuNt+KyDKuHyTxDv7/7O/R+IUu6Xhf1c30kN0w/U/Q/0x7ke
 mIDTTefb5wtDZpPl5m72c//ru2YvyHhKqlNcI8U5r9h4NsT3pGZ+QwS
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

On Qualcomm SoCs, both the PLLs and other types of clocks alike require
specific voltage rail levels to operate in-spec, but through the
separation and decentralization of clock and voltage votes, these
requirements are often not met and are never explicitly stated.
This results in clocks being undervolted, or at the very least a state
we're unable to reason about.

The devices consuming these clocks very rarely have their own
requirements in that regard. (1)

This series moves the frequency-power_domain-perf_state mappings inside
the clock drivers, ensuring a single, trusted source of truth is
established and that the silicon is no longer driven at out-of-spec
conditions.

To illustrate the nuances involved, here's a couple examples of hidden
dependencies, as found on SM8650:
* video_cc_mvs0_clk requires LOW_SVS to run at 900 MHz, but the
  PLL it sources the signal from requires SVS (higher corner) to
  produce that frequency. Similarly, to produce 1140 MHz, the clock
  requires SVS, but the PLL then requires SVS_L1.
  Analogous story for mvs1_clk.
* gpu_cc_gmu_clk requires MX to be at SVS to output 625 MHz, the PLL
  requires SVS_L1 to produce that frequency.
* A number of camera clocks follow the same pattern.
* Additionally, some clocks like cam_cc_cci_{0,1,2}_clk require
  MMCX to run at LOW_SVS, but the PLL has the additional requirement
  of keeping MXC (a wholly different rail) at SVS_L1.

There's a broad agreement that a consumer should only have to care
about the clock it consumes, and that configuring its parents is the
responsibility of the CCF. Requiring the consumers to care about the
above cases (as is the expectation today) is a clear violation of
that contract.

A clock controller may have on the order of hundreds of clocks, each
one with its own frequency-power map, and potentially all of them
could be similarly affected.

Recently, some drivers (Iris, CAMSS) have attempted to circumvent these
problems by holding a direct reference to the power rails and managing
the votes manually, through placing direct votes on each rail via an
OPP table. That however has a number of drawbacks:
* Because more than just one clock needs to be scaled at runtime, the
  OPP table either has to contain NUM_CLOCKS * NUM_RATES to handle
  that (which blows up pretty quickly), assume the worst case (and
  waste power), or ignore that problem (and undervolt the clock
  controller), instead of just being able to call set_rate() on each
  clock as needed
* The data ends up being dispersed across various consumers, even
  though it logically belongs to the clock controller, making it
  absolutely unauditable
* It's horrendously error-prone because of the number of clocks
  involved, the depth of the clock tree and the fact that at the end
  of the day, one still has to consult the clock controller
  documentation

The approach proposed here also happens to more naturally fit into the
process of how an SoC is brought up - clock controllers are always
the very first pieces that need to be complete before other IP blocks
can be brought up. And because of (1), enclosing the frequency-corner
data within the clock drivers takes a weight off of everyone else's
shoulders.

On a related topic, the GDSCs are modeled as children of *all* power
domains consumed by a clock controller at once. GDSCs are on/off switches
with some fancy logic attached to them and may need some (or none) rails
enabled to power on or off while meeting the hardware timing
requirements. Voting on them was never quite right in the first place
and is once again only a side-effect of the clocks' power requirements
not being handled centrally.

This series removes the vote propagation and the overly broad parent-
child links, resulting in dropping unnecessary/incorrect votes that are
now encapsulated by the clk-dvfs infrastructure. Big emphasis on (1)
once again.

The implementation is as follows:

Each clock describes the rail levels it needs at each frequency. The
new clk-dvfs helper combines these requirements and submits the
resulting votes through GenPD and RPMHPD. Votes remain held while a
clock is prepared, and rate or parent changes reserve the new
requirements before any clocks are reprogrammed. This also requires CCF
to report programming failures and OPP to retry failed transitions
instead of relying on stale cached state.

                Consumer: select rate, prepare clock
                                   |
                                   v
        +------------------------ CCF ----------------------+
        | Walk the clock tree and reserve resources          |
        | before programming rates or parents                |
        +--------------------------------------------------+
                                   |
                                   v
 +------------------------------------------------------------------+
 |                                                                    |
 |    GPLL9 ------> SDCC2 RCG -------> SDCC2 apps clock               |
 |      |               |                                             |
 |      |               |                         Other GCC clocks    |
 |      v               v                              |              |
 |  +------------+  +------------+                     v              |
 |  | PLL's own  |  | RCG's own  |          Per-clock requirements    |
 |  | rate table |  | rate table |                         |          |
 |  +-----+------+  +-----+------+                         |          |
 |        |               |                                |          |
 |        | CX            | CX + MX                        |          |
 |        v               v                                v          |
 |    +--------------------------------------------------------+      |
 |    |                  Clock-owned DVFS                        |    |
 |    |                                                          |    |
 |    | Prepared votes + temporary transition votes              |    |
 |    |                          |                               |    |
 |    |               Maximum requirement per rail               |    |
 |    +-----------+--------------+--------------+--------------+      |
 |                |              |              |                     |
 |            CX voter      CX_AO voter     MX voter                  |
 +----------------+-------------+-------------+---------------------+
                   |              |              |
                   v              v              v
       +----------------------- GenPD ----------------------+
       |      Aggregate GCC votes with other consumers       |
       +---------------------------------------------------+
                                  |
                                  v
                            +-----------+
                            |   RPMHPD  |
                            +-----------+

Straightening out all of the above lets us tackle another problem
with the upstream description of the power grid - the dependency
between various rails. Most notably:
* CX does NOT need to follow the performance state of MMCX
* MX/MXA/MXC and CX are co-dependent only on some platforms (in coarse
  terms, SM8350 and before)

However, the main part of series needs to land first to ensure that
dropping those relationships doesn't remove some wrongful votes the
system relied on to stay functional. Resolving that will save power and
finally ensure total stability as far as the providers are concerned.

SM8650 is used as an example in this series, but the conversion will
have to be done for all Qualcomm platforms. That will follow soon
after the patches are merged. DFS clocks are left out of this RFC to
reduce noise (the remaining diff is not particularly large but also
requires boilerplate changes to bus drivers).

dt-bindings changes are not included since it's an RFC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (16):
      clk: Propagate rate programming failures
      clk: Acquire resources for clock transitions
      OPP: Retry failed default single-clock transitions
      pmdomain: core: Support named indexed virtual attachments
      pmdomain: core: Support subdomains without pstate propagation
      pmdomain: core: Support indexed power-domain attachment lists
      clk: qcom: Add clock-owned GenPD DVFS aggregation
      clk: qcom: dvfs: Add debugfs
      clk: qcom: clk-alpha-pll: Add DVFS (un)prepare
      clk: qcom: clk-alpha-pll: Vote for the PLL calibration frequency
      clk: qcom: gdsc: Make GDSC parenting optional
      clk: qcom: gdsc: Link required power domains
      [DNM] arm64: dts: qcom: sm8650: Describe clock controller power rails
      [DNM] clk: qcom: Enable clk-dvfs on SM8650
      [DNM] arm64: dts: qcom: sm8650: Drop required-opps
      [DNM] pmdomain: qcom: rpmhpd: Stop forwarding MMCX pstate to CX

 arch/arm64/boot/dts/qcom/sm8650.dtsi        |  62 +--
 drivers/base/power/common.c                 |  24 +-
 drivers/clk/Makefile                        |   1 +
 drivers/clk/clk.c                           | 793 +++++++++++++++++++++++-----
 drivers/clk/clk_resource_test.c             | 376 +++++++++++++
 drivers/clk/clk_test.c                      | 194 ++++++-
 drivers/clk/qcom/Makefile                   |   1 +
 drivers/clk/qcom/camcc-sm8650.c             | 282 ++++++++++
 drivers/clk/qcom/clk-alpha-pll.c            | 317 ++++++++++-
 drivers/clk/qcom/clk-dvfs.c                 | 635 ++++++++++++++++++++++
 drivers/clk/qcom/clk-dvfs.h                 |  41 ++
 drivers/clk/qcom/clk-rcg2.c                 |  93 +++-
 drivers/clk/qcom/clk-regmap.h               |   6 +
 drivers/clk/qcom/common.c                   |  28 +-
 drivers/clk/qcom/common.h                   |   3 +
 drivers/clk/qcom/dispcc-sm8550.c            | 328 ++++++++++--
 drivers/clk/qcom/gcc-sm8650.c               | 261 +++++++++
 drivers/clk/qcom/gdsc.c                     | 154 +++++-
 drivers/clk/qcom/gdsc.h                     |   7 +
 drivers/clk/qcom/gpucc-sm8650.c             | 101 +++-
 drivers/clk/qcom/videocc-sm8550.c           | 135 ++++-
 drivers/opp/core.c                          |  72 ++-
 drivers/opp/opp.h                           |   2 +
 drivers/pmdomain/core.c                     |  60 ++-
 drivers/pmdomain/qcom/rpmhpd.c              |  14 +-
 include/dt-bindings/clock/qcom,sm8650-gcc.h |   2 +
 include/linux/clk-provider.h                |  39 ++
 include/linux/pm_domain.h                   |  33 +-
 28 files changed, 3734 insertions(+), 330 deletions(-)
---
base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
change-id: 20261001-topic-qc_clk_dvfs-ef907f059611

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

