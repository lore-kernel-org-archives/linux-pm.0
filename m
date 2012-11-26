From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/8] patch cpupower_ivy_bridge_support.patch
Date: Mon, 26 Nov 2012 21:49:20 +0100
Message-ID: <2861427.bmEteVGXpd@vostro.rjw.lan>
References: <1349788867-65962-1-git-send-email-trenn@suse.de> <3559687.YhYd0sZzjh@vostro.rjw.lan> <201211261646.16882.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:33822 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756271Ab2KZUoh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 26 Nov 2012 15:44:37 -0500
In-Reply-To: <201211261646.16882.trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, cpufreq@vger.kernel.org, linux@dominikbrodowski.net

On Monday, November 26, 2012 04:46:16 PM Thomas Renninger wrote:
> On Saturday, November 24, 2012 10:49:52 AM Rafael J. Wysocki wrote:
> > Please add (1) a useful subject, (2) a changelog and (3) a sign-off tag.
> Sure, sorry about that.
> But be careful, this one is wrong:
> 
> > > +	case 0x2D: /* SNB Xeon */
> > > +	case 0x3A: /* IVB */
> > > +	case 0x3D: /* IVB Xeon */
> It's family 0x3E
> a copy and paste bug that has been taken over from
> turbostat, there it already got adjusted from 0x3D to 0x3E.
> 
> I resend the whole series today or tomorrow.

OK

Should I drop the current one for now?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
