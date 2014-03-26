From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/5] PM / Runtime: dev_pm_info.runtime_error is signed
Date: Wed, 26 Mar 2014 17:55:15 +0100
Message-ID: <20140326165515.GA23952@Nokia-N900>
References: <1395693091-4813-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56275 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbaCZQzV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 12:55:21 -0400
Content-Disposition: inline
In-Reply-To: <1395693091-4813-1-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On Mon 2014-03-24 21:31:27, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> dev_pm_info.runtime_error has always been a signed int, to store a signed
> error code. Correct the documentation.

Series looks ok to me.

Acked-by: Pavel Machek <pavel@ucw.cz>
