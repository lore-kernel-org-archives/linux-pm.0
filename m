From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Wed, 22 Jul 2015 10:55:22 +0200
Message-ID: <1437555322.5445.2.camel@suse.com>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
	 <CAJZ5v0gNKRRaXvfqvj4YEjb+7X1aEobfvWuWyAnAcKArcxtZPA@mail.gmail.com>
	 <20150721151941.GA19581@amd> <7453812.eRsb3OQU2z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57486 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932481AbbGVI4b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 04:56:31 -0400
In-Reply-To: <7453812.eRsb3OQU2z@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 2015-07-22 at 03:25 +0200, Rafael J. Wysocki wrote:
> And it is more pain for me to change the user space on each of them to
> write to the new sysfs file on every boot than to set a kernel Kconfig
> option once.

So why at all? If you really need this in sysfs, why not write
something like "memfast" into /sys/power/state ?

	Regards
		Oliver


