Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21F470436
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009180; cv=none; b=ZX7kT9xwuOiaJgVDgPB48JAdPFF3+XhsBXM6V6WYWpvtdq0uXDBWTSMN0v7yIRGRBYQbx5PN4VNVEBbSWSw46P6yTeKnRHnEx+92+DowlI8DTZBR3t26WKV+4FCyh5MeUG3rVyiQ/ub0NfqQW1IUEc7Zoy3JcCXqYh4yQqYVysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009180; c=relaxed/simple;
	bh=kinkC29WvS0b/NptnkjpapLFAfkGMSNO2ScqpNI9P/E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y+hVWfxDSrz2TpwhVfg4NlbLso3Cs8rn6DKjwgM+mQSK2a4/YmeKCAgLMKpZ4yJC99vZMYWSpktP8qIU4XL9C87sjQ++pr2Yzqd/BQfsU3aVBxYT1fCDgNsSHqNeE5UNwdPVtvxrz5x5VJWGL7VoEWunfc6iMtLQ/Eyz8ZvyK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ng5L8RRi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMFTA1Hl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ng5L8RRi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMFTA1Hl"
Date: Wed, 14 Oct 2026 20:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBUbvTfOwBdn645N7lMSj9SMkufxJK5+ItPeXTKXZxk=;
	b=ng5L8RRiKmW7W5acYHPSSNK0u+thk+BTGWHXA+Ep3GSTvdcd45Eq1gaKpGG+xy8JtNWBWl
	WTp2Azh++qEyZlKk1U0olJVyEffBNne08wvqB7X1Nvbe65XR6Xa+qh9v4U08RE1maUYoZl
	jMcfNqdc4fZxZjxKwF+6rwrEg0KZFQFB+MrIWQlnQz+8LRWI6074Y3UmN7sm0CqlR3t+z1
	2LnXMhvbv9WyhW7zm7Kct2FWF8s4XXnEEa7E3dI5jdvdLgnX6mkntYDJw2ceI5mJkCgblK
	mINeHi8p3cBvVoWFL0KkbzQs7pyVEbu14vqaQe6h/CtVZnkBAgTY3/jGLgpaLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBUbvTfOwBdn645N7lMSj9SMkufxJK5+ItPeXTKXZxk=;
	b=DMFTA1Hlp+QWfFRPMf6eq767Ve8N6iIB8L6ldznbqC7nXVaoaiNuFYFCFxFT9pLc18OX+J
	C7xV3oCMKyY9Z6CQ==
From: "thermal-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] tools/thermal/tmon: Fix string
 truncation warning in optarg copy
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260929201951.408456-1-florian.fainelli@broadcom.com>
References: <20260929201951.408456-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200917531.2666337.8834006269098707354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     602da762f7a7c494a95cb204ac005965b214e556
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//602da762f7a7c494a95cb204ac005965b214e556
Author:        Florian Fainelli <florian.fainelli@broadcom.com>
AuthorDate:    Tue, 29 Sep 2026 13:19:51 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:40 +02:00

tools/thermal/tmon: Fix string truncation warning in optarg copy

GCC warns about possible string truncation with -Wstringop-truncation:

  tmon.c: In function =E2=80=98main=E2=80=99:
  tmon.c:233:25: warning: =E2=80=98__builtin_strncpy=E2=80=99 specified bound=
 20 equals
destination size [-Wstringop-truncation]
    233 |                         strncpy(ctrl_cdev, optarg,
	CDEV_NAME_SIZE);
        |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Replace strncpy() with snprintf() to guarantee NUL-termination and
silence the compiler warning.

Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsy=
stem")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260929201951.408456-1-florian.fainelli@broad=
com.com
---
 tools/thermal/tmon/tmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index ef67cd1..70a2ec5 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -230,7 +230,7 @@ int main(int argc, char **argv)
 		switch (c) {
 		case 'c':
 			no_control =3D 0;
-			strncpy(ctrl_cdev, optarg, CDEV_NAME_SIZE);
+			snprintf(ctrl_cdev, sizeof(ctrl_cdev), "%s", optarg);
 			break;
 		case 'd':
 			start_daemon_mode();
