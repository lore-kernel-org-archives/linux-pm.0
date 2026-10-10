Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCE46A60A;
	Sat, 10 Oct 2026 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791631431; cv=none; b=XGWWivb+fsKNk9INsI+hNZiQjMGSMTc3dq69GM+pEFgKh8evtEjVCvfWAApLkiy9fWN3fZ0zI1qpj0W460+3lXSoxuPungYeI93SsTp2O8NBuzkL7WaVrQtOssToyKF4xdjNkcKIKrP3M+wBmrrune+Xyfyi4O2R+gbqi84+M/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791631431; c=relaxed/simple;
	bh=29EACdLxzYRratyDbeWoNXVIHRUiUVtnepkFCk69mzE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ERxiy6IzpwjXFnQgqGrA+agkNWDgxSlyJI1+oafeM2BXuAmslCkFzJPwlAk8vZwyISsbCRGRhKojvuvg4FU2WKRmtAya0FSK7ObDNsCUr/0HuTlHkTtnXR2WoOIqb3kHdWXxnGQYiR0piALEy6Ht+T5uQkUPJghYqH6sI6FCUSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ci6dayoF; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ci6dayoF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791631421; x=1791890621;
	bh=oo79LKWTx4aAtArHq4xXSoc7i/wEN7VwGdsWaQW6NV8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ci6dayoFUMY/k81NymBOBaqSuC3q9llTEfP0Sh1/TyVzD0VdE/QJnnlpzaz2j7e+K
	 hgk864ShChkLFGmLQkwf9CqHMIq8dNeNAfxxzn2Yqg7obJA9XI4DJtyXnxolUCIr5Y
	 THfL5HTQyLigYecEPQop6RPkv3+BvH9rhyEqukKlI5WThxcNZW+GiwnUQt1puerxRj
	 uCpXr0VBncgvXKPla3S9uLRjjNeSx33PWnp12Wdfoi++dtXXZ48oiXHosVNip8+qJc
	 jmLSSNcNYDj/WTbynCKKFvwTqMsNHayJiYQzWkeo+IC/jV1maXaJrVNDkgIshY/vfd
	 S6NbjfnkwwvIQ==
Date: Sat, 10 Oct 2026 11:23:36 +0000
To: Bjorn Andersson <andersson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] pinctrl: qcom: Restore the pin configuration after hibernation
Message-ID: <179163141354.18006.80461347454353634@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 9005c5cbff3375a4d0631500baca45f5b1b2f650
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
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

Save the control, output and interrupt configuration registers of every
valid pin in freeze_noirq and write them back in restore_noirq, the
output level first, so that a pin drives the right level from the
moment it becomes an output. Enabling the raw interrupt status can
latch an interrupt, so the status is cleared afterwards, as
msm_gpio_irq_set_type() does.

msm_pinctrl_dev_pm_ops gets the two callbacks and x1e80100 starts using
these ops. With that x1e80100 also gets their suspend and resume
callbacks, which apply the sleep and default state of the controller's
own pins where a board defines them.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
RFC because the two callbacks go into msm_pinctrl_dev_pm_ops, which the
sc7180, sc7280, sdm845 and sm7150 drivers use as well, and I can only
test x1e80100. If you would rather have this for x1e80100 alone, or
done another way, I am happy to redo it.

Tested on a Lenovo Yoga Slim 7x with Arch Linux ARM's v7.2 kernel plus
this patch. The kernel also carried the PCI change in [1], without
which this machine does not resume at all, the smp2p change in [2] and
a GENI serial change that is not ready for the list. The patch is
based on pinctrl/devel, where it builds without warnings (W=3D1,
CONFIG_HIBERNATION=3Dy).

- Without the patch, gpio116 and gpio117 come back as shown above
  after a hibernation with a real power-off. With it, in four such
  hibernations, the TLMM part of /sys/kernel/debug/gpio differs only
  in the level read on two inputs (gpio93 and gpio153).
- pm_test=3Dcore and test_resume pass.
- A suspend (deep) and wake still works. On x1e80100 it now goes
  through msm_pinctrl_suspend() and msm_pinctrl_resume().

Not covered here: the LPASS LPI pin controller, whose pins also came
back at their reset values after a hibernation.

[1] https://lore.kernel.org/r/179157746908.73485.2343672865542690797@pm.me
[2] https://lore.kernel.org/r/179158127177.70185.5691100900886332545@pm.me

 drivers/pinctrl/qcom/pinctrl-msm.c      | 106 +++++++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-x1e80100.c |   1 +
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinc=
trl-msm.c
index 27f06bbc1..fba8a4165 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -39,6 +39,14 @@
 #define MAX_NR_TILES 4
 #define PS_HOLD_OFFSET 0x820
=20
+/* Register values of one pin, kept across a hibernation. */
+struct msm_pin_state {
+=09u32 ctl;
+=09u32 io;
+=09u32 intr_cfg;
+=09u32 intr_target;
+};
+
 /**
  * struct msm_pinctrl - state for a pinctrl-msm device
  * @dev:            device handle.
@@ -58,6 +66,7 @@
  * @soc:            Reference to soc_data of platform specific data.
  * @regs:           Base addresses for the TLMM tiles.
  * @phys_base:      Physical base address
+ * @saved:          Pin registers kept while a hibernation image is taken.
  */
 struct msm_pinctrl {
 =09struct device *dev;
@@ -80,6 +89,8 @@ struct msm_pinctrl {
 =09const struct msm_pinctrl_soc_data *soc;
 =09void __iomem *regs[MAX_NR_TILES];
 =09u32 phys_base[MAX_NR_TILES];
+
+=09struct msm_pin_state *saved;
 };
=20
 #define MSM_ACCESSOR(name) \
@@ -1583,9 +1594,93 @@ static __maybe_unused int msm_pinctrl_resume(struct =
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
+/* Remember how the pins are set up when a hibernation image is taken. */
+static int msm_pinctrl_freeze_noirq(struct device *dev)
+{
+=09struct msm_pinctrl *pctrl =3D dev_get_drvdata(dev);
+=09const struct msm_pingroup *g;
+=09struct msm_pin_state *s;
+=09unsigned long flags;
+=09unsigned int i;
+
+=09raw_spin_lock_irqsave(&pctrl->lock, flags);
+=09for (i =3D 0; i < pctrl->chip.ngpio; i++) {
+=09=09if (!gpiochip_line_is_valid(&pctrl->chip, i))
+=09=09=09continue;
+
+=09=09g =3D &pctrl->soc->groups[i];
+=09=09s =3D &pctrl->saved[i];
+=09=09s->ctl =3D msm_readl_ctl(pctrl, g);
+=09=09s->io =3D msm_readl_io(pctrl, g);
+=09=09if (!g->intr_cfg_reg)
+=09=09=09continue;
+
+=09=09s->intr_cfg =3D msm_readl_intr_cfg(pctrl, g);
+=09=09if (msm_pin_has_own_intr_target(pctrl, g))
+=09=09=09s->intr_target =3D msm_readl_intr_target(pctrl, g);
+=09}
+=09raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+=09return 0;
+}
+
+/*
+ * The image is restored after a power cycle, when the pins are back at wh=
at
+ * the firmware and the kernel that loaded the image made of them. Nothing=
 else
+ * writes the configuration again, so put back what was there.
+ */
+static int msm_pinctrl_restore_noirq(struct device *dev)
+{
+=09struct msm_pinctrl *pctrl =3D dev_get_drvdata(dev);
+=09const struct msm_pingroup *g;
+=09struct msm_pin_state *s;
+=09unsigned long flags;
+=09unsigned int i;
+=09u32 val;
+
+=09raw_spin_lock_irqsave(&pctrl->lock, flags);
+=09for (i =3D 0; i < pctrl->chip.ngpio; i++) {
+=09=09if (!gpiochip_line_is_valid(&pctrl->chip, i))
+=09=09=09continue;
+
+=09=09g =3D &pctrl->soc->groups[i];
+=09=09s =3D &pctrl->saved[i];
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
=20
+=09=09if (msm_pin_has_own_intr_target(pctrl, g))
+=09=09=09msm_writel_intr_target(s->intr_target, pctrl, g);
+=09=09msm_writel_intr_cfg(s->intr_cfg, pctrl, g);
+
+=09=09/* Enabling the raw status can latch an interrupt. */
+=09=09if (s->intr_cfg & BIT(g->intr_raw_status_bit))
+=09=09=09msm_ack_intr_status(pctrl, g);
+=09}
+=09raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+=09return 0;
+}
+
+const struct dev_pm_ops msm_pinctrl_dev_pm_ops =3D {
+=09SYSTEM_SLEEP_PM_OPS(msm_pinctrl_suspend, msm_pinctrl_resume)
+=09.freeze_noirq =3D pm_sleep_ptr(msm_pinctrl_freeze_noirq),
+=09.restore_noirq =3D pm_sleep_ptr(msm_pinctrl_restore_noirq),
+};
 EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
=20
 int msm_pinctrl_probe(struct platform_device *pdev,
@@ -1663,6 +1758,13 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 =09if (ret)
 =09=09return ret;
=20
+=09if (IS_ENABLED(CONFIG_HIBERNATION)) {
+=09=09pctrl->saved =3D devm_kcalloc(&pdev->dev, pctrl->chip.ngpio,
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
index e4c0abcd9..bfe122fc7 100644
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
2.53.0


