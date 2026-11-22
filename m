Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362921;
	b=dKBFGvKKVz7OHCDZ8Pi4AlOfU5a4nenN/DYQg1xdt5gJChP2phXYWccNSmO801M24h9z
	 V4LUwaJci2u5vPtfWtDcuMFcDDWEQ1Efriz81GkX1XAh2gFRG27nCgWNclaeu0L0ahQH/
	 oZvAVIU6DXOP583bmnCVahlWRigkAOvT4X5OC8PPQb1JNd5EjiU7xAI/siqxy7Rp/Auzm
	 fjrPg5yILXpBjJPiHUj1jlu/3UGeHbcYgKOpbp2i1RzhiqnhH0CY7P6UHUvbcwSEGdoDe
	 6GqEH4ORzDM0CdeM3BUAKeYL1/pftneuXs0CbTBnNRm3xYal7JapOargKYtl94pUbvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=brpic2gxGr+UpSfI0BgDue8RQ+H82jnfKcpc5s/aMXc=;
	b=uEFpg0aLPTp1xByIrnnHXAMdSQssWzFf/qbmoCifX6k/hgeX30Qj4tLuZaU8E7z3i42X
	 sqQrRw2m3pmvf0ifsPfFkol2eK5LzMS12a3d6/gKErgJXHzXcef175rlJ5tKTQ3PBhgmO
	 V2gC/H2WU4o8PkRmcCRvLJK3bYoN7OiuMOGZV4KyMiUPfsg6Fh15/vY2yEbCA3uw0OyYd
	 Z70T57qU265s7XFno/KjlLQcSfNtsmw6aI/B4a03utqr5KW2Z80xCHZWT3aIpyeoOXTqH
	 Qh8LZCWCG06jqXJyhhM3izLvDKX11dn2a8Q+unWGsXHO6m6du/UKG98gU0Ff3eOYXOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=bil9fJbq;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC2606A320
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 15:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3AC2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=bil9fJbq
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so20991625e9.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 07:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795362919; x=1795967719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=brpic2gxGr+UpSfI0BgDue8RQ+H82jnfKcpc5s/aMXc=;
        b=bil9fJbqhNgXKfTrt5C1qeGhaAIDqp1n0HDVT7PotrnPdUESBT+nvMEGl6xNrKCpzL
         332LI2TTNKzVmI3TnPvHEuzdM+qorDvEbzED8A6Qi2aVSdON4Hs+Be4ysEtnYdbO4dLJ
         VQ6iCAuTfAEYzhxWr80MbXz6yph6H6P2gAAQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362919; x=1795967719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=brpic2gxGr+UpSfI0BgDue8RQ+H82jnfKcpc5s/aMXc=;
        b=M5LeD7yIoocDYrrZN6qiGALnlW2TQuV7sACxIT1xqZIMJs69R94A0Fujdz75ymlScJ
         ZlF25+55LSyOmuui8iQ5xks5dnGGTTc0sMFVb3K8fm1g+doqq3YUeOTmIo8blbu0/pkm
         7+OlgrFV1eh0VwVNpE/9bimuiGaBzBw8z2Ps08+mbv/tvJ5E6bpshqU0POUTLkM7UYAo
         s21HFwk0mhUuiNI5zjAdskZpe+zAEvLChpYJNCbY3wz8nX6x9H86pHqBcIRF6E7/ckZ9
         ulhTHvOzEMHg8+9jCQWtiiPEFAK6+NOc0mQ1F1MepmPtXyWphF9ZWrSE7ILuS8snWDfo
         d/eQ==
X-Forwarded-Encrypted: i=1; AL+hErEja6HLeQXXx4pZ9NpzzrqFYTPcqohzYyTZ7z8xCRxeIWiy48apm10kYZ8LRmBVqx/YnADzYyeHrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+48C1lQZ00g3GH2Hl2P3lPgShhl/ibfFktQABQGZ8A/XGvY7pi
	XEzBs11PfEo76LynoArPDcJGgPJglGL+DAqeyQwSPEGxe3fd/RTt2XXM3D1VfOTCp9Hx0YtUjkU
	XNVvH
X-Gm-Gg: AZFdTZdhd9mCX/ge5U6ZDMBzXJ1VQtxHewwPKghHzoCxADOGMnRPHCm9f47AsLeJndU
	5147hJ6TSfMVMws2rFTxbedzaSyr/cpqNTgKFtJ87h/BwZpDfwc5vGOfgWnXoHTQ9Rc5h/AuK1Z
	KD9KJrFoY4Hof2rFg9w9njrvvcYdk/eFD0y8+VS21KvGdb71YJujKBKpjGYbas54RQZZnx2HCzf
	5Wf4k2RfnT32PsVHGgwpfER6rsgNteDN6caEEM8ZYRDOf6SlNb9DLsmdG/b6xkOPHGxzexRWDcx
	uI2L6/9BGXoXjviXbFo2sI41qAkXoYgEg6z40YBVgW+pON8LX30Q+BjNTz+0hkkTcc+g371/9/p
	IeuD9OCy4tXZWJpsmoGKzl+ZTUP5guxvWrLXZDdNhXjkvlL85Lp88GArX5mTEgngG/AvGmollvl
	n9L/pwKMFUFgilvqXtkQWGRyMrVnvJ6+LKRq/jgiZtJqBOD4iWpKppDJ0d398VhPZjqgilLAT8u
	jflEls+uLbGnVEpqKjs1wBpP4rgriB0xLQh3sASZ0ir2/VTx1uUP0ldMoCdL+FAARj7ZT1cN7II
	MIs+pw78oJw8boO8F0vlqvB7qNlO/a2S7JHAFfMiRCQxy/laXBExdoi34eOyZwk3gG4nlg1EKgJ
	cuwQUVEVMYJyMI0xUYXJSE9uh3BbviQIBuc0VCONLWxQvpqwCQKZop75wZwg4UTG94Tju7SO0Tm
	sprGjI5H2ZmaWT1oWjnfvNipqZ7g==
X-Received: by 2002:a05:600c:820c:b0:4bb:6a2d:b426 with SMTP id 5b1f17b1804b1-4bb887c281dmr172330355e9.1.1795362919237;
        Sun, 22 Nov 2026 07:55:19 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm20046526f8f.55.2026.11.22.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:55:18 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/4] pmdomain: imx: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 16:55:07 +0100
Message-ID: <20261122155514.10289-1-dario.binacchi@amarulasolutions.com>
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

The i.MX8M power domain drivers register all their domains as off.
A domain left on by the bootloader, e.g. to show a splash screen, is
then powered up again by its first consumer, which on the i.MX8MN
turns the display off and hangs the system.

This series reads the state of the domains from the hardware, so that
the ones left on are kept on until their consumers have probed.

The first patch fixes an error path of the blk-ctrl probe. The clocks
held by the last patch are released at sync_state, so they stay on
until all the consumers of the blk-ctrl have probed.

Tested on i.MX8MN (BSH SMM S2 PRO).

Changes in v3:
- Add Reported-by and Closes tags
- Drop the runtime PM reference synchronously in the probe error path
- Keep the bus domain on while the state of the domains is read
- Remove the domains before releasing their boot-on references

Changes in v2:
- New patch
- Release the resources of the domains left on when the driver is
  removed
- Take the references once the probe can no longer be deferred
- Clear the boot-on state when the domain is powered off
- Release the references when the driver is removed
- Rebase on the changes of the previous patch

Dario Binacchi (4):
  pmdomain: imx8m-blk-ctrl: Remove the power notifier on probe failure
  pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
  pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
  pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state

 drivers/pmdomain/imx/gpcv2.c          |  77 +++++++++++++-
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 144 +++++++++++++++++++++++++-
 2 files changed, 217 insertions(+), 4 deletions(-)

---
base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
branch: imx-pmdomain-boot-on-v3

-- 
2.43.0

