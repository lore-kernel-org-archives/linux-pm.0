From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: -next: no resume from suspend
Date: Mon, 14 Jan 2013 13:56:51 +0100
Message-ID: <16191961.j5ydKsJ3d3@vostro.rjw.lan>
References: <50F3D9E8.6040802@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40452 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556Ab3ANMvC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Jan 2013 07:51:02 -0500
In-Reply-To: <50F3D9E8.6040802@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Monday, January 14, 2013 11:11:52 AM Jiri Slaby wrote:
> Hi,
> 
> since friday's -next (the last known to be working is the last monday's)
> I cannot resume from suspend. The last thing I see with
> no_console_suspend is:
> i915: No ACPI video bus found
> 
> But I used to see the message always, so this is no difference. Any idea
> before I start bisecting?

Well, what's the next message you normally see with no_console_suspend?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
