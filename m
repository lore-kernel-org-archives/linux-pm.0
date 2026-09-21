Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E00515997
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025513; cv=pass; b=QaT6urPQjtFmRtzijNt90oiAL26bwVWPGTKrDOkHdETrKl8Vzi5N9qeAkMqRNlWT+R0+m0zYlLEJ4+H48mz3RTPhuiVPSToc1/8dR+m8cO6Wxq9A21TA2Ft/rQnQqAZmBRmws8kEitWjLmESDVk/NzgAtmB5pY9a0iLXmSBv7kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025513; c=relaxed/simple;
	bh=brjRvH3C6Mu55blpnUj4kyKWqBF3ChBISvnfSPmnR7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIPr6GyUvLGbs6dyZqfUhLgNTT/E3k8EgTHOXwT9e1450VkGwB6x+TUPLtTLx2aG4N5cYWC/cpWSO76PIdljoi0/qukpSbr50KIlqLmv8DY3A02/3//JKHpVE9+81g1e0WEGBGiWFc96rQxhvHUvOk0n5fBIEtYhjQlCwhrVgr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJkJFPIs; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJkJFPIs"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so3015056a91.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 14:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790025512; cv=none;
        d=google.com; s=arc-20260327;
        b=Pl6pG6M62sZHLABjClK+9Hr4KvWAmFPfVICD7TvpseJQO9XiNrks1Yy8gLlK+/HQhL
         SmU+WP5qxj+wh37ZywLcK6Ag0a0hCW33q+NyXMEfkUlVZBYEFeMHvCKpKOt5CicM/r1V
         B+kaVL3cwxIEzX/L/Ts6Zh4mWanNG20xWW9HSFvWVtCeDF0v8i0Y8RqbDbax6XIOwbjP
         3NNjS9E2aqhRHONmoWB4cs8sRgMcShKPAHOPo7D9SzR2vr5LJYQMYnRAd2DpSFpJHnKT
         zlQiZ/0fbYx66QSjljoCtaVg0d6XAAVeP+t9aaA5BtQxlyS9g2cASBdRxSjM9ZJbAymW
         2TVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=brjRvH3C6Mu55blpnUj4kyKWqBF3ChBISvnfSPmnR7w=;
        fh=GbTujBhJceRh+K/c8gqTaVjg5WpLyR2yqYqqvjQqitM=;
        b=EelAIP3bwET52RAZEUjwMwF5rhTKpTxwJxk2g648eJ+YzvbRx97UseN73odGP95lOA
         N2jrBuSFLSVq71gpUbswROMXIzB9IsVdvWHGfh2vn9GHLLZt3QObgcV0kS3bbav0TnIQ
         MTGdr3CF1uQTj8BIXCWbePnAz5iJWpkHVf+I5FO9fQY5f3cQoa2fjxw2Jbsu683F/+4L
         XQocmXBqiNE+e9156pTW0mhvWOqjB88YBPU4dPyEGDZXVJJ2HI05T9mVtykSubPTJvPP
         DxYIM/qPnOPA6JwPbPDWZOoZagkhvhcuee/DswOGWxWgqhwkCVirUI2OagwZv91B0wax
         cKHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790025512; x=1790630312; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brjRvH3C6Mu55blpnUj4kyKWqBF3ChBISvnfSPmnR7w=;
        b=gJkJFPIs3HaVk5EWl09Y7xPXWILS8ig9j9JL/g9NI5d04UM5g+fEe840fDcHyGRFT1
         ehEYDxw4VjLK3Tt1ovC3+j/oePUFdhWbgszlvvfEmevhAjwT+AQ4kWNv+ldfpt+YcWon
         40Ul3IfIrCI+4y1TmR8m19Xqm04jMTABMtw0RsVveuHZDe9WRiv4Hg+WWVVMESbGD6aj
         CRHLBaWWDdE/ybO6LYMyUZYFCUYVoN/8I4huiKMhG/2/4RZqpLlS2se9+6H6bSW+jFkF
         qvU+k/waT7tt87MSAxAdFG48r8CsaAo6PMmaj2TUaYtwhtatmiZ/RQ2pj4fFXUJ11MuZ
         XwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790025512; x=1790630312;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=brjRvH3C6Mu55blpnUj4kyKWqBF3ChBISvnfSPmnR7w=;
        b=uBua6q/bPBi7+oXhMFxfwwNuliInQQNHcM+JSZ3fhmDWwlcInPek1qS5ofbUxAhTkt
         KgHssZ1XJ0iJYxJEtG4k3sNvHQLjlWx9z9zU+lol6j8voRaHINKSzpdRHAT1Uwx2Zlg0
         DI7Vyyk8zGu4gdP9MbupmFvU6icWBREsnOYgPXfWMUVJVnA/9JbHJ/WfP1JGUHV71gAP
         YQn3h5IEfxzL1D15WzQlQ+3APM84u85al+55UGe2gdGoCTbnKLlbB5hpNe2V8nXPQhGv
         NTG/T9RbWurhgqSBu4FDgP1wZikwWSfVfTA+xphXiBR3xPv1Gh7yaA8QgTdUWgVSqqCh
         IfAg==
X-Gm-Message-State: AFuF++m0A5Xx2FzznQmJN0x1V+k4l/kaz5c5nHuTuN801BxaQK24gXcn
	LrbuYib/s1MN22Qkch3zwHXa3tArBoaXYIaV95BvhjNbxvHgbEfEWmKxBMikRevBUidcGuyy2bO
	+cnJaaRy/KYRunmvMJ/pCxBXeWzWBhdY=
X-Gm-Gg: AYBFou3HJ8SJTdq+peryJxB1722TXx6gOkom39inQeLixshOAxUR/+Gny+pQzLFFBD0
	K9r8IPVCViSeqyjn7d9y64rs5zntct3rRq4TdZjcEpiXcNciBBmaWpxJR2XdWCQ7LNhjUng8uKX
	Yu9snePKehdRCo1lHtbcFeJz8zDtrL1HGQlP9s2KGXDGSFTDV/6PIY2C0Mausxi/fzaywTxicmv
	xeMvcrHxcCaS1/c/Cj8f74kz2MOExRVlFDMV8jbDLOG+a63CBEFTA8MNTYH0lXeyr7p6Xh9udOZ
	kb88mxvz3F2hUSpaDQQwOFm/AYq9sKE/NdF3KEQ0W2p/CWUqLtVMlA==
X-Received: by 2002:a17:90b:2809:b0:39e:4c7f:8b15 with SMTP id
 98e67ed59e1d1-3a06ae45c96mr221446a91.26.1790025511678; Mon, 21 Sep 2026
 14:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjEBWT9wyBYtWPgtg8Xd_FxRU_XnatzQMcwMB9_P2Fdj83+cQ@mail.gmail.com>
In-Reply-To: <CALjEBWT9wyBYtWPgtg8Xd_FxRU_XnatzQMcwMB9_P2Fdj83+cQ@mail.gmail.com>
From: Hic Haec Hoc <h.haechoc@gmail.com>
Date: Mon, 21 Sep 2026 23:18:20 +0200
X-Gm-Features: AcwNN1XDR3liA0aUKbpLmsIaVZiCpdO_7eTgmIqmdYIp2_7ENPKfCo1bzTJtA7k
Message-ID: <CAKp=m=DkRA3FQdJC+1AKDtn1X8ZuO0HRF5H7PJVf15uQyBuEbg@mail.gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: David Lomas <david.s.lomas@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	matthew.leach@collabora.com, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev, 
	Florian Schmaus <flo@geekplace.eu>
Content-Type: text/plain; charset="UTF-8"

On 9 Saturday 19 Sep 2026 at 22:53 David Lomas <david.s.lomas@gmail.com> wrote:
>
> Same commit, same symptom: my report with the blocked-task backtrace
> is at https://lore.kernel.org/all/CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com/
> (XPS 13 9360, 8 GB, zswap). The hibernating task sits in
> throttle_direct_reclaim() waiting for kswapd, which
> freeze_kernel_threads() froze just before
> hibernate_preallocate_memory() ran.
>
> #regzbot introduced: 783c8109844503bd1c35dab41b6d5fd074a9f131
>
> David

Hello,

I'm replying to this message because I was not CCed on the later ones.

I can reproduce the issue quite reliably on this machine, and with
Florian Schmaus's patch applied on top of 7.2.5 it survived ten
hibernate/resume cycles under significant memory pressure without
hanging. I can't tell if it could reintroduce the problems that
783c8109844503bd1c35dab41b6d5fd074a9f131 was trying to avoid but at a
minimum it seems to fix this particular deadlock.

Best regards,

H.
