From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Q: acpi-cpufreq module auto-loading after processor driver change
Date: Thu, 6 Jun 2013 16:09:47 -0700
Message-ID: <20130606230947.GA31618@kroah.com>
References: <1511440.Xd41mcOoEa@vostro.rjw.lan>
 <5836546.v3RJP00CT7@vostro.rjw.lan>
 <20130606222113.GA9271@kroah.com>
 <3155099.bCeEkuSrim@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54504 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab3FFXJs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2013 19:09:48 -0400
Content-Disposition: inline
In-Reply-To: <3155099.bCeEkuSrim@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Jun 07, 2013 at 12:44:44AM +0200, Rafael J. Wysocki wrote:
> So far I have verified that topology_init() is executed before acpi_init()
> (which appears to be pure coincidence, but oh well), so even the *ordering*
> is the same as before.  The only difference is that the device in question
> now has a driver bound to it and it didn't before (the driver was bound to
> something else).
> 
> Hmm. I suspect udev just thinks "ok, I have found a driver for that device,
> so I don't need to look for one any more" and that's why it doesn't load
> acpi_cpufreq.  If that's the case, is there any way to make it load all
> matching modules anyway?

udev should call modprobe with an alias for the device which _should_
try to load all modules that match the alias.  So take a look at kmod to
see if something is odd there.

sorry,

greg k-h
