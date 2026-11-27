Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796829;
	b=nPqZtFX9sIGTMLS/6UJiXp3PY9W3i+CtIfPgoKsESRyrizmMbW2v4HzxnfE/5NPTC6Nh
	 f6w+I2/9sAiKgDkyVBjq48g/7v0GP5wc+Er2YX9+6sliKmCM8DG74IDiGx43NaAJ0/j4y
	 pgeFg4Ksqm8p/2/olz5gQi6dIPJu1SL7mZtsfCl8p6igvNfnngqmfE4z8RE6SkOuxs3G4
	 x6wMrqIQFj3fid8vanZPyYjAJ2PT+G1GwnrGWcoKQ4UuDnbss8a3vGqdubpNvKv4xHZYU
	 NBbWLi7JIGPtvE5/2/dJMQ81W2kUFN5hP3cYqT63FvjzZpELI96h2HOE1oBsCeyE+8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796829;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XvtmZcByH+ZD3l40tZk/FLZ4t2ZBRXU4DITeOL9Qe6A=;
	b=EnashRwBxg3GBxAPe6t4PvOmv6ft8Jsq/r4A/xyqtapHppFqTspcPYwzoM8uCJjr5+O6
	 4tllp0O16VNU+cXMg1QpIAfzpk9sSZ3PjUPRQuTf6/OCj992zWWWvmh7lFCnONrtzEHwp
	 UEdxmkYXYPepuPI2dmUs4U4I3PJ/YrPK+RNBKBLOdMCxsfqDmyDeORpl98bhiWOEd6LPC
	 medzZwEESGYfuQzbyGer9yz4aHD2KHpbhePg312MQ1WIJ8kg8y6L2YKU/dQ00ot7cspvF
	 IQG8Y6o6AErVTLtTtsAArUJtNYsc1XI1VRcRmtlhJBNu/cCfIT37hnrqdtznScWZQwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSEMqk1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621B606A31E;
	Fri, 27 Nov 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSEMqk1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242741F00897;
	Fri, 27 Nov 2026 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796829;
	bh=XvtmZcByH+ZD3l40tZk/FLZ4t2ZBRXU4DITeOL9Qe6A=;
	h=From:To:Cc:Subject:Date;
	b=iSEMqk1wn93fXAUwsu9WKpGCGPwABeIagPegKpaGdXeobKX/hnpn0a7QN+h4rZfFu
	 l0x9TmRrxpZOKOxct2m3maEo2A4G897BNn+bvr7hBsokEvcO9FzMrLAEmBJizioKKw
	 XPCSm+CNeVOgQ2UY/puj/CvVX+8+O1P6C+IhPwXDp+uFDh/AQP9Sw/m1vY16t9mOFQ
	 vFqUd+4Fezlvuu1hwOOCMwyaGbkzeK+Pmv41sg//E/E8+V4SGuwR1CRK88V1tuocwD
	 hs08J1H32QSKRNfaEx0vppTN3owai1o3tPsS8NN2m5Ay0mfF4grtMCE3nBapjrDIrl
	 MIR9acz5BC0YA==
From: Geert Uytterhoeven <geert@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 00/14] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
Date: Fri, 27 Nov 2026 17:26:45 +0100
Message-ID: <cover.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

TL;DR:

    Describe hardware in DT, and perform mapping to abstractions offered
    by SCMI in Linux.

The Renesas R-Car X5H-based Ironhide board is the first Renesas
SoC/board combination that implements the ARM System Control and
Management Interface (SCMI).

This means Linux can no longer perform various system operations (e.g.
clock, power domain, and reset control) by accessing the hardware
directly.  Instead, these operations are abstracted according to various
SCMI sub-protocols, and Linux has to send messages to an SCMI-compliant
firmware running on a System Control Processor (SCP).
More specifically, the R-Car X5H SCP FW SCMI controls access to:
  1. Core clocks and module clocks,
  2. Module resets,
  3. Power domains,
  4. System power.
The latter is not relevant for this discussion.

Using SCMI also has an impact on the board DTS: besides the addition of
a firmware/scmi node with protocol-specific subnodes, devices using
SCMI-abstracted system resources now have to refer to these resources
using resource specifiers containing phandles to the SCMI protocol
subnodes, and firmware-specific object IDs[1].

Unfortunately we encountered several issues with this:
  - The clock, reset, and power domain IDs are not stable by design,
    causing DT incompatibilities.
    SCMI requires that the ID space exposed to an agent (i.e. Linux)
    starts at zero and is contiguous.  Hence any change in system
    partitioning (Application CPU core vs. Realtime CPU core,
    virtualization, ...) may mean a renumbering of all SCMI IDs,
    implying a massive change to the DT.
  - There may be different SCP firmware lineages, e.g. proprietary and
    certified variants, and FLOSS variants,
  - SCMI features may differ across firmware versions,
  - SCMI may abstract the hardware in a different way, requiring changes
    in (possibly existing) DT bindings and drivers to support the same
    hardware with and without SCMI:
      - E.g. the number of SCMI clocks inputs to a hardware block may
	differ from the actual hardware,
      - E.g. hardware clock inputs may be abstracted as SCMI power
	domains (or vice versa), like on Qualcomm SA8255P[2].
    Experience has taught that not describing the hardware in DT may
    lead to major issues later.
  - SCMI does not support the concept of a clock domain, so existing
    drivers can no longer rely on Runtime PM, but need to be changed to
    manage functional clocks explicitly,
  - U-Boot IPL (Initial Program Loader) needs a proper hardware
    description in DT, not using SCMI.

This list deliberately ignores ID instability and the need for SCMI
quirks during development of the SCMI firmware.  While upstream Linux
must only support sufficiently mature firmware versions, vendor trees
(e.g. renesas-lts) may still want to support development firmware
versions.

During last OSSJ+LPC, Marek Vasut pondered if we could keep our own ID
lists stable, and perform a mapping to the IDs used by the actual SCMI
implementation running on the system.  This was also briefly discussed
at LPC[3].  After some refining of the initial idea, this series takes a
slightly different approach, by:
  1. Describing the actual hardware components in DT, plus a minimum
     SCMI glue,
  2. Mapping DT hardware descriptions to SCMI-backed objects and
     abstractions (or replacements, in case they are unusable,
     unavailable, or too different), in Linux drivers, based on the
     detected firmware version.

This has the following advantages:
  1. The DT ABI is stable,
  2. DT bindings and drivers for existing hardware blocks do not need to
     be modified,
  2. Current and future firmware can be handled in driver code,
  3. U-Boot IPL can use almost the same DT; it just needs stripping of
     the SCMI node and subnodes,
  4. If ever needed, the Clock Pulse Generator (CPG) and Module
     Controller (MDLC) drivers can be extended to program the hardware
     directly if SCMI is not present,

Last month I gave a presentation about the issues and our solution at
ELCE2026 in Prague[4].

This series consists of four parts:
  A. Patches 1-5 prepare and add SCMI remapping support to the R-Car X5H
     CPG clock driver,
  B. Patches 6-9 fix and add new interfaces needed for remapping in the
     R-Car X5H MDLC pmdomain driver,
  C. Patches 10-13 prepare and add SCMI remapping support to the R-Car
     X5H MDLC pmdomain driver,
  D. Patch 14 enables more SCMI protocols on R-Car X5H Ironhide.

Dependencies and merge strategy:
  - A targets the renesas-clk tree,
  - C depends on B, so both target the pmdomain tree,
  - D depends on A, B, C, and out-of-tree SCMI quirks, so needs to be
    postponed.

Changes compared to v5[5]:
  - Drop "pmdomain: Make genpd_get_from_provider() always return on
    first match" (applied),
  - Add Reviewed-by,
  - Clarify that fw_id printing will be readded later,
  - Move local variables to loop scope where possible,
  - Add and use MAP_FIXED() macro to populate r8a78000_cpg_default[],
    to prevent accidental inclusion of SCMI firmware clock IDs,
  - Explain use of FIXED_CLK_OFFSET,
  - Rebase,
  - Add more clarification about other genpd_get_from_provider()
    callsites,
  - Register devm_add_action_or_reset() callback in get_rstcs() so
    resets are released on subsequent failures,
  - Add "r8a78000_mdlc_"-prefix to get_genpds() and get_rstcs(),

Changes compared to v4[6]:
  - New patches:
      - "[01/15] clk: renesas: r8a78000: Merge debug prints in
	 r8a78000_clk_get()",
      - "[02/15] clk: renesas: r8a78000: Replace sentinel by explicit ID
	 map size",
      - "[03/15] clk: renesas: r8a78000: Shrink IDs to 16 bits",
      - "[08/15] pmdomain: Make genpd_get_from_provider() always",
      - "[11/15] pmdomain: renesas: r8a78000: Drop MDLC name comment",
      - "[12/15] pmdomain: renesas: r8a78000: Replace sentinel by",
      - "[13/15] pmdomain: renesas: r8a78000: Shrink IDs to 16 bits",
  - Add Tested-by (I retained Wolfram's tag, as the inner workings
    haven't changed),
  - Add Reviewed-by,
  - Rebase,
  - Shrink DT, hardware, and firmware IDs to 16 bits,
  - Rework mapping data structures, keeping the original ID maps and
    adding separate arrays of clk_hw, genpd, and reset pointers,
  - Use kzalloc_objs() and __free() for the temporary array of fixed
    clocks,
  - Use new *alloc_obj*() allocators,
  - Add missing clk_put() after of_clk_get_from_provider() in get_hws(),
  - Move of_node_get() after for-loop that may fail to fix device node
    reference leak on failure,
  - Add support for missing SCMI firmware IDs indicated by -1,
  - Fix double clk_put() in pm_clk_add_clk() error handling,
  - Fix reset control leaks in fill_mod_map() error path,
  - Fix scmi_clk_np reference leak by marking it __free(), and
    retaining it explicitly on probe success.
  - Drop unneeded mdlc name comments,
  - More details can be found in the individual patches.

Changes compared to v3[7]:
  - Remove dependencies by making assumptions and dropping disputed
    items, to move this series forward:
      - Assume all SCMI IDs are stable.
        This let us drop the addition of scmi_get_base_info(), and
	support for handling different ID spaces.
      - Drop the "renesas,scmi-firmware" DT property, and find a device
        node compatible with "arm,scmi" instead.
        This let us drop the addition of fw_devlink support for this
	property, too, but required a new probe deferral fix in the
	pmdomain code: "pmdomain: Make genpd_get_from_provider() return
	-EPROBE_DEFER".
	This will have to be revisited when systems with multiple SCMI
	providers appear.
  - Drop unneeded IS_ERR() check after __clk_get_hw(),
  - Mark scmi_{clk,reset,power}_np __free(device_node),
  - Include initial mapping tables for R-Car X5H SCP FW SDKv4.31.0 and
    later, supporting clocks, power domains, and resets used by serial,
    I2C, and SPI devices.
  - Try SCMI clocks first, and fall back to the default fixed-frequency
    clocks when not available, as recent firmware versions no longer
    restrict access to some bus clocks,
  - Fall back to the non-SCMI defaults when SCMI provider support is
    disabled,
  - Keep RESET_CONTROL_FLAGS_BIT_OPTIONAL clearing in
    __fwnode_reset_control_get(),
  - Return directly in __reset_control_get_from_provider(), instead of
    assigning to a local variable, letting us drop the latter and
    simplify scoped_guard() to plain guard(),
  - Add Reviewed-by,
  - Check for overflow when converting (u64) fwnode args to (uint32_t)
    OF args,
  - Document that reset_control_get_from_provider_exclusive() must not
    be given a reference to a GPIO provider,
  - Let the dummy return ERR_PTR(-ENOTSUPP) instead of NULL,
  - Improve patch description,
  - Let r8a78000_mdlc_attach_dev() return success when the MDLC instance
    is not found, to avoid breaking users referring in DT to an SCMI
    power-domain directly,
  - Extract scmi_get_clk(),
  - Add support for gateable functional clock parents,
  - Propagate all reset failures, as SCP FW SDKv4.28.0 which restricted
    HSCIF0 reset is no longer supported.

Changes compared to v2[8]:
  - New patches:
    "[PATCH v3 06/12] reset: Extract __reset_control_get_from_provider()",
    "[PATCH v3 08/12] clk: renesas: r8a78000: Add clk_hw to clk_map",
  - Move DT binding patches forward in series,
  - Add "renesas" vendor prefix and "scmi-" function prefix to the
    "firmware" property (I still think the vendor property should be
    dropped, or replaced by "arm"),
  - Add "of_" prefix to genpd_get_from_provider(),
  - Replace reset_controller_get_provider() by
    reset_control_get_from_provider_exclusive(),
  - Add kerneldoc,
  - Rebase,
  - Consistently use /* sentinel */ for zero sentinels,
  - Call reset_control_*() APIs instead of internal reset_control_ops
    methods,
  - Rename struct mod_map to struct mod_map_in,
  - Add struct mod_map, which also contains a reset_control pointer,
  - Add fill_mod_map() to obtain all SCMI reset_control structures
    up-front, as one can no longer use lazy look-up,
  - Prefix DEFINE_MDLC_RESET_WRAPPER() parameters with underscores.

Changes compared to v1[9]:
  - Drop SCMI quirks and SCMI mapping tables,
  - Move CPG/MDLC DT bindings and minimal base drivers to a separate
    series,
  - Add that SCMI may provide different abstractions,
  - Add missing asterisk to blank kerneldoc line,
  - Let scmi_get_base_info() return -EPROBE_DEFER or -EOPNOTSUPP instead
    of -ENOENT, and propagate these errors in callers,
  - Fall back to the default support when SCMI support or firmware is
    not available, or when the detected SCMI firmware version is not
    supported by the driver,
  - Improve error message on scmi_get_base_info() failure,
  - Check if SCMI firmware node is available,
  - Use reverse xmas ordering in r8a78000_cpg_probe(),
  - Replace the scmi_*_np members of struct r8a78000_*_priv by local
    variables in the probe functions, and pass them to the fill_*_map()
    functions,
  - Join split short lines,
  - Move check for supported firmware version up,
  - Fix DT misindentations,
  - Add scmi_clk node, as it is no longer added in earlier commits.

Notes:
  - In reponse of feedback on v1, I did try to use SCMI IDs in DT, and
    handle most issues in Linux SCMI drivers and SCMI quirks[10].  While
    the result worked, it did not solve everything in the issues list
    above.
  - This series does not include actual SCMI quirks; the SCMI firmware
    for R-Car X5H is still under development.

For testing, I have pushed this series plus additional work to[11].
This has been tested on the Ironhide board with R-Car X5H SCP FW
SDKv4.36.0 and SDKv4.39.0.

Thanks for your comments!

 [1] Documentation/devicetree/bindings/firmware/arm,scmi.yaml
 [2] "[PATCH net-next v11 1/7] dt-bindings: phy: document the serdes PHY on sa8255p"
     https://lore.kernel.org/20260629-qcom-sa8255p-emac-v11-1-1b7fb95b51f9@oss.qualcomm.com
 [3] "Firmware ABI stability" at Linux Plumbers Conference 2025
     https://lpc.events/event/19/contributions/2153/
 [4] "Marrying Device Tree and SCMI"
     https://osselceu2026.sched.com/event/2RaWR
     https://www.youtube.com/watch?v=z6Apgkm3fD4
 [5] "[PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping support"
     https://lore.kernel.org/cover.1795029012.git.geert+renesas@glider.be
 [6] "[PATCH v4 0/8] R-Car X5H Ironhide CPG/MDLC SCMI remapping support"
     https://lore.kernel.org/cover.1792163045.git.geert+renesas@glider.be
 [7] "[PATCH v3 00/12] R-Car X5H Ironhide CPG/MDLC SCMI remapping
      support"
     https://lore.kernel.org/cover.1788338320.git.geert+renesas@glider.be
 [8] "[PATCH v2 00/10] R-Car X5H Ironhide CPG/MDLC SCMI remapping
      support"
     https://lore.kernel.org/cover.1783505329.git.geert+renesas@glider.be
 [9] "[PATCH/RFC 00/14] R-Car X5H Ironhide SCMI CPG/MDLC remapping"
     https://lore.kernel.org/cover.1776793163.git.geert+renesas@glider.be
[10] "[PATCH/RFC 0/9] R-Car X5H Ironhide pure SCMI proof-of-concept"
     https://lore.kernel.org/cover.1781171705.git.geert+renesas@glider.be
[11] topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v6 branch of
     https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git


Geert Uytterhoeven (14):
  clk: renesas: r8a78000: Merge debug prints in r8a78000_clk_get()
  clk: renesas: r8a78000: Replace sentinel by explicit ID map size
  clk: renesas: r8a78000: Shrink IDs to 16 bits
  clk: renesas: r8a78000: Add clk_hw to clk_map
  clk: renesas: r8a78000: Add SCMI remapping support
  reset: Extract __reset_control_get_from_provider()
  reset: Add reset_control_get_from_provider_exclusive()
  pmdomain: Make genpd_get_from_provider() return -EPROBE_DEFER
  pmdomain: Make genpd_get_from_provider() public
  pmdomain: renesas: r8a78000: Drop MDLC name comment
  pmdomain: renesas: r8a78000: Replace sentinel by explicit ID map size
  pmdomain: renesas: r8a78000: Shrink IDs to 16 bits
  pmdomain: renesas: r8a78000: Add SCMI remapping support
  arm64: dts: renesas: ironhide: Enable SCMI devpd, sys, clock, and
    reset

 .../boot/dts/renesas/r8a78000-ironhide.dts    |  19 +
 drivers/clk/renesas/r8a78000-cpg.c            | 254 ++++++++--
 drivers/pmdomain/core.c                       |  26 +-
 drivers/pmdomain/renesas/r8a78000-mdlc.c      | 479 ++++++++++++++++--
 drivers/reset/core.c                          | 115 +++--
 include/linux/pm_domain.h                     |   7 +
 include/linux/reset.h                         |   8 +
 7 files changed, 754 insertions(+), 154 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
