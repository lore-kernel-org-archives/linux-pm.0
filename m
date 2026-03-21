Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F702E9730
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090137; cv=none; b=SvkUTm75IQ+0X1nY0VmE04V8uk77V9+9WWAIf1ke4ScWqLuN+Lty50oS+c7dfG8SB3ilTXu/JTTg1TKqBeJxnxunkL8pf34yrjNq1w5ZzmZAwl7hKl848IXJcfMcaYGv0wvXgy76VmeLteUbrFA3pxOE3NjLcbg8hrRxuE+mEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090137; c=relaxed/simple;
	bh=8LZ+LwCB2G6X2Cb3caXyAckHHyX5CKVqVUFM9alh04U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmN75IJ6p3CplOlkqBUh9pdPwmpvhtHfvRtGu9f8W1vbDJtHh6WFjXYPy/gBMuX8b5P8dLnpISHmqk4Jt03f2Q5B+vBvOUYMT1yex6XX7K9maZXbqepW4tDGk2u/dhZ/vfSIIMm0/ggABp5ZDgvsNyVuaobwV+RrF913M//BYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 21 Mar 2026 19:48:50 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 21 Mar 2026 19:48:50 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com,
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 3/3] PM: hibernate: fix spurious GFP mask WARNING in
 uswsusp path
Message-ID: <ab53krr0y981Qyk8@yjaykim-PowerEdge-T330>
References: <20260320170313.163386-1-youngjun.park@lge.com>
 <20260320170313.163386-4-youngjun.park@lge.com>
 <CAJZ5v0gHTPCkVySAuPBkPoV=SwmBRG_c-TtPbz0CNsUUPEkY8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gHTPCkVySAuPBkPoV=SwmBRG_c-TtPbz0CNsUUPEkY8w@mail.gmail.com>

On Fri, Mar 20, 2026 at 07:20:24PM +0100, Rafael J. Wysocki wrote:
>...

Hi Rafael,

Thanks for the review. Sorry for the back and forth on this one.
I'm preparing to send the uswsusp GFP mask fix separately as you
requested (with _nowarn rename and lockdep_assert_held).

Before sending, I wanted to check on the approach. I originally
found this WARNING while testing uswsusp and thought it was a
localized issue. But AI review has kept uncovering more cases —
first SNAPSHOT_FREEZE + snapshot_release(), and now
dpm_resume_end() when dpm_prepare() fails. More callers than I
expected use this defensive restore pattern.

So I'd like your thoughts on the approach:

1. Introduce pm_restore_gfp_mask_nowarn() and update each caller.

2. Remove the WARN_ON from pm_restore_gfp_mask() itself, restoring
   the pre-stacking no-op behavior.

I'm leaning towards option 2. Defensive restores are an established
pattern in multiple paths, and warning against a legitimate no-op
seems counterproductive — we'd just be playing whack-a-mole with
_nowarn conversions as more callers turn up.

What do you think?

Youngjun Park
