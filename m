Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF73CB55C;
	Fri,  9 Oct 2026 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581288; cv=none; b=qeqM5ixkLspGPmfyQPORpek8PgCle9mkpqp/CS+90oqVXQfduvH327vxChzu/+s3qc194rTfmzHuI4zf181Xct6iNerb580bxCel+sIkkU7Qui8i0VQIrVSiZ64iLowOvGLJIG4312Qnkk4kMAyFxVrWYVUBnn0wu/olhknwrz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581288; c=relaxed/simple;
	bh=TACQqvV+ua0Ane64B0qJzthFbEE3k5JIyMZs9Zy+/eA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D03QR2BnW1JFu4ZbcykWI3jyzbf9gjo2tP0PX128U6Xfch3ae7qGC/Dl6cCYm1JMa2lIBcTFO86oLg9hz/X2suix/63/OvnmxSL6utJ4cF7sbrj+/4mdmd0SYW5Jop5AqCGXkL1hOrid3pE1f0We575QOXgO7RopakrURqpGrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=UoCNIA21; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UoCNIA21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791581278; x=1791840478;
	bh=QXf4hTjVvhY++R7+vZFN3cZjPxa0QWrUt5Tsecb70U8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UoCNIA217633Q8zxxTQNQThjgyxxAtGSn29CAP+rTJf6hoWjQW/mHznQ8EANqGhhu
	 dFTOkeVfQjB1o0PeXvc9y5wJkbHlDMd6BjGp/hMBJMBjHBHYSpqu2zcHtR3IPHdmGQ
	 0HyiYrFTmdrIv6+4WK9uA1CPOjK+AUSueY87g3qF7L1QKVY/rdNDJQRutSa8hW3QWr
	 FcBlBpVBPKC7c3NSh1NZ4/739hZq5VvsDEaYCgOK/7iZVGfi4RGJGeLAsjqoYuXTmW
	 C9NTozV5Av/cexVnDIdKc7q3NlPJ4kBaA+8FWSZS5sOuv277HAqfI2ahaRmwiEYvIP
	 JnMrZxMFAArPQ==
Date: Fri, 09 Oct 2026 21:27:54 +0000
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: smp2p: Start over after a restore from hibernation
Message-ID: <179158127177.70185.5691100900886332545@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 356a7d20711be57c357883af5010b18ee31e6f11
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

smp2p remembers what it has negotiated with the remote processor: where
the remote's item is, which of its entries are matched, that version
and features are agreed, and whether the remote's last restart has been
acknowledged.

None of that holds when a hibernation image is restored. The machine
has been through a power cycle, shared memory has been set up again,
the kernel that loaded the image has created a fresh item for us, and
the remote starts from nothing.

On a Lenovo Yoga Slim 7x (X1E80100) a remote processor that is started
after a resume from hibernation never comes up:

  remoteproc remoteproc0: Booting fw image qcom/x1e80100/LENOVO/83ED/qcadsp=
8380.mbn, size 21592504
  qcom_q6v5_pas 6800000.remoteproc: start timed out
  remoteproc remoteproc0: can't start rproc adsp: -110

For the ADSP the driver still has ssr_ack set while the fresh item has
RESTART_ACK clear. When the remote sets RESTART_DONE,
qcom_smp2p_check_ssr() sees no restart, and the acknowledgement the
remote waits for is never written. For the CDSP the driver believes the
negotiation is done, so the fresh item is left at version 2 while the
remote uses version 1.

Forget all of it in restore_noirq and build our item again, the way
probe does. If the remote is still running, as after test_resume,
qcom_smp2p_start_in() finds its item again and the next interrupt
redoes the negotiation.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
Tested on a Lenovo Yoga Slim 7x with Arch Linux ARM's v7.2 kernel, where
this file differs from qcom/for-next only in the __iomem annotations and
two small cleanups.

- After a hibernation with a real power-off both the ADSP and the CDSP
  start again, in under half a second each, and the battery manager
  answers. Without the patch both starts time out.
- test_resume with both remote processors running passes, and they keep
  running.

Two things to know about the test:

- Resuming at all on this machine needs the PCI change in [1], and I
  closed the Bluetooth UART and unloaded ath12k for the hibernation.
- I stopped the remote processors before the hibernation and started
  them after it by hand. remoteproc does not do that itself, so a
  remote that was running when the image was taken is still shown as
  running after the resume and cannot be stopped ("failed to shutdown:
  -22"). That is a separate problem and still open.

[1] https://lore.kernel.org/r/179157746908.73485.2343672865542690797@pm.me

 drivers/soc/qcom/smp2p.c | 53 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 01b8580c9..64fc1ce3c 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -510,9 +510,8 @@ static const struct qcom_smem_state_ops smp2p_state_ops=
 =3D {
 =09.update_bits =3D smp2p_update_bits,
 };
=20
-static int qcom_smp2p_outbound_entry(struct qcom_smp2p *smp2p,
-=09=09=09=09     struct smp2p_entry *entry,
-=09=09=09=09     struct device_node *node)
+static void qcom_smp2p_claim_outbound_entry(struct qcom_smp2p *smp2p,
+=09=09=09=09=09    struct smp2p_entry *entry)
 {
 =09struct smp2p_smem_item *out =3D smp2p->out;
 =09char buf[SMP2P_MAX_ENTRY_NAME] =3D {};
@@ -525,6 +524,13 @@ static int qcom_smp2p_outbound_entry(struct qcom_smp2p=
 *smp2p,
 =09entry->value =3D (u32 __iomem *)&out->entries[out->valid_entries].value=
;
=20
 =09out->valid_entries++;
+}
+
+static int qcom_smp2p_outbound_entry(struct qcom_smp2p *smp2p,
+=09=09=09=09     struct smp2p_entry *entry,
+=09=09=09=09     struct device_node *node)
+{
+=09qcom_smp2p_claim_outbound_entry(smp2p, entry);
=20
 =09entry->state =3D qcom_smem_state_register(node, &smp2p_state_ops, entry=
);
 =09if (IS_ERR(entry->state)) {
@@ -774,6 +780,46 @@ static void qcom_smp2p_remove(struct platform_device *=
pdev)
 =09smp2p->out->valid_entries =3D 0;
 }
=20
+/*
+ * A hibernation image is restored after a power cycle. Shared memory has =
been
+ * set up anew since and the remote starts from nothing, so forget what wa=
s
+ * negotiated with it and build our item again.
+ */
+static int qcom_smp2p_restore_noirq(struct device *dev)
+{
+=09struct qcom_smp2p *smp2p =3D dev_get_drvdata(dev);
+=09struct smp2p_entry *entry;
+=09int ret;
+
+=09smp2p->in =3D NULL;
+=09smp2p->valid_entries =3D 0;
+=09smp2p->negotiation_done =3D false;
+=09smp2p->ssr_ack_enabled =3D false;
+=09smp2p->ssr_ack =3D false;
+
+=09list_for_each_entry(entry, &smp2p->inbound, node) {
+=09=09entry->value =3D NULL;
+=09=09entry->last_value =3D 0;
+=09}
+
+=09ret =3D qcom_smp2p_alloc_outbound_item(smp2p);
+=09if (ret < 0)
+=09=09return ret;
+
+=09/* Entries were added at the head of the list, so walk it backwards. */
+=09list_for_each_entry_reverse(entry, &smp2p->outbound, node)
+=09=09qcom_smp2p_claim_outbound_entry(smp2p, entry);
+
+=09qcom_smp2p_start_in(smp2p);
+=09qcom_smp2p_kick(smp2p);
+
+=09return 0;
+}
+
+static const struct dev_pm_ops qcom_smp2p_pm_ops =3D {
+=09.restore_noirq =3D pm_sleep_ptr(qcom_smp2p_restore_noirq),
+};
+
 static const struct of_device_id qcom_smp2p_of_match[] =3D {
 =09{ .compatible =3D "qcom,smp2p" },
 =09{}
@@ -786,6 +832,7 @@ static struct platform_driver qcom_smp2p_driver =3D {
 =09.driver  =3D {
 =09=09.name  =3D "qcom_smp2p",
 =09=09.of_match_table =3D qcom_smp2p_of_match,
+=09=09.pm =3D &qcom_smp2p_pm_ops,
 =09},
 };
 module_platform_driver(qcom_smp2p_driver);

base-commit: 705529dab1fa872d8b53b09c95e1b03a95573376
--=20
2.53.0


