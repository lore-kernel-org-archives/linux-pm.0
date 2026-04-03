Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2212A1F131A
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219664; cv=none; b=qiEy71fjDsM6/l3D6iuVopBd0v8cPl8I3SQgeu2RPQkMb5fryTY2qPUpLkAB4ay+HV/uFPoww0zXvNg8/vDqt/6RpqRwqvwL7IuL4RZof+n2EQgO+Wh84pmP0Gsizn04rBAm22xlJEb7/BNMyteLGFZA15MW7XChT4VBhpWmFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219664; c=relaxed/simple;
	bh=55lzqmaWC5ky5ds8WgZPiX3QEYZo3j5IuJlsxx73AuQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GOSPd2u6qCjD3WhToTacmdPk4ntf1KF+QqixXwBcMktRFCxcJ7VCubd+Jm/kaNFWjRnxJazWgFOwMlc50B2zO3TGDRCWiqWnB3jObydsXEeXO9dzPjIuRLrmyW98Gd3pXs7Mi/WO/W6GvF/zikK1gQkjzy1/MNDZAUAHvc58syI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/AJzNOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/AJzNOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9560C2BCB1
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775219663;
	bh=55lzqmaWC5ky5ds8WgZPiX3QEYZo3j5IuJlsxx73AuQ=;
	h=From:Date:Subject:To:Cc:From;
	b=L/AJzNOo1lbC1Szo1bxIE5gvfQEGxtnX5YILgUpeNqwfdvHEna8q7ntCLZ8McFLjJ
	 CqbQCrxAGmtbipra8rDbweyWgeO5JSnRFimqa4PTKBlGYojAc11moE/1KD7p3DuiXr
	 1A4G+mqKqr7MjWix34oHe8jsb2iCqdQgQS62YKVuJ053em03csu6z/1QrVuxMBF7qu
	 kZxXzx4ynSoEO4j9urj7TwZVhKyXHbRWfNDqiMP8c/A7wmLMO8vvdqfuW2MmkrSWtd
	 Jt1SWIA/Vj6uhmiUqjd+LEMq3dnFKt1fDy5FXIoFQG6bceYcJ2rXXiA9QooP2Nfydt
	 6RneNLqD/Jvqw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-42321c8b8f5so191604fac.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 05:34:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YwIfST7Knww9oGr16R+McnId5ba+60pBuqp9xYzdtbYJBSm6USl
	7CcDzdELEJqoQ3Qy3qrCIKL8+988QSmsCopDsgL4tIA+AM0rn2MTDH0tIYEJSuP8GvIbqqEABXO
	KPJLczKqD+Nn3UQQGZWrjfn6AvMkiQTw=
X-Received: by 2002:a05:6871:ac04:b0:41c:92c:bd92 with SMTP id
 586e51a60fabf-4230e02dcecmr1522464fac.11.1775219662901; Fri, 03 Apr 2026
 05:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 3 Apr 2026 14:34:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hh83q-F1Y-13a_3-AopnRRmhM91FCnNrMrKYwjqAiJcw@mail.gmail.com>
X-Gm-Features: AQROBzB0pU6UWxBoCScK5wlEbjC8G3Qz8WvuBwdIeK5qRDsL9rmlWZ82AqshzHI
Message-ID: <CAJZ5v0hh83q-F1Y-13a_3-AopnRRmhM91FCnNrMrKYwjqAiJcw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v7.0-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.0-rc7

with top-most commit 744d5721d2d7abc84e5131c16002039c53465c89

 Merge branch 'pm-em'

on top of commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d

 Linux 7.0-rc6

to receive power management fixes for 7.0-rc7.

These fix a potential NULL pointer dereference in the energy model
netlink interface and a potential double free in an error path in
the common cpufreq governor management code:

 - Fix a NULL pointer dereference in the energy model netlink
   interface that may occur if a given perf domain ID is not
   recognized (Changwoo Min)

 - Avoid double free in the cpufreq_dbs_governor_init() error path
   when kobject_init_and_add() fails (Guangshuo Li)

Thanks!


---------------

Changwoo Min (1):
      PM: EM: Fix NULL pointer dereference when perf domain ID is not found

Guangshuo Li (1):
      cpufreq: governor: fix double free in
cpufreq_dbs_governor_init() error path

---------------

 drivers/cpufreq/cpufreq_governor.c | 6 +++---
 kernel/power/em_netlink.c          | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)
