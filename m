Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10A413799
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791632135; cv=none; b=kus5wNgbg8SKaelaHRuT114OBA1rigryoDERCQXCd2fZZNEgIQlSfxASOgI5z2FFfXbuCp9FK6if1TSg+lUjbIecnPWmEw5LtlNFlO3J75+EV8/1hO0+qrMbnTsDQ66esrbo3jjbSgXb/1NB0yt+jGHyvzNdTQJFDz+IVhluYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791632135; c=relaxed/simple;
	bh=/itNkXNH1JxfAtbgLYU43ReT1lu9d2Vv6u4JiAK4MLo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=J5XViTIiWjK6zzPSdFdoSjwmZkVDnsjWYuPu4cBr2KXZrzO9AfyRgIIqAPmdGKxeirnnzrU4cUhkLMnwYhmN6UM7Q2pnsavty9PTQcqwQjydZwx0l/mTIFTraeFJX8Qg7LkHYxFuQkcKrm1AVujQZhxguHMoTUXot7MNVyWR2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IQstWvGz; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IQstWvGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791632130; x=1791891330;
	bh=u/XyS0fFwdXSO/nAyUmGOgyVOEMZmfrG8b3gOmGgnns=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IQstWvGzGoGHE9qtWPZKn15AgkUBc9Y37IAtSf7cXw5Wjym8pRqR8Olw8iw7I7ZBo
	 BLXGUajVCl/Jej5bolpLBedu25L8K5ve/STNLIx6Zdl4HiPOWU34W9ux3nMupyAlVe
	 WwwRI0J7SfK0dQ4UE5ARATUqJ3tLdJQyNBVevj6X8Gy0DGQceSlRDbJPpYdjgkozGf
	 9hfUvAmQC1qaNLGs9hnlk9WTna/B46xWP9KtjmTU3cDx6ZOOZubjKwm0uZJIzCDE+6
	 9edbf9voQHuFWdqtDMCtrruPDLGApA3oNJzzg3mMj5C9eEQJ1jh5DS4Gqmvo9W8euN
	 dK79ioPKjC+ew==
Date: Sat, 10 Oct 2026 11:35:26 +0000
To: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Reset the in-band sleep state on power off
Message-ID: <179163212446.46972.2306254853726299632@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 884b30a7e7cc678a90e94af3bff0cc6b2f0676a5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

qca_power_off() cuts the power of the controller but leaves the host
side of the in-band sleep (IBS) protocol as it was. tx_ibs_state and
rx_ibs_state are initialised in qca_open() only, so a controller that
qca_setup() powers on again meets whatever state the last session ended
in.

If that state is HCI_IBS_TX_WAKING, the host is waiting for a wake
acknowledgment, and qca_hci_shutdown() has deleted the timer that
sends the wake indication again. The setup still works, because frames
bypass IBS while QCA_IBS_DISABLED is set. Once the flag is cleared,
qca_enqueue() puts every frame on tx_wait_q and nothing takes it off:

  Bluetooth: hci0: QCA setup on UART is completed
  Bluetooth: hci0: Opcode 0x0c03 failed: -110

A restore from hibernation gets there on a Lenovo Yoga Slim 7x
(WCN7850). The controller has been through a power cycle, while the
restored kernel holds the state from before the image was taken. Its
wake indications go unanswered, the commands behind them time out, and
the core closes the device and sets it up again. From then on
tx_ibs_state reads 1 in debugfs and Bluetooth stays dead until hci_uart
is reloaded.

When the controller loses power, put both sides back to asleep, which
is where qca_open() starts, and stop the two IBS timers.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
Tested on a Lenovo Yoga Slim 7x with Arch Linux ARM's v7.2 kernel and
hci_uart rebuilt with this change. qca_open(), qca_enqueue() and
qca_hci_shutdown() are the same there as in bluetooth-next, which this
is based on and where it builds without warnings (W=3D1).

Each run is a fresh boot, a hibernation with a real power-off and a
resume, with Bluetooth powered before it:

- Without the patch Bluetooth is dead afterwards in four runs out of
  four, with the log above. In the one run where I read it, debugfs
  showed tx_ibs_state=3D1, ibs_sent_wakes=3D109 and ibs_recv_wake_acks=3D8.
- With the patch it is powered again by itself in two runs out of two,
  about 20 seconds after the resume. The log shows a failed version
  read and "Retry BT power ON:0" before a setup that works. In the run
  where I read it, debugfs showed tx_ibs_state=3D0 afterwards.
- Powering the controller off and on with bluetoothctl still works.

The 20 seconds are the commands that time out before the core gives up
on the old session. This patch does not change that part.

The kernel also carried the hibernation changes in [1], [2] and [3],
without which this machine does not get this far, and a GENI serial
change that is not ready for the list.

[1] https://lore.kernel.org/r/179157746908.73485.2343672865542690797@pm.me
[2] https://lore.kernel.org/r/179158127177.70185.5691100900886332545@pm.me
[3] https://lore.kernel.org/r/179163141354.18006.80461347454353634@pm.me

 drivers/bluetooth/hci_qca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b63..19a75faba 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2235,6 +2235,11 @@ static void qca_power_off(struct hci_uart *hu)
 =09spin_lock_irqsave(&qca->hci_ibs_lock, flags);
 =09set_bit(QCA_IBS_DISABLED, &qca->flags);
 =09qca_flush(hu);
+=09/* A controller that loses power is asleep when it comes back. */
+=09timer_delete(&qca->wake_retrans_timer);
+=09timer_delete(&qca->tx_idle_timer);
+=09qca->tx_ibs_state =3D HCI_IBS_TX_ASLEEP;
+=09qca->rx_ibs_state =3D HCI_IBS_RX_ASLEEP;
 =09spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
=20
 =09/* Non-serdev device usually is powered by external power
--=20
2.56.0


