Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB34A2A6D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009223; cv=none; b=EWEwjECLjV8FX1ORaZE1/0CgwWbPP9VKtUcqwH4mR+PZImenV5479UtmxMFY2LMBU+DC7Gs/mR7vXujkWkiDVPlxZQi4gUiqajXl4UwlKGPDSxUimEOHMcfaA4exEaV8XQ1tZq2KgoyjhqdfLVnRTLdSgXio2AlooIPn7ZjW5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009223; c=relaxed/simple;
	bh=q4H+YyY6pkyGRqvJMexJy8ijysNYO0cjM/a+0vUfuGM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZOgWoedPrl03fkvTwX6sjWeZxSWnfDwSAITqUy0C+pmjQ/6Swa9eiJvDD1ajZosZBB+iwky4FSNmdRLZpM8fsIDZdJMvc87YL77C6t7vJsCQfv/6REAg6yPpP3DhiFZZi6cVeMDbYjxVT6kudiMN5zTlLSy40dwB/EssB/+ucJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+e1nZ/i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XprvVrvc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+e1nZ/i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XprvVrvc"
Date: Wed, 14 Oct 2026 20:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9X9LE+L2MVKriwf6gii/GKCTyhz95agvgDyVaaSwJM=;
	b=W+e1nZ/iglX1bIOTavXyPdq4ZIOjdJ4nLhj0kNWfpBAAPsEV7sjeWcoA/uu5R4CYQXux+p
	voIdK1Ygk6W9jqziyzPVb1aF3eR83c0diE67TCL9++EL68Rlxps+mRyw9WeTF7wYdTQPio
	QWQEaGjSFFT8bzcnv0VCpswvfsMmMMUmHSCl9cgNrlhb3iRGmwe+8FToHQWEwepfuMro18
	LCzvNNGENqDzL557gfy+enr61IAt1AO9hUGxw1GpUZrLqSA4spqXtjLlmK4zEA8imxTwei
	9Ig3lQ4AoOsuyWM1mnQHPbBv/ULegDN0mKp0coKHHm6Fg43mReJMo+ED9RNFkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9X9LE+L2MVKriwf6gii/GKCTyhz95agvgDyVaaSwJM=;
	b=XprvVrvc550VbzoUPEzjsvhDqtx/gCIUeKmz627Fh/TowdDITg3CWSfuvMBPYcmU8KJBZ3
	JyQtgniXrGisDjCQ==
From: "thermal-bot for Hemanth Selam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/linux-next] tools/thermal: Fix typo "binded" in comments
Cc: Hemanth Selam <hemanth.selam@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260917080002.23952-1-hemanth.selam@gmail.com>
References: <20260917080002.23952-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200921754.2666337.15666569717934126347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     7cbf4366da396f415e9c9f1d5b11b45ebdf59ec3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//7cbf4366da396f415e9c9f1d5b11b45ebdf59ec3
Author:        Hemanth Selam <hemanth.selam@gmail.com>
AuthorDate:    Thu, 17 Sep 2026 13:30:02 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 18 Sep 2026 11:06:07 +02:00

tools/thermal: Fix typo "binded" in comments

"binded" is not a word; the past participle of "bind" is "bound".

The tmon.h comment counts cooling devices, so the noun is plural there,
matching the wording already used for MAX_NR_CDEV_TRIP.  The tui.c clause
needs "is" to read as a sentence.

Only touches comments, no code changes.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patch.msgid.link/20260917080002.23952-1-hemanth.selam@gmail.com
---
 tools/thermal/tmon/sysfs.c | 2 +-
 tools/thermal/tmon/tmon.h  | 2 +-
 tools/thermal/tmon/tui.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
index cb1108b..5d64aff 100644
--- a/tools/thermal/tmon/sysfs.c
+++ b/tools/thermal/tmon/sysfs.c
@@ -225,7 +225,7 @@ static int find_tzone_cdev(struct dirent *nl, char *tz_na=
me,
 				cdev_name, cdev_name_linked, cdev_id);
 			tzi->cdev_binding |=3D (1 << cdev_id);
=20
-			/* find the trip point in which the cdev is binded to
+			/* find the trip point in which the cdev is bound to
 			 * in this tzone
 			 */
 			snprintf(cdev_trip_name, sizeof(cdev_trip_name) - 1,
diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d7..b776705 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -77,7 +77,7 @@ struct tz_info {
 	char type[256]; /* e.g. acpitz */
 	int instance;
 	int passive; /* active zone has passive node to force passive mode */
-	int nr_cdev; /* number of cooling device binded */
+	int nr_cdev; /* number of cooling devices bound */
 	int nr_trip_pts;
 	struct trip_point tp[MAX_NR_TRIP];
 	unsigned long cdev_binding; /* bitmap for attached cdevs */
diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 7f5dd2b..dbc3ca9 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -238,7 +238,7 @@ void show_cooling_device(void)
 				unsigned long trip_binding =3D
 					ptdata.tzi[i].trip_binding[cdev_inst];
 				int k =3D 0; /* per zone trip point id that
-					    * binded to this cdev, one to
+					    * is bound to this cdev, one to
 					    * many possible based on the
 					    * binding bitmask.
 					    */
