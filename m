Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133105;
	b=uD2llUiSQ0mesZHTDVcvp9ihY8O+cf8oPR9X6IELpLMl0JBMi1CofRy7Wf/dajZEjD6p
	 r05BGffkgoTQ5VWuzQwWi1SMboaXaK11r0EYMb/XJmCyvPZ0eiY7BlhVldb7G55aKAjR8
	 XSVv6SqpllPQre9gVyfgYiHFMgt0fSiDLw4TyRSmvDdY1WAdmoTt/b62AOtatoLy01VPB
	 wdLIraP47wg5oOkM5sSs56u1dLNnxJ6fOxBPAwwKRDOayYkyeTwbNSspLCI8yST0uwECN
	 fyk+axPGVOnlTpRZyWISRkaFvAP4hVVe2058kGggxxyaQ9mrQ8AAvGr1XxjL2M6umqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133105;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ItOY3Vg5BOHo/uC07nNATgEJDvbeahAuY9/6a3jg9K0=;
	b=g5VdgrYQl943adeWT3vCICYgQHUcWyscmlqtXgR3KxmMxxNh+5eGSlujdhR63B2hGeCr
	 ECAlRwJ7ge2U/pTzEhezM9BpuHJ+FVZpz3044RMzEC623mVLFPxr/K8nAeVJeCUPofQje
	 LKQIaTHd7K75Zqk+S7J0Puu6CX+yJWL1GS/N4iqOIMYhVIi6VqMWHSLkno4rqQZsXBFmV
	 iLW6718w1ax1Mqd7aifVOhOivSSFI7vfzQQbjY36exHsktQ9Scf7lDIg0F3UqHcZWOaUb
	 EaXD3k5rs+yQ21G5cvm8nP0IwVqg4N3M5zbKFP2iWujkN+WO732GHIyjcobOPJoD/xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=TNP6XfRW;
	arc=none smtp.remote-ip=109.224.244.121
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84D606A31F;
	Tue, 27 Oct 2026 20:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF84D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=TNP6XfRW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793133102; x=1793392302;
	bh=ItOY3Vg5BOHo/uC07nNATgEJDvbeahAuY9/6a3jg9K0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TNP6XfRW0r6Gi8+sA3NB85f8TvH3QXPO5o1Mv7fMSt+egBjOcM9z08uapPa+XPspm
	 d+GWCir7eKtVZp2n7PQNehpQafWQxYCtp+qEKooSMo1pN4KMmCk67KnfgolvceSit2
	 5oCdNk/1EQQnx0aXTbVmyODKAOd53WN9ACOcfmZKiWt/lX5sadx4RPIDsw4/oCpX/b
	 hytZQm6y2CG/WlFQ6IiaycRIZRUT7uub04RMBPbZjc7JBCF3oerDzm9c3hYAqQdArC
	 ZELVJI9sUGtm+AeLHodL1UkoqONE/9/DtbwH5YjLNTYGE1ysDwv6X9SyVmL7C9yYRx
	 H6QvjUAesgakQ==
Date: Tue, 27 Oct 2026 20:31:38 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: qcom-geni: Set the serial engine up again after hibernation
Message-ID: <20261027203136.95971-1-birk.skyum@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 514362eb52f479d693c59884f7ec81f7766e91c6
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

A hibernation image is restored after a power cycle, which resets every
serial engine. The kernel that loads the image only sets up the engines
it uses itself, and on laptops the Bluetooth UART is opened from the
root file system, so that kernel never touches it.

The restored kernel still has port->setup set from before, so the
startup in uart_resume_port() skips qcom_geni_serial_port_setup() and
the port runs on an engine whose FIFOs, packing and transfer mode were
never configured. On a Lenovo Yoga Slim 7x (X1E80100) the WCN7850's
Bluetooth controller then never comes back: every setup attempt of
hci_qca's error recovery ends in "command 0xfc00 tx timeout" and
"Reading QCA version information failed (-110)".

Clear port->setup in a restore callback of its own, so the next startup
sets the engine up again. The other system sleep callbacks are
unchanged.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
Tested on a Lenovo Yoga Slim 7x (X1E80100) with 7.3 and the other
hibernation fixes for this laptop, which are in review:

  pinctrl: qcom: Restore the pin configuration after hibernation (v4)
  https://lore.kernel.org/all/20261021210425.57066-1-birk.skyum@pm.me/
  PCI: qcom: Power the controller down when hibernating (v2), on top of
  the v6 series "PCI: qcom: Implement shutdown() to avoid SMMU/NoC
  errors on reboot"
  https://lore.kernel.org/all/179181074907.22199.10556821368232442334@pm.me=
/
  soc: qcom: smp2p: Start over after a restore from hibernation
  https://lore.kernel.org/all/179158127177.70185.5691100900886332545@pm.me/
  Bluetooth: hci_qca: Reset the in-band sleep state on power off (v2)
  https://lore.kernel.org/all/20261014180201.57109-1-birk.skyum@pm.me/

The test kernel had a switch for this change, so both ways ran on the
same build, each a real hibernation with a power-off from a fresh boot:

  without   restored after 112 s, Bluetooth never comes back
  with      restored after 89 s, hci_qca's recovery sets the controller
            up about 18 s after the restore and a scan finds devices

pm_test=3Dcore and test_resume pass with it as well; there the port is
restored without a power cycle and is simply set up a second time.

7.3 does not have the console pm_runtime_resume() that tty-next adds to
the resume callback. The port here is not a console and this laptop has
no serial console, so console ports were not exercised. For those, the
kernel that loads the image sets the engine up itself when it
registers the console, so clearing port->setup only repeats that at the
next startup.

Built with W=3D1 and sparse on tty-next with hibernation on, with
hibernation off, and without system sleep.

 drivers/tty/serial/qcom_geni_serial.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qco=
m_geni_serial.c
index bfdc155c1..4e5b0e247 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -2131,6 +2131,20 @@ static int qcom_geni_serial_resume(struct device *de=
v)
 =09return ret;
 }
=20
+/*
+ * A hibernation image is restored after a power cycle, which reset the se=
rial
+ * engine. The kernel that loaded the image only set up the engines it use=
d
+ * itself, so set this one up again when the port starts.
+ */
+static int qcom_geni_serial_restore(struct device *dev)
+{
+=09struct qcom_geni_serial_port *port =3D dev_get_drvdata(dev);
+
+=09port->setup =3D false;
+
+=09return qcom_geni_serial_resume(dev);
+}
+
 #if IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE)
 static const struct qcom_geni_device_data qcom_geni_console_data =3D {
 =09.console =3D true,
@@ -2168,7 +2182,12 @@ static const struct qcom_geni_device_data sa8255p_qc=
om_geni_uart_data =3D {
 static const struct dev_pm_ops qcom_geni_serial_pm_ops =3D {
 =09SET_RUNTIME_PM_OPS(qcom_geni_serial_runtime_suspend,
 =09=09=09   qcom_geni_serial_runtime_resume, NULL)
-=09SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_suspend, qcom_geni_serial_resume)
+=09.suspend =3D pm_sleep_ptr(qcom_geni_serial_suspend),
+=09.resume =3D pm_sleep_ptr(qcom_geni_serial_resume),
+=09.freeze =3D pm_sleep_ptr(qcom_geni_serial_suspend),
+=09.thaw =3D pm_sleep_ptr(qcom_geni_serial_resume),
+=09.poweroff =3D pm_sleep_ptr(qcom_geni_serial_suspend),
+=09.restore =3D pm_sleep_ptr(qcom_geni_serial_restore),
 };
=20
 static void qcom_geni_serial_sys_shutdown(struct platform_device *pdev)
--=20
2.56.0


