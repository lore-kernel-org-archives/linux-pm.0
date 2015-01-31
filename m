From: sriram@marirs.net.in
Subject: Re: [PATCH] cpupower Makefile change
Date: Sat, 31 Jan 2015 21:25:08 +0530
Message-ID: <1422719708.1730366.221354493.64801DED@webmail.messagingengine.com>
References: <1419266857.3837604.205784097.7B0DB495@webmail.messagingengine.com>
 <2471771.a0lNGTTV6e@vostro.rjw.lan> <1889623.OtveQTWjnB@linux-oxht.site>
 <1507100.yAl4IVGJms@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60415 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751244AbbAaPzJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jan 2015 10:55:09 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id BA8DF208C5
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2015 10:55:08 -0500 (EST)
In-Reply-To: <1507100.yAl4IVGJms@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org

Thanks. 

On Sat, Jan 31, 2015, at 04:38 AM, Rafael J. Wysocki wrote:
> On Friday, January 30, 2015 01:27:23 AM Thomas Renninger wrote:
> > On Friday, January 30, 2015 01:13:09 AM Rafael J. Wysocki wrote:
> > > On Monday, December 22, 2014 10:17:37 PM sriram@marirs.net.in wrote:
> > > > The cpupower tool, when compiled against libcpupower.so fail's to run as
> > > > the linker file path's are missing during compilation. So added changes
> > > > in the Makefile to run cpupower tool, which helps us run the tool
> > > > without doing a 'make install'.
> > > > 
> > > > 
> > > > Signed-off-by: Sriram Raghunathan <sriram@marirs.net.in>
> > > 
> > > That requires an ACK from Thomas for me to apply it.
> > 
> > Makes sense.
> > 
> > Acked-by: Thomas Renninger <trenn@suse.de>
> 
> OK, queued up for 3.20, thanks!
> 
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
