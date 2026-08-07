Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256A4746D4
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105111; cv=none; b=H3j2nL+bthSlmfN+wxQH1euDA9xTewjSjH67saSTdSkuUuWrXyWGG+J6FOekPmBllbZwyVpCy6Rf4aZzkxnzetUk90e98+Luj9YPL5p3yMPPv1ztJVSuDMUqKXs6lg8Y5/S1NHUY9mEh00uwhlNGx04+IOLSmq2ALOQqYuEE02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105111; c=relaxed/simple;
	bh=1RfLulv0Yalv7dZEAHPEs/LNqXa6CD/nYO+ykdzTGss=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kzlPIWkd7PkeMFyvMHXFaUgqRIRTjLSYbc/gBHbLpxGZCqeejgEyyCID6DWCQ0rke2UPCIkXQIvaXeeSbpQyXnBgAGQX0k963kDaUIOoZXEGc81B+pCNDHdpTO70XKoGkbjiM9KHO+DPyT/FA9qJ9cql5nYvsQzRuZYcKGiTZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh/gV/PL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh/gV/PL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599C11F00ADB
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 12:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786105057;
	bh=x1gc9W8QYfMU+OcQbBecIT+wyGnPW2ow9/3MoyBjC90=;
	h=From:Date:Subject:To:Cc;
	b=Fh/gV/PL5lpWmCBFqvw+OPUfZ1/EkpBZ+dHH3Wr3ZHe9YLRoQ4CMYDrJbcbL8q6Hw
	 LpCS9OMMuvvBAKZQOtXeRKGiv7ugJyekzPxt8L79uTJaN2naFBTpeh/+b9cmW3QwF/
	 VL48SJJ5BXDM+3vGZq2H8hSmx4HRPicNUUdZc4Aq7W0+TImnsTRjptG764H6aBfiKE
	 TuJ8lvbxIjBP0E39+/SjqTj04o+wQ5kC14pxlaoBo7/4rmqUvw1Dq0g9P0HCvhBZWo
	 bUquisD1BhIQ8a3WF0mNCKP3EWRiF7/X/n8tH8aDppnIwnOZRLGyU2hUWEhnrh/ca8
	 EYDlksSeDNksg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b29599b81cso4196413e87.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 05:17:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YzqAYgUSJ7qeoDcSjJasUCtObUrQ677mmb9n00Bs8mdvF1+cJgI
	6osBIkB0T+mfjeLqYBlpxF1XEb23SoSQEo5xghe5h9aD4n2e6j03XaBea3n/mFXr1bDlKvn3TW/
	mDHVvjJzUrisI1/YzDPrZ8pw12Tw4HPM=
X-Received: by 2002:ac2:4553:0:b0:5ae:ae75:5c43 with SMTP id
 2adb3069b0e04-5b2f4cc7044mr2929123e87.49.1786105055849; Fri, 07 Aug 2026
 05:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 14:17:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jEYTmtFHHiR5+NELM-xbErnhtP1JzqOseYWGqA6nnZjw@mail.gmail.com>
X-Gm-Features: AUfX_mxKtLAgFZfjf4B4RE2kk1_tKnRGIXmSc3pIP15tG3yMNvwrGBxAUzAOq34
Message-ID: <CAJZ5v0jEYTmtFHHiR5+NELM-xbErnhtP1JzqOseYWGqA6nnZjw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for 7.2-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.2-rc7

with top-most commit ff8da20b6f47c48d46e47f93f7a59e2d56ee9107

 Revert "thermal/drivers/hwmon: Cleanup coding style a bit"

on top of commit f5098b6bae761e346ebcd9da7f95622c04733cff

 Linux 7.2-rc5

to receive thermal control fixes for 7.2-rc7.

These revert three thermal core updates, two recent ones and one older.

The recent ones attempted to fix a design issue in the thermal core and
simplify code on top of that, but they made changes visible to user space
and made it unhappy.

The older one is a misguided code cleanup that introduced a (potentially
nasty) bug.

Thanks!


---------------

Rafael J. Wysocki (3):
      Revert "thermal: hwmon: Use extra_groups for adding temperature
attributes"
      Revert "thermal: hwmon: Register a hwmon device for each thermal zone"
      Revert "thermal/drivers/hwmon: Cleanup coding style a bit"

---------------

 drivers/hwmon/hwmon.c           |   6 +-
 drivers/thermal/thermal_hwmon.c | 224 ++++++++++++++++++++++++++++------------
 include/linux/hwmon.h           |   3 +-
 3 files changed, 160 insertions(+), 73 deletions(-)
