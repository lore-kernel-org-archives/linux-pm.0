From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH][v5] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Mon, 12 Oct 2015 18:37:50 +0200
Message-ID: <20151012163750.GA4539@pd.tnic>
References: <1444533601-12330-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37458 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbbJLQiF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 12 Oct 2015 12:38:05 -0400
Content-Disposition: inline
In-Reply-To: <1444533601-12330-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de, hpa@zytor.com, rui.zhang@intel.com, luto@kernel.org, linux@horizon.com, dsmythies@telus.net, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, marcin.kaszewski@intel.com

On Sun, Oct 11, 2015 at 11:20:01AM +0800, Chen Yu wrote:
> A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=3D12272=
08)

I get:

"You are not authorized to access bug #1227208.

Most likely the bug has been restricted for internal development
processes and we cannot grant access."

> that, after resumed from S3, CPU is running at a low speed.
> After investigation, it is found that, BIOS has modified the value
> of THERM_CONTROL register during S3, and changes it from 0 to 0x10
> (thus changes the clock modulation from reserved to enabled),
> since value of 0x10 means CPU can only get 25% of the Duty Cycle,
> this triggers the problem.

Is this what the bug described above is? In any case, please remove the
private bugzilla link and describe the bug in text here.

Also, from reading the other thread about the v4 patch, it sounds like
intel_pstate can't handle the clock modulation properly, according to
what Doug says.

So let's have this aspect sorted out properly first please before addin=
g
yet another ugly BIOS workaround.

Btw, why can't that BIOS be fixed instead?

--=20
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--=20
