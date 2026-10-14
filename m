Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55055D86D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994848; cv=none; b=aWsytyjA3Wuc1uONKFgFzuGQCz79gSrtJ4X1+PhV2KsTeARiPHPLycgfGaKlLYJI5JsmIRXy08pYLbHA44i6bA2SWj1mjx3LTSq0og04lovkP+dIoBwLhtf4cSjgDbanL5dM6ztEOA32GgmGEAfxwTsoUMyYkp0nitjvzYWW+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994848; c=relaxed/simple;
	bh=KOpW9NL741Wqf6CDHthraNjLF873jIDlBdmDkXr6AkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+y7sgMO70TFGVWy9lrXQuIB8g9NxEsbGkxgjWGHtkadJT8wFUx/Mr7PKyxIVUijXJMOTnq0WtFms4altk0UpPn9XBm5lxw403/s/RwHuJjpanpAGdRGW5Si+EFGzuNkmsycV5lOKfKiFoKHdx8SIV0btR7fnm4XLDVz6KHSslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRDDZ5dL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRDDZ5dL"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c45111bebso2690126f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791994844; x=1792599644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjI1AUhEkeYaz5+gj/BBEQM/J50SQrXWS0m/4fb/0T0=;
        b=KRDDZ5dLvmQxVaWSv1xKVRejl6KzvnurMd7QKx5jrQMfTm1sHb+NW2H/JooVv7dMCk
         Pb2c9vwVkMr/qnYP9JaLq5XF1Tb27ltBNF20hbCk3qYvitN4ylM70f1TEqd0EWag1V9M
         FGUfSWa+kkvneTXncAGQfqaSVHhFDsrMQz3yeYC2ZTdMUfCi96lYMgjB0iXYA89xuwq3
         Gr3jh14dnflPLRoqu6oIRlPH+tHu/VWGTCgm+pKmAbYXMlo7KxMxwDuxu126gu9qnU4l
         +5uO41RXaYbb7UQrHaaNvyKPXvAZG8hTPxVPvz/tvP+7TqHdmywvyph0dfVTqbSjt6uy
         cMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791994844; x=1792599644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjI1AUhEkeYaz5+gj/BBEQM/J50SQrXWS0m/4fb/0T0=;
        b=jc18T42KCOEkP6T3xlf9rKpPyGWTOB+d1r/x2j/4n9nQJ2VfaPNmSl1Iuxgjvx9NqG
         dMNIEq2pZOfYVxl+lGCz4Zd43A7lMylAlBe5cwiI/mr2zT4Gd+k6Vi38m3RpKbNr1SH4
         upvwboIiTq2jsGi9LPSEgtoM46+HC5O2NLN18p6rcPzjwt6sjGaulUIAKSpu0cHsSTil
         ikKno8i4GOHpSUFtn33K0o4fSWVVRoqj7Zez+t8cHqgez4dDtp5YtOtp51eYM+fIuNye
         jd6euQpX7bDx/+a/bzPJA7+whxHLdGotcxeI4Ue2RZyb9R0zIemKrMVoWWaz/JHXrC3W
         qxaA==
X-Forwarded-Encrypted: i=1; AKwUvBxeYfNpw72oSHJiCWN9p6wylpx5lIIbo6JbVK7RdMPcd0iEDWzlB88SrNPi11G8ahh4EURPsH3SzA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIyhZRT29J7VhwkZOugnHpFp5viPz7CNGPE5c+KzuN9ZDFcYEIK
	5xg8357/DTJpFDYGNKPIq5n240zwZW9VdG7XJyWsTR1qRcUMDwxeotpo
X-Gm-Gg: AYBFou0SMIVGp4Ggsx3jlb+L1E9VST0qE8rbWuTCbDJjQ+JwgRhwRtzS2vfTygHSz9Y
	TjyAzCAOE00d5x/aLd1iNfzq1sc0LFLiHP/w96XA6CbyGKyRv0MZMUeOoRp1KMLfKVEXXEK8dTr
	2QWMDYUb/8PET6RHDv6inwTL9WQ6Q6xVHnCgmrRUOkph9IiohxP9BkJmz8HJLXfK1LzmoMj0+Ed
	sAiRSK7yFfUyaKR5UpUKn26LBYFPA32E5ja5setbQgoNGI6wjJdqXIWyzMyI8WE5ayDfqa8UYeK
	b7smHNC2QUV1m+izmK+rOVjtlE6Mx7aPL1pJn2ncChwJRljbN28sPZKdHYK4gCnK3oKXr5gCwyT
	aaTFXKa0Sfu4vD9jrKBOotW0gb+ISBIaHc9ZhakQ1Y0d16/KfvLpWqoW/ptun5sU4romL73ywlC
	yol6btQ+BD8UegSo1iwFVQejVqrr/iObZt6bD7ehqWcu4yEig1vnwDBOa26COseSlALasM3R1R2
	ppMGaM3H6UBUkmiXpPGxPLbYpnDvNSE5EMj
X-Received: by 2002:adf:ed50:0:b0:48c:7caa:12cd with SMTP id ffacd0b85a97d-48dbaae379dmr21487148f8f.22.1791994843601;
        Wed, 14 Oct 2026 09:20:43 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm8545727f8f.29.2026.10.14.09.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:20:37 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Birk Skyum <birk.skyum@pm.me>
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Reset the in-band sleep state on power off
Date: Wed, 14 Oct 2026 19:20:24 +0300
Message-ID: <20261014162025.3733-1-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <179163212446.46972.2306254853726299632@pm.me>
References: <179163212446.46972.2306254853726299632@pm.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Birk,

On Sat, 10 Oct 2026 11:35:26 +0000, Birk Skyum wrote:
> qca_power_off() cuts the power of the controller but leaves the host
> side of the in-band sleep (IBS) protocol as it was. tx_ibs_state and
> rx_ibs_state are initialised in qca_open() only, so a controller that
> qca_setup() powers on again meets whatever state the last session ended
> in.

I ran into the same bug from another side, on a OnePlus Pad 3 (SM8750,
WCN7880 on UART at 8 Mbaud with IBS), and came to the same fix in the
same place, so here is a second trigger and some test numbers.

The second trigger is HCI_IBS_TX_AWAKE rather than WAKING:
qca_hci_shutdown() deletes the IBS timers and then sends the
pre-shutdown command, which goes through qca_enqueue() and arms
tx_idle_timer again for 2 s. If the device is opened again within those
2 s, the host still believes the controller is awake and sends the
frames after the new setup without an HCI_IBS_WAKE_IND, while the
freshly booted controller starts asleep. The commands right after the
setup get through, the first one after the controller has gone to sleep
breaks the link:

  Bluetooth: hci0: Frame reassembly failed (-84)
  Bluetooth: hci0: Opcode 0x0c56 failed: -110
  Bluetooth: hci0: crash the soc to collect controller dump

It shows up with "btmgmt power off" followed by "power on" within 2 s,
and on every boot of a board without local-bd-address when user space
sets the address with MGMT Set Public Address right after registration
(the unconfigured controller is powered down after its setup and up
again well within the 2 s). The stale idle timer can also queue an
HCI_IBS_SLEEP_IND in the middle of the next setup, which is what
df1e5c51492f was about.

> +	/* A controller that loses power is asleep when it comes back. */
> +	timer_delete(&qca->wake_retrans_timer);
> +	timer_delete(&qca->tx_idle_timer);
> +	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
> +	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
>  	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);

I agree with what the Sashiko review pointed out [1]: without _sync a
timer callback that is already waiting for hci_ibs_lock still runs
after the unlock, and ws_awake_device/ws_awake_rx can queue a wake
indication after the reset. As both timer callbacks take hci_ibs_lock,
the _sync variants have to be called outside of it. This is what I
have been testing (on bluetooth-next):

	/* From this point we go into power off state. But serial port may
	 * still be open, stop queueing the IBS data.
	 */
	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
	set_bit(QCA_IBS_DISABLED, &qca->flags);
	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);

	/* The controller loses the IBS state with its power and comes back
	 * with both sides asleep, as qca_open() assumes. Stop the IBS work and
	 * timers, drop what they queued and start over from there.
	 */
	cancel_work_sync(&qca->ws_awake_device);
	cancel_work_sync(&qca->ws_awake_rx);
	timer_delete_sync(&qca->wake_retrans_timer);
	timer_delete_sync(&qca->tx_idle_timer);

	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
	qca_flush(hu);
	qca->tx_ibs_state = HCI_IBS_TX_ASLEEP;
	qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);

All callers of qca_power_off() can sleep, and the work items do not
call it, so there is no wait cycle. The flush moves after the waits,
so it also drops what the work and the timers queued in the meantime.

Sashiko also suggested Fixes: and Cc: stable, with df1e5c51492f. I
would point Fixes: further back:

Fixes: 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990")
Cc: stable@vger.kernel.org

3e4be65eb82c is where the IBS state started to outlive the power of the
controller; the AWAKE case exists since then, and df1e5c51492f made the
WAKING case permanent. Mentioning the AWAKE trigger in the commit
message would help too.

Test numbers, five quick power cycles each (power on within 2 s of the
power off, then a scan): 4 of 5 fail without the change, with commands
timing out ("Opcode 0x2042 failed: -110"), and 0 of 5 with the code
above. With it, user space also sets the address at boot without having
to wait for the 2 s first, and it is now in the kernel I use on this
tablet every day. I have not tried your v1 as posted; I expect it to
cover my case as well most of the time, but I have only tested the form
above.

Would you fold this into a v2? I am happy to test it on this board and
give my Tested-by there. If you would rather not, I can send it as a
separate patch with your Reported-by, whichever you and the
maintainers prefer.

Thanks,
Vladyslav

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179163212446.46972.2306254853726299632%40pm.me

(I used an AI assistant, Claude, for the analysis and to draft this
mail; the tests ran on my device.)
