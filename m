From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v5 0/3] ARM: defining idle states DT bindings
Date: Tue, 18 Mar 2014 11:28:49 +0000
Message-ID: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Capella <sebastian.capella@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Dave Martin <dave.martin@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>Mark
List-Id: linux-pm@vger.kernel.org

This is v5 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233478.html

This patchset depends on the following bindings to be approved and augmented
to cater for hierarchical power domains in DT:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237479.html

Changes in v5:

- Added missing power-domain property in cpu nodes
- Reworded index property definition
- Added -us extensions to idle state nodes latency entries
- Changed PSCI entry-method compatible string
- Reworded and simplified hierarchical idle states definition
- Reworded min-residency definition

Changes in v4:

- Made entry-method global
- Renamed power_state parameter
- Augmented examples with retention states and node tags
- Reworded index property definition in the state node
- Changed the naming scheme for state nodes to default DT
- Defined idle_standby idle state (need not be listed)
- Clarified SBSA nomenclature and usage in the bindings

Changes in v3:

- Renamed C-states to "idle states" in patches and cover letter
- Added SBSA definitions
- Added power_state parameter to PSCI
- Removed OPP dependency
- Split latency into entry/exit latencies
- Reintroduced processor and cache retention boolean
- Made power_state generic parameter for all entry methods
- Redefined idle state hierarchy

Changes in v2:

- Updated cache bindings according to review
- Added power domain phandle to cache bindings
- Added power domains to C-states bindings
- Removed useless reg property from C-states bindings
- Removed cpu-map references from C-states bindings
- Added dependency on OPP in C-states parameters
- Added C-state state hierarchy

ARM based systems embed power management HW that allows SW to enter
low-power states according to run-time criteria based on parameters (eg
power state entry/exit latency) that define how an idle state has to be
managed and its respective properties. ARM partners implement HW power
management schemes through custom HW, with power controllers and relative
control mechanisms differing on both HW implementations and the way SW can
control them. This differentiation forces PM software in the kernel to cope
with states differences in power management drivers, which cause code
fragmentation and duplication of functionality.

Most of the power control scheme HW parameters are not probeable on ARM
platforms from a SW point of view, hence, in order to tackle the drivers
fragmentation problem, this patch series defines device tree bindings to
describe idle states parameters on ARM platforms.

Device tree bindings for idle states also require the introduction of device
tree bindings for processor caches, since idle states entry/exit require
SW cache maintainance; in some ARM systems, where firmware does not
support power down interfaces, cache maintainance must be carried out in the
OS power management layer, which then requires a description of the cache
topology through device tree nodes.

Idle states device tree standardization shares most of the concepts and
definitions with the ongoing ACPI ARM C-state bindings proposal so that
both standards can contain a coherent set of parameters, simplifying the
way SW will have to handle the respective device drivers.

Lorenzo Pieralisi (3):
  Documentation: devicetree: psci: define CPU suspend parameter
  Documentation: arm: add cache DT bindings
  Documentation: arm: define DT idle states bindings

 Documentation/devicetree/bindings/arm/cache.txt    | 166 +++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  18 +
 .../devicetree/bindings/arm/idle-states.txt        | 771 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/psci.txt     |  11 +
 4 files changed, 966 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt

-- 
1.8.4
