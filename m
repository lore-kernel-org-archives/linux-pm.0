From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: [regression] Corrupted low memory after resume from suspend, starting with 3.11-rc3
Date: Thu, 21 Nov 2013 23:05:15 +0100
Message-ID: <1413632.CebWE94SKW@vostro.rjw.lan>
References: <20131121160916.69985889@rechenknecht2k7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62886 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754068Ab3KUVwf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 16:52:35 -0500
In-Reply-To: <20131121160916.69985889@rechenknecht2k7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Valentin <benpicco@zedat.fu-berlin.de>
Cc: linux-pm@vger.kernel.org

On Thursday, November 21, 2013 04:09:16 PM Benjamin Valentin wrote:
> Hello,
> starting with Linux 3.11, resuming from suspend leads to corrupted low
> memory on my Gigabyte 965P-DS3 board. As a result of this, the ethernet
> interface won't come up again/the display doesn't turn back on after
> resume.

Do I understand correctly that this is about suspend to RAM?

> I've used Ubuntu's mainline builds for convenience and 3.11-rc3 is the
> first revision to exhibit the issue. However, 3.11-rc1 and 3.11-rc2
> will fail to suspend entirely. With 3.10, no memory corruption happens
> and the system suspends just fine.

Could you find (using bisection) the last kernel between 3.10 and 3.11-rc1
that both suspended and resumed correctly and did not corrupt things for
you?

Rafael

