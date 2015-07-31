From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM build-time optional
Date: Sat, 01 Aug 2015 01:57:44 +0200
Message-ID: <1549900.RSMcUBBPG7@vostro.rjw.lan>
References: <1438361177-23201-1-git-send-email-lenb@kernel.org> <674dcf60fc85324b41479fcec930d64126c09fb1.1438360540.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43747 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753287AbbGaXaq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 19:30:46 -0400
In-Reply-To: <674dcf60fc85324b41479fcec930d64126c09fb1.1438360540.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Friday, July 31, 2015 12:46:17 PM Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> The Linux kernel suspend path has traditionally invoked sys_sync()
> before freezing user threads.
> 
> But sys_sync() can be expensive, and some user-space OS's do not want
> the kernel to pay the cost of sys_sync() on every suspend -- preferring
> invoke sync() from user-space if/when they want it.
> 
> So make sys_sync on suspend build-time optional.
> 
> The default is unchanged.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

OK, I'm replacing your previous sync patch with this one (modulo some minor
changes in the help text).

Thanks,
Rafael

