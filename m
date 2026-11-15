Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794774033;
	b=zfz7gzZQuyweaMFW3IZRDBGtQ9PaxK4zwdy6/Mwe4PRsgVobyJcwNMGDm51O7ApKWpi0
	 eUqiah0dUlslcPW8vMxvx2hulFLPhjn1lehRnEetwxsB26q3p7NlR+7QQYjQt9lfH9Kby
	 g3u7+JYPHG8dahTsodTfndvpoYW+rGqbMonCFVfNSc3l18AV+Ey/PpFx5N9p5kEh253CZ
	 72n5u6KTooCUkTm0wVD9wMgPkTVIdyVpjdOhddk9gV7Nu+00SFevJANEEd9hY7IrL07EH
	 GeaA49DEALOTISm/oUI13VwC9/xn+qZU0h+aFPi38uG7QeoPFmfAtL8jhziAsEezmiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774033;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=XFSAxk3juS9e3coMttEko94B/1B32DBuduycYcreYnU=;
	b=sGYSAv9633EOsR0wS1qiD/J+rhMSTrauK/x1RNYEftx9XyHmx2hIb+JTw/Jv/tJeekzk
	 U7/OVmizsNvViy4p2fIjIvHTUNWUK/mUqP9alMmCrYqiulx3+DIJEwVPfY28zXaw2JiW1
	 +E2mcHKwa6XZW7RTN2tlzFisODKCvaJx5bluUhlYubzJPeFtkHozp3ePylvmc2UnFWys8
	 NabFEi6J7AIx3ooAMgIfAc9M3A+rFcNpBxxMMzv6tZ05q2esA7tJ4yfVNVKA8HRTwwQXP
	 Th+rTgfP6wTQqfm70DaS5jHdRmj29Ifag1XKNOqaIaxGF5yz9llVIsO4CBD4UCJCocQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIlmLB+j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F96606B070;
	Sun, 15 Nov 2026 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIlmLB+j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794774033;
	b=iY5DMA/t0U3rdi8dK7JgQaRLAneiRD9WFkR9FbYgnCckvuAvvVTOyCeClHghX7d9RyZg
	 rLy/kYziUKYkt7BRQfQYo0qTaS0IGdT7MZh9n82mkIIlTmbO/lkVssPDYD23i4BAPGaAL
	 5lvwoOzOmDZ+QPgmmg5PjKm9WT0zPmyQlY92GehVdXOSvao8nvG5SCjJezDFp0qwsNWYR
	 URBoZnKIc3dzn5/BiF5dKoCPPECi1VEfTz1L0TA35XzS+UUAvSMET0oRKlaGMyTCX4J8/
	 Af8g96L5bUSV1eTUw7P5J2yWTpND7q/MNEuttHW5HO2fyNIOD6kp4+rET0g+sKR0p3g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794774033;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=XFSAxk3juS9e3coMttEko94B/1B32DBuduycYcreYnU=;
	b=rLVSFCnYG371j4WEv0iz/Nht0ZnKkU318qlGEt6Iwvm06702hcO1cYRckzk4p1kKgmRE
	 egPTfBHYCY2nVMytWdW9FZqO/89r3M2u2q08JVL66uX7Qfn2D1U8heGhtX6REBxrHaRwc
	 Riy02CiHJcSA0uAYDI8yquZs0rruooRz9vy9VDjnetPpEyxpbHvd0LXAi9eq4swtmWaQs
	 tfQhWGIFpF5p1xlhKE6SFYkUqYYgQmVSA/CtngqgHGvEE9BJtp2HumdlWUp3l+wxd4HY6
	 6GMGxfpg7zexqSAPIB65ii+O1ugFy2Y0ZMjv88JX/m+3M3FQ7m87t8j14odkB1dklJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5FD681F02801;
	Sun, 15 Nov 2026 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774032;
	bh=XFSAxk3juS9e3coMttEko94B/1B32DBuduycYcreYnU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=YIlmLB+j/qaiPUIhHYCL4MoqwQOGZG+49BF3W/SJYblJwAmDIlkc9u2czwc1zIk9e
	 LqSoBHOeElip5zt1VdUq8Pyqsq3GgV27rUdsPgoDtj7i8cdzEvvzv68giicje4uWWk
	 JdIL2fLL9R8rkeStcFjWXnaoqlU3vTAxLvi+PGsSk/cpoXNdEVu3fe1AmRkfIp36BH
	 CQ6tcu1hCQ3UEAtafVGFBQPL0ETi2zMDM9bwv2nJUEsyX4lqj4Ij+myPC6r8kgQK9C
	 uhvqtP9TxGIZFZDOSCDSRzFgsAPDINaqUkFteTXwhzpzdA1noOSO3L7zdJB+SPJyWY
	 0bwh6SnXmwKCw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E57F04A181;
	Sun, 15 Nov 2026 20:20:31 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Subject: [PATCH 0/2] power: supply: qcom_battmgr: Apply the USB host
 current limit early
Date: Mon, 16 Nov 2026 01:50:31 +0530
Message-Id: <20261116-vantage-battmgr-v1-0-7b59157377b7@yahoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWuiRV1eRSyqBiNR0pZIxLsrl
 t9Jzn+BQ0vooI4usHiQo9UE8DgCPSkzIqM+GEQiJOdcskMZr8LcKe+X0bIqy1EKWZSpziC8Nos
 DnV+xaX+7vZtR+zcD9/0Ac6sFo3MAAAA=
X-Change-ID: 20261116-vantage-battmgr-945e626783c4
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joonhoe Kim <26rote@gmail.com>, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794774031; l=1416;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=4Urtgqt3DqUBR0q/xYpN0Q5CeFpW3WhiyAQifuY4zz4=;
 b=oiAr1lkrlROgaSED6IMbLGrsZ+fPVW8VaNMJWSreoHIIGGaY9xwgB7oKgKlEd4IjI45ZQ0pP1
 LsQJaq6q3AHACFCYc6r/sRcUeGE8sn886WSTMx13ueeyHkFvUkrDWwc
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com

On the Motorola Signature the battery manager firmware keeps the input
current limit of a USB host port at the 100 mA allowed before
enumeration, so the phone discharges while it is connected to a
computer. The dwc3 controller reports the current the host grants
through usb-psy-name, and commit be5e7367bceb made the limit writable.

The controller reports it before the battery manager service is up
though, so the first patch keeps the limit and applies it once the
service comes up. The second one applies it only to SDP, CDP and USB PD
ports, like the downstream driver, so a dedicated charger is never
throttled to what the controller reports.

Tested on a Motorola Signature: connected to a computer it charges after
enumeration instead of discharging.

I used an LLM (Claude) to help write these patches and their commit
messages. I reviewed all of them and tested the result on the device.

---
Venkat Yadlapati (2):
      power: supply: qcom_battmgr: Apply a USB input current limit set early
      power: supply: qcom_battmgr: Don't limit the input current of chargers

 drivers/power/supply/qcom_battmgr.c | 61 ++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 8 deletions(-)
---
base-commit: 7071d4750856abbc68dfe431acc58a1d45dd42e8
change-id: 20261116-vantage-battmgr-945e626783c4

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


