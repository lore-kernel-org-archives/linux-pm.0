From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Fri, 8 May 2015 02:41:11 -0400
Message-ID: <CAJvTdKnKT-9-QBsmsckBoYKa+758Gs5H7-+LMoHBdhMkatNA7g@mail.gmail.com>
References: <ce1b9fc9cdcfd1fe8f9f3b8570421271dc15ae75.1390460951.git.len.brown@intel.com>
	<20140126210850.GA7246@Nokia-N900>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:35925 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbEHGlN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:41:13 -0400
In-Reply-To: <20140126210850.GA7246@Nokia-N900>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Sun, Jan 26, 2014 at 4:08 PM, Pavel Machek <pavel@ucw.cz> wrote:

> Dunno. Config option plus sysfs attribute is overdoing it a bit.

Agreed.
Have discussed w/ Rafael, and current plan is to simply delete.
Updated patch on the way...

thanks,
Len Brown, Intel Open Source Technology Center
