Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794290267;
	b=iPsVSVZ6qzve/frMkO5cYeQ9ln1AWqm7Wii6H7/a/8tPfCgNFP9jSJQNTmwcsKnE7ciN
	 EwhGTm3x6OzzZSuThizMam8ANHQiMv5B90TlTQoVcUlZjclHsYielbH0fG/4i/xt1cN4L
	 hYz65ltJXIzXQXb16/rBQaIywmtScK672lJ2WoP/b/33EJbXQEWKtqI4+BDJ75dpJxGRu
	 veMpfZ9eBhVsdu9GroH0yoS39NJFnqOYRVO3Fl6j+0DUjFUyMXfGWySAig7UWTgryDN1u
	 jAfJ2bkt2KsKvIanQNRKPMnxe3ftCmybrxylCYaHE6X1sR0cQBsmhxv7jycp+QkiPgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290267;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0NUhR6yhNUL4+ELGoSgMHNPURFuH94K4EA7n1oL0VZo=;
	b=VVwtzu2aKgvGfzgG9U9NOoxX7ouvvku+b8gvg7t4t693uHVwpth0D3DK8SRhrOr90+B6
	 g9/F9M8aThCyxFW2zQ4fMRtgGescSIDqIJG84iVIi77O8kW6hYSb8qHw/6XHb696hSmjp
	 D2K6P1MPIzmRZ1JoQ+vODJu/mbe67GxKZTkuZ3o29P+GdLUkqlX+CQ/CaQ0l8xnZDDIMo
	 A5XGUgViW7r+9zG2wjVfPMFhYMMtXZZEe1FcMqz8sI4HLE+vOmmSastQLR3o8rhkGeWVX
	 gcwQdxbIhoLWQ8KUBtjL/uIE5oLkzq7VXo96A6zpkpgie4AKf0eVPnfv0m+NHpiJucA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCbCy5XQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FD606A31C;
	Tue, 10 Nov 2026 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCbCy5XQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794290266;
	b=2gdjz6DQOXz6lS/5Il1f3BM7/U3RgbYCiNIMWVTFfTwBE0/4r3jIMQhxfgaKRHnqQIAn
	 Sa75QlQRKhqETQG+dj5dbcXxVzu96/Xu52jEqLgAuq77Oi0IUnowIZG/qTacElgfyG+qM
	 dct8EQza7rWET1qHwJIfiRH6hVTtmlUuPJyE3F+4Rr5sONTuqDWPO+xTeZhr+TaNuTMSP
	 7of3PQk+GVjmOJ13MISmCaTv89g+xjLgl9S7trfJqdjD7DI2yj/YL4+ucf4FekjbhcMPB
	 NlAQVqZEDCH+0psotmahVh6F2uCT/vDu/TfgO7VFfWPmYmaicWX2X+yWRL1DY6E1vNw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794290266;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0NUhR6yhNUL4+ELGoSgMHNPURFuH94K4EA7n1oL0VZo=;
	b=BC4ZGGQ/W62zmw0vhYZV7VMJUe7qYhEqPeB0ZQ+BvjNQhx1gEUYa63aqS55P/hznuXGG
	 XIHKI9kX16EU30EDeMf+GuQT18nRgSa6Okmc/XbQkgNTJG2mAPQ9QgrGy2O8xk44KARRK
	 JwP2myjRWof/L4Z/Y31AY4OFzEovh5RAYhDTCcgSjYtIARFkls3NDOzvZbN44URb1li2C
	 uinOd2ZtzdJtEdiCFGmmR/LxZq6QE0nR/88FinyqdcIO2cYgmIPKkueOodiU8BahduOY5
	 8vG+WEwEOgjSf0xJUpgN0xNbEIy2I/ZHlp7Ts2FGrfX17+ujBSBFRQCn8Rrpczcba3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E62DB1F0089F;
	Tue, 10 Nov 2026 05:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290266;
	bh=0NUhR6yhNUL4+ELGoSgMHNPURFuH94K4EA7n1oL0VZo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=UCbCy5XQfhiqItKcd4AEgqOZs9hsJR1GPs3nPqPXiaVtxmMNwtXwE4QOUBAlcAnhw
	 N+QEVbnsowMMTbb4g6/RS2FxtJjVcBlebXkc44mCP102Q4h74lqJomi82Zx8tKvowi
	 JlyQloVkLAOgfN+pca7o47ebOQYfDH2i7NS2JzXN/B7CWkJswNCycXDNblWHZit68I
	 ZaJIRBnTlJTp7nETgPtLzQgSZ/ylqR4jbdKZ60lE0bb6M6dGA8exz/qCAYjxkEV+1E
	 L45TK1rv0dXS0Kaw3oONK3UorCPHRpGyFqhXwTjgFY9Yugvo3xJYT1b4HP9PTMzQlw
	 lejQAXYmZpcZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2FF9548893;
	Tue, 10 Nov 2026 05:57:45 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 05:57:45 +0000
Subject: [PATCH] PM / devfreq: Resume at the frequency from before suspend
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
Message-Id: <20261110-devfreq-resume-freq-v1-1-90de450ccbd0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5EQBCE4VeRPpvETETEq2wcGDW0hLXdSyTi3
 Q1u9R3qP0ghDKUqOUiwsfJ3jrBpQn5o5h6Gu2hymSustZnpsAXBzwh0nWCejdyhQVuEMpQUn4s
 g8P5UP/VrXdsR/n+n6DwvjWdj2ncAAAA=
X-Change-ID: 20261110-devfreq-resume-freq-e42eaeb6f8f8
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794290264; l=2896;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=tdlutxMME+GnXd+M6y/2TwHqtzvKQ3bamAdqTwwxsDk=;
 b=/P0AlERKNeMv1oK1rQ9ScANECsCNBtd20fQ+QTuJVNIhjjR+2oRX3S8mzeF6DN85r7uIEXRt6
 D+sclVwSoGcA/oxPBAyDjs1RGYKWO/3ti1RlG4PrSyDGbGCzBc0tWZG
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

devfreq_suspend_device() moves a device that has a suspend OPP to that
frequency with devfreq_set_target(). Since commit 62453f1ba5d5 ("PM /
devfreq: Use more accurate returned new_freq as resume_freq"),
devfreq_set_target() records the frequency it has just set as
resume_freq, so the suspend transition itself overwrites the frequency
to resume at with the suspend frequency. devfreq_resume_device() then
"restores" the suspend frequency and the device stays there until the
governor next re-evaluates it.

For system suspend that only costs one polling interval. For a driver
that calls devfreq_suspend_device() from runtime PM, such as panthor,
every runtime resume starts at the lowest OPP: with a 50 ms autosuspend
delay and a 50 ms polling interval, short bursts of GPU work after an
idle period run at the suspend frequency.

Save the frequency the device ran at before the suspend transition and
use that as resume_freq, as the code did before that commit. Requests
made while the device is suspended still update resume_freq through
devfreq_set_target(), as before.

Fixes: 62453f1ba5d5 ("PM / devfreq: Use more accurate returned new_freq as resume_freq")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
The bug was found on an RK3588 board (panthor, runtime PM through
devfreq_suspend_device()). The patch runs in that board's v7.3-based
kernel. I could not test it on a second platform: my Allwinner H616
board has no suspend OPP, so the changed path is not taken there.

This patch was developed with Claude (Anthropic) as a coding
assistant: it wrote the code and the commit message.
I reviewed it and tested it as described above.
---
 drivers/devfreq/devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f08fc6966eae..043cdc37bd0b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1146,6 +1146,7 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
+	unsigned long resume_freq;
 	int ret;
 
 	if (!devfreq)
@@ -1163,7 +1164,15 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 
 	if (devfreq->suspend_freq) {
 		mutex_lock(&devfreq->lock);
+		/*
+		 * devfreq_set_target() records the frequency it sets as the
+		 * one to resume at. Keep the frequency from before suspend
+		 * instead, so that the device does not resume at its suspend
+		 * frequency.
+		 */
+		resume_freq = devfreq->previous_freq;
 		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
+		devfreq->resume_freq = resume_freq;
 		mutex_unlock(&devfreq->lock);
 		if (ret)
 			return ret;

---
base-commit: 9a222650d9e70d0027126e4df5b00b1b5b678a97
change-id: 20261110-devfreq-resume-freq-e42eaeb6f8f8

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


