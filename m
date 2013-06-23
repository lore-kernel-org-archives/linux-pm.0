From: Joe Perches <joe@perches.com>
Subject: Re: [PATCHv v3] power: Include additional information in
 pm_print_times
Date: Sat, 22 Jun 2013 18:05:50 -0700
Message-ID: <1371949550.3137.16.camel@joe-AO722>
References: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com>
	 <2534796.mOHH0DCD2A@vostro.rjw.lan> <1371868042.2086.0.camel@joe-AO722>
	 <2732229.sfB5fHUFTc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:37896 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751775Ab3FWBFu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 22 Jun 2013 21:05:50 -0400
In-Reply-To: <2732229.sfB5fHUFTc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shuah Khan <shuah.kh@samsung.com>, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Sat, 2013-06-22 at 21:52 +0200, Rafael J. Wysocki wrote:
> On Friday, June 21, 2013 07:27:22 PM Joe Perches wrote:
> > On Sat, 2013-06-22 at 02:24 +0200, Rafael J. Wysocki wrote:
> > > Namely, there are tools that use these messages to create suspend/resume time
> > > charts and they will stop working after the proposed changes.
> > 
> > dmesg output isn't guaranteed to be stable.
> 
> So?

So even if new information was only appended to
the existing line, the script could break.

If any script needs something stable it should
depend on information available through other
sources like trace or proc or sysfs.

Tools that use dmesg should adapt to whatever gets
thrown at it and handle the output from whatever
kernel versions the script supports.

For instance, what happens to the script when
console_level is set to 1?

Requiring that no one can change a dmesg to
add or improve the content for readability
or intelligibility I think unreasonable.


