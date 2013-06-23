From: Joe Perches <joe@perches.com>
Subject: Re: [PATCHv v3] power: Include additional information in
 pm_print_times
Date: Sun, 23 Jun 2013 03:16:30 -0700
Message-ID: <1371982590.3137.32.camel@joe-AO722>
References: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com>
	 <2168940.loyeqX9NTF@vostro.rjw.lan> <1371981811.3137.25.camel@joe-AO722>
	 <1502403.DSSBonEtkF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:37007 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750925Ab3FWKQb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 23 Jun 2013 06:16:31 -0400
In-Reply-To: <1502403.DSSBonEtkF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shuah Khan <shuah.kh@samsung.com>, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Sun, 2013-06-23 at 12:22 +0200, Rafael J. Wysocki wrote:
> On Sunday, June 23, 2013 03:03:31 AM Joe Perches wrote:
> > On Sun, 2013-06-23 at 12:07 +0200, Rafael J. Wysocki wrote:
> > > On Saturday, June 22, 2013 06:05:50 PM Joe Perches wrote:
> > > > If any script needs something stable it should
> > > > depend on information available through other
> > > > sources like trace or proc or sysfs.
> > > 
> > > That is clearly impossible in this particular case, though.
> > 
> > Why couldn't this printk be converted into an equivalent tracepoint?
> 
> Well, why wouldn't you try to do that?

Why should I?



