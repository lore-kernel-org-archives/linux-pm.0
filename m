Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA941161C;
	Thu, 26 Mar 2026 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546881; cv=none; b=k3okVaaMQf4lRY/be2pJGsdFPJqxaDMUa+w7hQ8bmXGM2gv9fr0qi8+G/GcN55ui8xu2aOXirDzOFxCeIhrhaJm/Pe4qD6eTNnsQq6LrCCnw97F4F4nmL3g/38nlrZmWI17wMPDQcBKYspcmXGDI4qx07up1BkUTYtkdfWsI/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546881; c=relaxed/simple;
	bh=rBsuuxlnC4tNmnv9nASiCcN40ygWyXtSgZ/iXOxv+Js=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=h9erLLbWe2NFrX20VRbY1ASzASOfp3jBzutACTOFcbgRiTx251J0J/Jj2wSWfWpyTrMxA4nh5chv5/nfKaPaGLJrb7lF1w3NB21+HcD4adb6qmpRWSuO02IoW3oNI3fNV+Xx4Odb62n/ixh6S8+UicOafUffIAU2p4YSSlWsdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VxagcaBg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VxagcaBg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QfjCYgBHef4+qbT3mHgWhjql7eq81Dz553JEN16x/iY=; b=VxagcaBgBslGCpzgvmuf3myl47
	15Hfu7WOdL7cUzPPU6pbXe4DorVPU3U0P2j5PWPbvQRoiG5UWwjWmsti52IpMbwIDrEAojTh5lbC4
	CvoXvP4XStWKVRZJIHU09d9P0xTr6e6ye4Q7rV5h38TxAM7UbmPuM44vC21IHnr/7ccJRvEkclRPl
	GtHtftpIjVd3/8lyt6/Pe7wo4l/qJs7lLnguIev4CXgp6IxWL6+8hHu6u5PT9vHiBKFpdM8BFDGM2
	ZkXO2NedPFXQJ5g/Kk6i3OZ3zJ60H+nMIcdc4k+zNU+13OMhq0hSvu9Zj4U/v3iWAC1t1JQu6dWIU
	lIJJ9xDw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w5ohc-006TKn-IM; Thu, 26 Mar 2026 18:41:04 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1w5oha-009MTZ-G1; Thu, 26 Mar 2026 18:41:04 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <mfo@igalia.com>)
	id 1w5oha-00B1Bw-04;
	Thu, 26 Mar 2026 18:41:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 14:41:02 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
In-Reply-To: <CAJZ5v0irL14vtz35zKF9ZPH8M1TN6i5mWkT2zQyB5d+LBPUXHg@mail.gmail.com>
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
 <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
 <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
 <772a77c80b6ad216dec4cc10d3fbb133@igalia.com>
 <52d861b9a215150424ae4d49b4e2c90b@igalia.com>
 <a61c19043dcf579e46f7d4f124013e60@igalia.com>
 <CAJZ5v0jcK0eg1fjSmMDDhTqNqFxUmhdNs=exs13nduRivCiLQQ@mail.gmail.com>
 <cce6cb6e12b09bc97cf684e378c874f4@igalia.com>
 <CAJZ5v0irL14vtz35zKF9ZPH8M1TN6i5mWkT2zQyB5d+LBPUXHg@mail.gmail.com>
Message-ID: <ec835b5edb43c220bf579981f875deb8@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Report: NO, Score=-4.7, Tests=ALL_TRUSTED=-3,AWL=-2.550,BAYES_50=0.8,URIBL_BLOCKED=0.001
X-Spam-Score: -46
X-Spam-Bar: ----

On 2026-03-25 16:29, Rafael J. Wysocki wrote:
> On Wed, Mar 25, 2026 at 8:22 PM Mauricio Faria de Oliveira
> <mfo@igalia.com> wrote:
>> 
>> On 2026-03-25 13:24, Rafael J. Wysocki wrote:
[...]
>> > I'd say that thermal_zone_device_unregister() needs to flush the
>> > workqueue before calling cancel_delayed_work_sync() to get rid of the
>> > stuff that may be running out of it that hasn't seen the changes made
>> > by thermal_zone_exit().
>> 
>> IIUIC, cancel_delayed_work_sync() has that effect: it waits for
>> (specific)
>> work that might be running and hasn't seen changes by
>> thermal_zone_exit()).
> 
> Sure, but you argued yourself that this didn't work if the work item
> in question had been reinitialized in the meantime.

Yes, if. To clarify: the above refers to cancel_delayed_work_sync()
behavior alone, not assuming a work item reinitialization (i.e., in
the context of the proposed patch).

> And I don't want to add another work item to the thermal zone
> structure just for the handling of suspend/resume.

That's certainly understandable.

-- 
Mauricio
