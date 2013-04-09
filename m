From: Andrew Bresticker <abrestic@google.com>
Subject: Re: [PATCH] thermal: fix frequency table lookup bugs
Date: Tue, 9 Apr 2013 11:27:07 -0700
Message-ID: <CAL1qeaEbakXL1wpURSGDJ=_FojoJ7DO4CJtj+pwPh32fufwjDQ@mail.gmail.com>
References: <1365465287-24530-1-git-send-email-abrestic@chromium.org>
	<51642BD5.4030803@ti.com>
	<CAL1qeaGW=m+DNbGhEzTJBDt1NNpPrVcBzzWzhk447hf2tyb2fw@mail.gmail.com>
	<51644E22.1050305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:39369 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934896Ab3DIS1I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Apr 2013 14:27:08 -0400
Received: by mail-vb0-f54.google.com with SMTP id w16so4953744vbf.41
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2013 11:27:07 -0700 (PDT)
In-Reply-To: <51644E22.1050305@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

> You do two things in this change on cpu_cooling.c: (1) fix the case where
> the loop is kept running indefinitely. (2) Reserve a specific role for each
> index in this function.

So the issue is that the changes are not independent.  With just the
fix for the infinite loop, get_cpu_frequency() is still completely
broken because it is not interpreting the level correctly and will
return the wrong frequency (and thus not throttling correctly, which
is bad).  Perhaps the commit should be more general, like "fix
handling of invalid frequency table entries"?  What do you think?

Thanks,
Andrew
