From: Joe Perches <joe@perches.com>
Subject: Re: [PATCHv v3] power: Include additional information in
 pm_print_times
Date: Fri, 21 Jun 2013 19:27:22 -0700
Message-ID: <1371868042.2086.0.camel@joe-AO722>
References: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com>
	 <2534796.mOHH0DCD2A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:56118 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754394Ab3FVC1Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Jun 2013 22:27:24 -0400
In-Reply-To: <2534796.mOHH0DCD2A@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shuah Khan <shuah.kh@samsung.com>, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Sat, 2013-06-22 at 02:24 +0200, Rafael J. Wysocki wrote:
> Namely, there are tools that use these messages to create suspend/resume time
> charts and they will stop working after the proposed changes.

dmesg output isn't guaranteed to be stable.


