Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58F3C6600
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869908; cv=none; b=T3WPYQe15BmhE8oxdQUGh9xpoNZHQ0/Ne5E45Ije2pty6JsfCB2qVOX0UYPJIlgxrYSliutOHawFY1WwMkl82PgLIX2YQaYOdqHg7IqmoByc+ZwJnB0C+6FJ1g5Tx6jVwKmbYwK9wN83UONRpmzAEL1Z4y5ZemIo26nVakjuBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869908; c=relaxed/simple;
	bh=OF2UpoVYoX410mc1SzzOypl8KSOO/KvZWjbPCC/0g54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbHpBr9ccc536keo9+OAOyqxpevVbie+UWzZsAO+KOwJLXEPgvqOIQddC5brIP8FU2U0oo9PGMl2i6ma2gD/flVqQuu46oePa7SMYww9+7P0hvvI77My7pDs6JWXuFcnNkhVMh+0jtSHa0DIbZ6txSBw4qMsQD9wz8PtRsHQVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AhPM8Lsb; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AhPM8Lsb"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso3363097eec.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790869905; x=1791474705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SSVxD8Q50vKAGJw1dPQdeHHdj1MbKb779CFMeOXNtI=;
        b=AhPM8LsbVad94+zbA2lzdNWS7cmrAbRUZUTKHYSpn8ECtOWLh9wZbr7OuEMpN/17pE
         aRReW2uAR4S6ND238PjWx6eipDWIOFMrhFgQc2BymCAr5d3/rN5rLz9SbPHAMEAMtee+
         mGz/oZFaPmkBXU2f78UHQaXLOxS2r21eW/3No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869905; x=1791474705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SSVxD8Q50vKAGJw1dPQdeHHdj1MbKb779CFMeOXNtI=;
        b=lJBpCl45afRM5wm07Q7PwQHyNzWd9OBKKV+1iTdmAMqcvMjVfzBnfMF4lr0uhxseim
         kpy11mOOlmVubrmnBYfsV/UevUHT8aNQ8mK9wp9ZtjvcB8MDMfDvqjwACzESAGIReD6Y
         HO9b6dUbK8/zTEtPk7qdXnYhTdib6lY/mB/YMijTkj8m3pUd6r0oqEtzJ9GKn9tuCpo8
         dwcl+a5jC61iiEAAbHRVWNoQAG44ZKeWg9aDOm0N77qC6gWuDToL2R33u+jbN905JYxA
         lUz+dw1PBfuFgNCMspkbuLz4ad9P/KdlT1XAzpIAvI7mD17dRJaNY8fw/fQuzFJGqMzD
         PcPA==
X-Forwarded-Encrypted: i=1; AKwUvByIh1OMPA9rxDcjsquc5jlhGyD5Ud8JYBPnMxs7BFeaP2PbYKwtZbARsj0k3OCACntOp/pp8gceEQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK5NGMlc1kTjEeGjoGLVjC8qzKR524LUy+kWvB/ZSRAoMXWE7Ig
	7UIHeDBzWPp7ZPaXwLwiA1UMfKKub+TpbckMiooHP/sfP74a5Ab+Krdxj0HxIXFVPw==
X-Gm-Gg: AYBFou1+2vyK/bEJA8LDfTwlnV3pqo6NdXg3HWFjyU7cRunOsC6PR4+Twf37dVxxzoV
	kt0FOfSGkUTXIxPn9K9x2O6stXzHOn2rGUnlMFyHS2j4hUyW0/nOtIrChrEswgp3LzN48KkmC+t
	pLaTU4cb125Q0t1wC4M0MxhiOubbWPRq+t/QmvMMnuJSTF/RbRndm0BW6L7ViE+WDxmvdT7I4mM
	WwwR+SEJ7Hi8ALDwpCBMsxufi1OXkhj8mIS68c0nUsHNwGJzFGCdD7qNZ68oo2AiRm2sP7eT1F6
	teGF6pxBWT1FAJwwnvgWDONS/TuIWED7IsGbHAS22t2GMiRuGVEEWuFcC5hjI2JPELBxcuAJANI
	w0PQ/zcmgU3q9TOwXmpTEMUsblhdf7pd0WKph67FbnSeeDD0n5PVqRh9fWMjo7nFJIeRkJwo/wu
	QHbNeK4QxmFqImpmEXWp2GVhHZ3cg/9M3b31tQ008WRdd1lE8WPzYZbdipln17HFxpYbYyHIHC8
	lzSal4MwHczj/hzmQkZWoGml87d4BfB72LoPz8=
X-Received: by 2002:a05:7300:b2af:b0:34b:354b:79b9 with SMTP id 5a478bee46e88-34cdbadb190mr5134704eec.12.1790869890202;
        Thu, 01 Oct 2026 08:51:30 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:7cf1:ee59:f140:7be9])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34db3750765sm7796452eec.12.2026.10.01.08.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 08:51:29 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Len Brown <lenb@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 0/2] PM: runtime: Overhaul kerneldoc, runtime_pm.rst docs
Date: Thu,  1 Oct 2026 08:50:07 -0700
Message-ID: <20261001155118.1750028-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime PM documentation could use some improvements and additions,
to help guide people less familiar with the main runtime PM concepts and
its internal implementation details.

v1 is here:
https://lore.kernel.org/all/20260904212000.4167880-1-briannorris@chromium.org/

v2 is here:
https://lore.kernel.org/all/20260923174711.1283986-1-briannorris@chromium.org/

v3 is here:
https://lore.kernel.org/all/20260930025044.104824-1-briannorris@chromium.org/

Most of the v1-v3 series has been applied already. For the remaining
work:

 - Clarifying core concepts in the Introduction. (Pretty much all new
   readers I encounter have a hard time with the difference between
   "enabled", "allowed", and "active".)

 - Adding Example driver patterns -- because the API is so large and
   complicated, it can help to try to walk people through standard
   practices, and what everything means in context.

Feel free to add suggestions! Within reason, I'm open to tackling more
here, as I think many people have many valid perspectives on exactly why
and how the docs do or don't serve people well today. Or I can tackle
less, if you think some of my choices are not improvements.

Some possible follow-ups I'm toying with:

 * Slimming down the API might be better than heavily documenting it. A
   smaller API is a more digestible API.

   My only concrete next step: drop __pm_runtime_put_autosuspend(). Its
   last user is nearly gone:
   https://lore.kernel.org/all/20260806-smmu-rpm-v4-1-8183d007331c@oss.qualcomm.com/

   I could also see deprecating one of
   pm_runtime_put_sync{,_suspend,_autosuspend}(). They all do slightly
   different things, but I'm not sure every difference is actually fully
   intentional (or at least, not necessary).

 * Tweaking some of the behavior on pm_runtime_barrier(). Today, it's
   very asymmetric, as it prefers resume. But I believe there may be
   value in making it flush (not just cancel) pending suspend too. That
   may be in a future proposal; for now, I just try to make its
   asymmetry more clear in the docs.

 * Sand down some more rough edges on return codes. For example, it's
   very difficult to get any useful meaning out of pm_runtime_put_sync()
   return codes. There's a high chance that anyone trying to treat
   return codes as errors is inviting bugs. (Is -EAGAIN a failure?)

   Of course, the answer there is not "document it better" -- we can
   make it easier to use.

 * Adjust the way devm_pm_runtime_enable() works, specifically for
   remove()/teardown. Currently, this is very hard to use correctly --
   some common driver patterns may assume that a device will tear down
   while RPM_SUSPENDED; but that's not actually guaranteed. Notably,
   this makes some of the "Examples" section fairly tricky/subtle.

Regards,
Brian

Changes in v4:
 * Significantly overhaul introduction, based on Rafael's
   feedback/rewrite
 * Drop most implementation details (struct fields) and API names from
   intro
 * Expand the "in use" and dependencies concepts in the introduction

Changes in v3:
 * Rewrite Examples to avoid devm_* at first, to highlight correct
   approaches
 * Include error-handling and remove() in any probe() Examples
 * Advise more caution when using devm_*, as ordering issues are subtle

Changes in v2:
 * Major rework on Introduction section, especially regarding "enabled"
   and "active"
 * Add appropriate teardown to "Probe with Hardware Powered Off"
   Example, as the remove() + power-off behavior is subtle here, and
   easy to get wrong
 * Drop changes that are already applied
 * Add a few new fix patches, noticed while reviewing the rest
 * Move Introduction patch near the end of the series, as it is a likely
   target for further discussion and modification.
 * Correct Ulf's email address
 * CC linux-doc

Brian Norris (2):
  PM: runtime: Expand introduction with core concepts and structure
  PM: runtime: Add Example Driver Patterns section

 Documentation/power/runtime_pm.rst | 589 ++++++++++++++++++++++++++++-
 1 file changed, 568 insertions(+), 21 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

