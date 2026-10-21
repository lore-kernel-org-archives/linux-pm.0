Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612381;
	b=I0fDX+AbgTxAhI+/4giDMqVhB4Md42BUuGTHIRuMVFEnUjyrnOGmcIZn85vhwtE9nkqx
	 4LJ+P2xhkMW0av//lEcEq9XDeakRKA40y4HvZDcHcD/0BJtvcJn+ByRLkGokB8mVMiFG9
	 q1lrKSCsrvLtN2JELb2dZsvL3lRLxTEL3tub+YddSc+57fYnB1CcOLog1GQl941gxEBx+
	 Je7WMtmExfN+nL63nsg2w51pW96jwqIJY0HQxU70WSTJLHjFd01o/BtEAHywWfjUmy49C
	 cfim9IJracQ5b7QB5CIyzl4NMyB6Z7FVLhxcfwNSImxo9CwFpz6okvysJH/GCqiQRKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612381;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A7QHzyi7hILFsKIZgIskLbaHp/ycC6vPy0kZ2J0GHTc=;
	b=bA1ABdNOPrfJXoMsdl2veIpduhjMudRWKYHxgJBI6p5iBP3EKnRFRrxco6DeQkmlKR+e
	 a5p7rjEDGlabbuuMFkWqj9d0vzksXmNCW3Ncu35uQJ0j5cK1W+tomLgDZzW/YWZLMMiK2
	 cAxxeaVBuydQtv//KUPqfWday9nkvgxMjKKjmEk537IwIuxLHM0CfIIZ3HyQeIdQ2hBHm
	 eiTb44QLd/QKKFWsIIWTmqqX2eBk17Pf1ODu0pkdyyptO301R7hI4O0poAdSVZW5+RUYL
	 me1s8HBh7SbQsJXcM/guCQaEUUfu4aY5gAthVn6TzyCq00Nlm1H+sbIG+y5hm+xHZWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Xswu2Ydn;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC4606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 19:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8BC4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Xswu2Ydn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792612378; x=1792871578;
	bh=A7QHzyi7hILFsKIZgIskLbaHp/ycC6vPy0kZ2J0GHTc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xswu2YdneDkUW3sZ13DqHmzhPhN1bIb150LsFXEqoAgpPonbhTwzttFzmRMyqjhRQ
	 zqhcdrmiz8QKpzSCjtGNtseoHsXOfmHt+q1me05ojSyF4pl7Z3bJ6u1Ku4p2O41kQf
	 OtHSdLhwApb+KTi5ehH1W0L7Ygz3mU3iU9r1L9XN3C/0LvMsappxlqqgijezw6BMxu
	 gV+9kCgqv1VXPZrnOd4bXht439dn3rsSdR8hOt8ak38Y8n4IAcIMR4xgf8OkdOm7kN
	 zebEa/mZYhmUGRf3EicTS7IYarr+tx/rYw1xCbwZBZ8wsN/Xkvk21d5gjNHC7aUNnG
	 vTHOyxFWdgi2w==
Date: Wed, 21 Oct 2026 19:52:53 +0000
To: Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pinctrl: qcom: Restore the pin configuration after hibernation
Message-ID: <20261021195250.83540-1-birk.skyum@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: f392f4a5580105f9f2dd70105c80d2a9ee48be0f
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A hibernation image is restored after a power cycle. The TLMM registers
then hold what the boot firmware and the kernel that loaded the image
made of them. The restored kernel has the configuration it applied in
memory only, and nothing writes it to the hardware again, so every pin
that the loading kernel did not set up the same way stays wrong.

On a Lenovo Yoga Slim 7x (X1E80100) the Bluetooth and Wi-Fi enable lines
are two of them. Their drivers are loaded from the root file system, so
the kernel that loads the image never touches the pins. This is
/sys/kernel/debug/gpio before the hibernation and after the resume:

  gpio116 : out low  func0 2mA no pull
  gpio117 : out high func0 2mA no pull

  gpio116 : in  low  func0 2mA pull down
  gpio117 : out high func0 16mA no pull

The driver that owns gpio116 still believes it drives the line.

Save the control, output and interrupt configuration registers in
freeze_noirq and write them back in restore_noirq, the output level
first, so that a pin drives the right level from the moment it becomes
an output. Changing the interrupt configuration can latch an interrupt,
so the status is cleared where the register changed, as
msm_gpio_irq_set_type() does.

Only the GPIOs the kernel uses are put back: those requested as a GPIO,
muxed to a function or used as an interrupt, as pinctrl-intel does. A
valid GPIO without an owner may be in use by firmware. The SDC pads
after the GPIOs are configured without a mux function, so they never
have an owner, and their control register is always put back.

msm_pinctrl_dev_pm_ops gets the two callbacks and x1e80100 starts using
these ops. With that x1e80100 also gets their suspend and resume
callbacks, which apply the sleep and default state of the controller's
own pins where a board defines them.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
Changes in v3:
- Take the lock with guard() in both callbacks (Bartosz).
- Link to v2: https://lore.kernel.org/r/179206391202.36987.1416057976823693=
032@pm.me

Changes in v2:
- Put a GPIO back only when the kernel uses it, as a GPIO, through a
  mux function or as an interrupt, as pinctrl-intel does (Bartosz).
- Save and restore the SDC pads after the GPIOs as well (Bartosz).
- Allocate the save area under the same option as the callbacks,
  CONFIG_HIBERNATE_CALLBACKS (Sashiko).
- Clear the interrupt status only where the restore changed the
  interrupt configuration (Sashiko).
- Say in a comment that a both-edge interrupt emulated by flipping the
  polarity is not primed again. No SoC with such pins uses these ops.
- Rebased on pinctrl-qcom/for-next.
- Link to the RFC: https://lore.kernel.org/r/179163141354.18006.80461347454=
353634@pm.me

Tested with v2 on a Lenovo Yoga Slim 7x with v7.2 plus the patch. v3
was not run on hardware again, because both callbacks compile to the
same arm64 code as in v2. The kernel also carried the PCI change in
[1], without which this machine does not resume at all, the smp2p
change in [2] and a GENI serial change that is not posted. The
Bluetooth driver had [3] applied. On pinctrl-qcom/for-next v3 builds
without warnings with W=3D1 and sparse, with hibernation on, off and
without sleep support.

- Before the hibernation 45 TLMM pins have an owner, gpio116 and
  gpio117 among them (wcn7850-pmu), and four are interrupts.
- pm_test=3Dcore and test_resume pass.
- After a hibernation with a real power-off the TLMM part of
  /sys/kernel/debug/gpio differs only in the level read on two inputs
  (gpio93 and gpio153), as it did with the RFC.
- A suspend (deep) and wake still works.

The Yoga has no SD card slot and its SDC2 pads have no owner, so this
only shows that putting them back does no harm. I did not read them
back.

Not covered here: the LPASS LPI pin controller, whose pins also come
back at their reset values after a hibernation.

[1] https://lore.kernel.org/r/179181074907.22199.10556821368232442334@pm.me
[2] https://lore.kernel.org/r/179158127177.70185.5691100900886332545@pm.me
[3] https://lore.kernel.org/r/179163212446.46972.2306254853726299632@pm.me

 drivers/pinctrl/qcom/pinctrl-msm.c      | 145 +++++++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-x1e80100.c |   1 +
 2 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinc=
trl-msm.c
index 27f06bbc113c..8ddb4261bf89 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -39,6 +39,15 @@
 #define MAX_NR_TILES 4
 #define PS_HOLD_OFFSET 0x820
=20
+/* Register values of one pin group, kept across a hibernation. */
+struct msm_pin_state {
+=09u32 ctl;
+=09u32 io;
+=09u32 intr_cfg;
+=09u32 intr_target;
+=09bool saved;
+};
+
 /**
  * struct msm_pinctrl - state for a pinctrl-msm device
  * @dev:            device handle.
@@ -58,6 +67,7 @@
  * @soc:            Reference to soc_data of platform specific data.
  * @regs:           Base addresses for the TLMM tiles.
  * @phys_base:      Physical base address
+ * @saved:          Pin registers kept while a hibernation image is taken.
  */
 struct msm_pinctrl {
 =09struct device *dev;
@@ -80,6 +90,8 @@ struct msm_pinctrl {
 =09const struct msm_pinctrl_soc_data *soc;
 =09void __iomem *regs[MAX_NR_TILES];
 =09u32 phys_base[MAX_NR_TILES];
+
+=09struct msm_pin_state *saved;
 };
=20
 #define MSM_ACCESSOR(name) \
@@ -1583,9 +1595,131 @@ static __maybe_unused int msm_pinctrl_resume(struct=
 device *dev)
 =09return pinctrl_force_default(pctrl->pctrl);
 }
=20
-SIMPLE_DEV_PM_OPS(msm_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
-=09=09  msm_pinctrl_resume);
+static bool msm_pin_has_own_intr_target(struct msm_pinctrl *pctrl,
+=09=09=09=09=09const struct msm_pingroup *g)
+{
+=09return !pctrl->intr_target_use_scm && g->intr_target_reg &&
+=09       g->intr_target_reg !=3D g->intr_cfg_reg;
+}
+
+/*
+ * A GPIO is only put back when the kernel uses it, as a GPIO, through a m=
ux
+ * function or as an interrupt. Other valid pins may be in use by firmware=
.
+ * The pads after the GPIOs (SDC) have no GPIO and are configured without =
a
+ * mux function, so they never have an owner and are always put back.
+ */
+static bool msm_pin_in_use(struct msm_pinctrl *pctrl, unsigned int i)
+{
+=09const struct pin_desc *desc;
+
+=09if (i >=3D pctrl->chip.ngpio)
+=09=09return true;
+
+=09if (!gpiochip_line_is_valid(&pctrl->chip, i))
+=09=09return false;
+
+=09desc =3D pin_desc_get(pctrl->pctrl, i);
+
+=09return desc && (desc->mux_owner || desc->gpio_owner ||
+=09=09=09gpiochip_line_is_irq(&pctrl->chip, i));
+}
+
+/* Remember how the pins are set up when a hibernation image is taken. */
+static int msm_pinctrl_freeze_noirq(struct device *dev)
+{
+=09struct msm_pinctrl *pctrl =3D dev_get_drvdata(dev);
+=09const struct msm_pingroup *g;
+=09struct msm_pin_state *s;
+=09unsigned int i;
+
+=09guard(raw_spinlock_irqsave)(&pctrl->lock);
+
+=09for (i =3D 0; i < pctrl->soc->ngroups; i++) {
+=09=09g =3D &pctrl->soc->groups[i];
+=09=09s =3D &pctrl->saved[i];
+=09=09s->saved =3D msm_pin_in_use(pctrl, i);
+=09=09if (!s->saved)
+=09=09=09continue;
+
+=09=09s->ctl =3D msm_readl_ctl(pctrl, g);
+=09=09if (i >=3D pctrl->chip.ngpio)
+=09=09=09continue;
+
+=09=09s->io =3D msm_readl_io(pctrl, g);
+=09=09if (!g->intr_cfg_reg)
+=09=09=09continue;
+
+=09=09s->intr_cfg =3D msm_readl_intr_cfg(pctrl, g);
+=09=09if (msm_pin_has_own_intr_target(pctrl, g))
+=09=09=09s->intr_target =3D msm_readl_intr_target(pctrl, g);
+=09}
=20
+=09return 0;
+}
+
+/*
+ * The image is restored after a power cycle, when the pins are back at wh=
at
+ * the firmware and the kernel that loaded the image made of them. Nothing=
 else
+ * writes the configuration again, so put back what was there.
+ *
+ * A both-edge interrupt that is emulated by flipping the polarity gets th=
e
+ * polarity it had, which is not primed for a line that changed meanwhile.=
 No
+ * SoC with such pins (one-bit detection) uses these callbacks.
+ */
+static int msm_pinctrl_restore_noirq(struct device *dev)
+{
+=09struct msm_pinctrl *pctrl =3D dev_get_drvdata(dev);
+=09const struct msm_pingroup *g;
+=09struct msm_pin_state *s;
+=09unsigned int i;
+=09u32 val;
+
+=09guard(raw_spinlock_irqsave)(&pctrl->lock);
+
+=09for (i =3D 0; i < pctrl->soc->ngroups; i++) {
+=09=09g =3D &pctrl->soc->groups[i];
+=09=09s =3D &pctrl->saved[i];
+=09=09if (!s->saved)
+=09=09=09continue;
+
+=09=09if (i >=3D pctrl->chip.ngpio) {
+=09=09=09msm_writel_ctl(s->ctl, pctrl, g);
+=09=09=09continue;
+=09=09}
+
+=09=09/* Set the level before the pin starts driving it. */
+=09=09val =3D msm_readl_io(pctrl, g);
+=09=09val &=3D ~BIT(g->out_bit);
+=09=09val |=3D s->io & BIT(g->out_bit);
+=09=09msm_writel_io(val, pctrl, g);
+
+=09=09msm_writel_ctl(s->ctl, pctrl, g);
+=09=09if (!g->intr_cfg_reg)
+=09=09=09continue;
+
+=09=09if (msm_pin_has_own_intr_target(pctrl, g))
+=09=09=09msm_writel_intr_target(s->intr_target, pctrl, g);
+=09=09val =3D msm_readl_intr_cfg(pctrl, g);
+=09=09msm_writel_intr_cfg(s->intr_cfg, pctrl, g);
+
+=09=09/*
+=09=09 * Changing the configuration can latch an interrupt. One that
+=09=09 * is latched with the configuration unchanged is a real one.
+=09=09 */
+=09=09if (val !=3D s->intr_cfg)
+=09=09=09msm_ack_intr_status(pctrl, g);
+=09}
+
+=09return 0;
+}
+
+const struct dev_pm_ops msm_pinctrl_dev_pm_ops =3D {
+=09SYSTEM_SLEEP_PM_OPS(msm_pinctrl_suspend, msm_pinctrl_resume)
+=09.freeze_noirq =3D PTR_IF(IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS),
+=09=09=09       msm_pinctrl_freeze_noirq),
+=09.restore_noirq =3D PTR_IF(IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS),
+=09=09=09=09msm_pinctrl_restore_noirq),
+};
 EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
=20
 int msm_pinctrl_probe(struct platform_device *pdev,
@@ -1663,6 +1797,13 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 =09if (ret)
 =09=09return ret;
=20
+=09if (IS_ENABLED(CONFIG_HIBERNATE_CALLBACKS)) {
+=09=09pctrl->saved =3D devm_kcalloc(&pdev->dev, pctrl->soc->ngroups,
+=09=09=09=09=09    sizeof(*pctrl->saved), GFP_KERNEL);
+=09=09if (!pctrl->saved)
+=09=09=09return -ENOMEM;
+=09}
+
 =09platform_set_drvdata(pdev, pctrl);
=20
 =09dev_dbg(&pdev->dev, "Probed Qualcomm pinctrl driver\n");
diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom=
/pinctrl-x1e80100.c
index e4c0abcd95b9..bfe122fc7e79 100644
--- a/drivers/pinctrl/qcom/pinctrl-x1e80100.c
+++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
@@ -1855,6 +1855,7 @@ static struct platform_driver x1e80100_pinctrl_driver=
 =3D {
 =09.driver =3D {
 =09=09.name =3D "x1e80100-tlmm",
 =09=09.of_match_table =3D x1e80100_pinctrl_of_match,
+=09=09.pm =3D &msm_pinctrl_dev_pm_ops,
 =09},
 =09.probe =3D x1e80100_pinctrl_probe,
 };
--=20
2.55.0


