Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCE44C65C
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792349602; cv=none; b=KHmy1z/NVfjS2uwQ6eB22rjzieZ7u+CJwCU/x+DhJ8peqVyIJ0IJrE73L8asZdJFBfJnwloWMslq8NOFSHi455tpRmYp6bIkPWY/4GYrc8rY/1bHlBCPvTIsqFcKqKy0KGQtQCtZF3Ge9OwPpMnfroDYrZqEY/6BYh9TevkRJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792349602; c=relaxed/simple;
	bh=lX+5dhgX4NC37aSTPQkLBUr6y8jXX7ECoAi6+Pd+qxw=;
	h=Subject:Message-ID:Date:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VlSIuEpfhV3ZC0TqZpzAnWZuMn1u6pe7Vh3lEKSo/tyjQ2/dKQKoNnnn9kSDptlCPaTGxooGHM18SmOzjlSW7QNZmpeFv+4uZrrcAw43r4PJO/j6JSbYyG0VNAGSqIYRiFQnAwem3T01Zs+sQKhxJJfHD5MMp6TTB3ZWwlXMJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=snyders.xyz; spf=pass smtp.mailfrom=snyders.xyz; dkim=pass (2048-bit key) header.d=snyders.xyz header.i=@snyders.xyz header.b=fKXTOTVT; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=snyders.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snyders.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snyders.xyz header.i=@snyders.xyz header.b="fKXTOTVT"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j76zw4jR8zNkJ;
	Sun, 18 Oct 2026 20:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=snyders.xyz;
	s=20251118; t=1792349100;
	bh=tiVAKs4hM0hfl1tlMLQJmGB+/I9Qxi99EZnZZxfXMO8=;
	h=Subject:Date:From:To:Cc:Reply-To:References:In-Reply-To:From;
	b=fKXTOTVT9AfcYa40wbFClGkXyXf356KfNsB4NIJlm5PEBu+/hAtcrvdqUJLnzWqV6
	 6pXK9n9EU9LDaFGQW4+WaE1RHrksbFN+UfFkbcdqSn4z6+UveCs0pSL1TLiIswDwpX
	 A7q+55UPaouvvOgZcbjeBmjfj7To1047RrKPjbeVE2Xy+7mDbnhXNU4E+xn4dj9Y4/
	 LlpH03MFdpceC3OlbQNkeaXjIMGUTDZtRj1EMW+2S1PWWxHgEtV99MPMQBRqnQ4aAf
	 27DQJ3R0AocSK5LODIoM1ZlL/RL3sTR02q843Ff50RcXIpnz8dFaUc+YyYIksc493r
	 uZGDMd1/Ez+OQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4j76zv3jBbzB73;
	Sun, 18 Oct 2026 20:44:59 +0200 (CEST)
Subject: Re: [PATCH v3 2/2] power: supply: qcom_smbx: add SMB5 support
Message-ID: <7e5c96b8-e1ae-4819-874f-db818061be58@mail.infomaniak.com>
Date: Sun, 18 Oct 2026 20:44:59 +0200
From: Robin Snyders <robin@snyders.xyz>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj
 <foss@joelselvaraj.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robin Snyders <robin@snyders.xyz>
Reply-To: Robin Snyders <robin@snyders.xyz>
X-WS-Location: eJxzKUpMKykGAAfpAmU-
References: <20260813-submit-qcom-smbx-send-v1-v3-0-27be0091d7c7@snyders.xyz>
 <20260813-submit-qcom-smbx-send-v1-v3-2-27be0091d7c7@snyders.xyz>
 <hryxv7fl3alrhnekb7bqn5zgexdyv3p6ndug7kp3uqxsiiwmsv@wtvg3za3qspu>
In-Reply-To: <hryxv7fl3alrhnekb7bqn5zgexdyv3p6ndug7kp3uqxsiiwmsv@wtvg3za3qspu>
X-Mailer: Infomaniak Workspace (1.3.1376)
X-WS-User-Origin: eyJpdiI6ImtobERxMUZTdUNyZ1Q5QjFtTFlaaWc9PSIsInZhbHVlIjoiOWVGVCtlblA3am9VcGRhbktlQUliUT09IiwibWFjIjoiZmM1NzU0YmZiMWJhMzM3MDNkZjk1NzYzODExNjQwNjczZTc3OGNkZWMwYTllYzNjY2ZmZDUwNDA5ZDcyZjdlZCIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6Im1LVzkyZWVkWTBsOGJKOVZYZUljS2c9PSIsInZhbHVlIjoiL2d5d3Rab3pySDkwT1QzZzl0RFJRZz09IiwibWFjIjoiZWZiZTFjMmFhMThjNzI3Y2I3ZTE3NGQxNGI2YzVhMjBmNmQ1NmE2YmRkNjdmOTRhYzNkYzA1ZGZlMDc5NGVkZCIsInRhZyI6IiJ9
X-WS-LOCALE: fr_FR
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Infomaniak-Routing: alpha

Hi Dmitry,

Sorry for the long delay in getting back to you on this.

On Thu, Aug 13, 2026 at 06:52:24PM +0300, Dmitry Baryshkov wrote:
> I remember that in SMB2 case the TCPM and charger drivers were
> programming the registers from the same block. Is there no such conflict
> on the SMB5 platforms?

On PM8150B the register sets are disjoint. The charger node sits at
0x1000, the dedicated Type-C port at 0x1500 and the PD PHY at 0x1700.
With SMB5, qcom_smbx only writes the charger core (0x1042, 0x1061,
0x1070), DCDC (0x1108, 0x110b), USB input / BC1.2 (0x1340-0x1380) and
the watchdog/AICL timer (0x1651-0x1661) blocks. qcom_pmic_typec writes
are all in 0x1544-0x1560, and the PD PHY stays in its 0x1700 block.

The one name that looks like an overlap is TYPE_C_CFG, but on SMB5
that is offset 0x358, i.e. 0x1358 in the USB input peripheral, and not
the Type-C port register at 0x1544. The driver only clears
APSD_START_ON_CC_BIT there, so that BC1.2 detection is not started
directly from CC state while TCPM owns the port.

By design, the SMB5 path also leaves Type-C power role and VBUS control
to TCPM and the qcom_usb_vbus regulator. It does not touch OTG/VBUS
boost, and it only clears the HVDCP modes so stale firmware settings
cannot raise VBUS.

> Have you tested that this doesn't break the USB-C
> dongles being connected to the device?

Yes. I validated the exact v4 driver on a OnePlus 7T Pro (PM8150B,
6.16-based board tree; the only other change was an
unrelated SLPI debug parameter in qcom_q6v5_pas.c) with TCPM
managing the port, in both plug orientations:

- Powered dock: the phone became data host and power sink (USB PD,
  usb_vbus disabled). The USB 2/3 hubs, an RTL8153 Ethernet adapter
  and a mass storage device enumerated, and a 64 MiB read gave the
  same hash every time. The charger stayed online, health Good.

- The same dock with its external power removed: the phone stayed
  data host and switched to power source, with usb_vbus enabled. The
  hubs, Ethernet adapter and storage re-enumerated and worked, and
  the storage hash matched. The SMB5 charger correctly reported
  offline/discharging.

- Then back to a PC cable without rebooting: device/sink roles
  returned, usb_vbus was disabled, USB gadget networking and SSH
  worked again, and the charger resumed charging at its 500 mA
  limit.

None of these transitions produced an oops, lockdep splat, UVLO, OCP
or OVP event. Ethernet traffic (no cable at hand) and visual
DisplayPort output were not part of that run.

I'll repeat this on the exact v5 tree before sending it, and summarize
the register ownership and these results in the v5 changelog.

Thanks,
Robin
