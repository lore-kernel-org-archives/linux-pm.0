From: Aaron Lu <aaron.lu@intel.com>
Subject: commit 70fea60d888d caused s2ram regression with WD disk
Date: Mon, 15 Jun 2015 10:55:36 +0800
Message-ID: <20150615025536.GA26473@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63674 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907AbbFOCye (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 14 Jun 2015 22:54:34 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Mark Scott <markcscott@talktalk.net>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi,

As explained by Takashi:
"
So this looks like the cause.  The recent kernel has a watchdog for
async resume workers, and if it expires, it panics.  This explains why
3.12 worked; the watchdog was introduced since 3.13.

The timeout length is unfortunately fixed in Kconfig, set to 12 as
default.  And this seems too short.  We should extend this to at least a
minute, I suppose.  Also, it'd be better to be dynamically
configuratble.
"
https://bugzilla.opensuse.org/show_bug.cgi?id=934397#c5

The upstream bug page is here:
https://bugzilla.kernel.org/show_bug.cgi?id=91921
Since Benoit isn't registered there, I write the email for discussion.

Regards,
Aaron
