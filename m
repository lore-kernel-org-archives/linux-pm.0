From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpupower Makefile change
Date: Sat, 31 Jan 2015 00:08:32 +0100
Message-ID: <1507100.yAl4IVGJms@vostro.rjw.lan>
References: <1419266857.3837604.205784097.7B0DB495@webmail.messagingengine.com> <2471771.a0lNGTTV6e@vostro.rjw.lan> <1889623.OtveQTWjnB@linux-oxht.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57877 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754195AbbA3Wpo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 17:45:44 -0500
In-Reply-To: <1889623.OtveQTWjnB@linux-oxht.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: sriram@marirs.net.in, linux-pm@vger.kernel.org

On Friday, January 30, 2015 01:27:23 AM Thomas Renninger wrote:
> On Friday, January 30, 2015 01:13:09 AM Rafael J. Wysocki wrote:
> > On Monday, December 22, 2014 10:17:37 PM sriram@marirs.net.in wrote:
> > > The cpupower tool, when compiled against libcpupower.so fail's to run as
> > > the linker file path's are missing during compilation. So added changes
> > > in the Makefile to run cpupower tool, which helps us run the tool
> > > without doing a 'make install'.
> > > 
> > > 
> > > Signed-off-by: Sriram Raghunathan <sriram@marirs.net.in>
> > 
> > That requires an ACK from Thomas for me to apply it.
> 
> Makes sense.
> 
> Acked-by: Thomas Renninger <trenn@suse.de>

OK, queued up for 3.20, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
