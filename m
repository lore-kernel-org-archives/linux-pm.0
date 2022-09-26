Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB793C32771
	for <linux-pm@archiver.kernel.org>; Mon, 26 Sep 2022 14:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiIZOyL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiIZOxr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 10:53:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF36BCF2
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 06:20:11 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664198409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YmVnhGToCy+VRj+NQyYrvgzUMHmw4i9NGtyMuNFyRHI=;
        b=h/XVZm0Dj31kK+T5h9/5591/FRe0Yf6V9pqban7z8y3h4sg9r5VGmxP1vXKeszHN+Ip7QU
        /FOefRFx2OzLOWzf1ZovRFhpiIJLkYKW/CcBFGvy2HZhD/waiHYJpU8v8FyrQ3KkZdtdv5
        vYlsH3HP4SymPK9U7Rl7ahOYl9ThPy5qtzKJQyY8N1RApwisXVuQXRWrQb/DVA8GcXWOmw
        FxrZtxn7rmTapTdk55WwxtUPxgGLgob+1UTwb1NTSK2hcUaqwaMZTNI//k5flcOACm2lAl
        VEHIDH6msxwDEKcK2VvM6yz1AsF2fIy0KAREmbgiykE3OhKVbRr6ZGn9b4KeAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664198409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YmVnhGToCy+VRj+NQyYrvgzUMHmw4i9NGtyMuNFyRHI=;
        b=05o60VFoq0kgyBarIj61IUG0YUT3TMH9ts4/7iu83gNNGT25wKUjRAtMoUohweugVY/547
        ARNpOk0bWtZVn4Bg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     linux-pm@vger.kernel.org
cc:     rafael@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: cpufreq - powernv driver
In-Reply-To: <4c99f34b-40f1-e6cc-2669-7854b615b5fd@linutronix.de>
Message-ID: <12f6625f-bd93-80c2-3a8c-19c63f49ea10@linutronix.de>
References: <4c99f34b-40f1-e6cc-2669-7854b615b5fd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ping?

On Mon, 27 Jun 2022, Anna-Maria Behnsen wrote:

> Hi,
> 
> during my work on a timer hierarchy I stumbled over powernv cpufreq driver
> which is using a timer which is deferrable and pinned. This is the only
> timer in kernel which uses this combination and I would like to get rid of
> it.
> 
> Only removing the pinned or deferrable flag could not be the proper
> solution, right?
> 
> I'm not familiar with cpufreq. I was wondering if it's possible to rework
> the powernv cpufreq driver to use cpufreq infrastructure instead handling
> it's own timer for ramping down? I would be happy if someone could help me
> with some pointers how this could be solved.
> 
> Thanks,
> 
>       Anna-Maria
> 
