From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 3/3] platform/wmi: Expose the raw WDG data in sysfs
Date: Tue, 1 Aug 2017 15:06:43 -0700
Message-ID: <20170801220643.GG3110@fury>
References: <cover.1501601667.git.luto@kernel.org>
 <2014962.u6moyPZATx@aspire.rjw.lan>
 <20170801213618.GL25574@pali>
 <2674627.ID8AtCtKmZ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45835 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbdHAWGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 18:06:45 -0400
Content-Disposition: inline
In-Reply-To: <2674627.ID8AtCtKmZ@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Aug 01, 2017 at 11:32:41PM +0200, Rafael Wysocki wrote:
> On Tuesday, August 01, 2017 11:36:18 PM Pali Rohár wrote:
> > On Tuesday 01 August 2017 23:20:10 Rafael J. Wysocki wrote:
> > > No evaluation of AML methods from user space, please.
> > > 
> > > This is plain dangerous, because you never know what those things do and doing
> > > that on production systems is just a plain "no".
> > > 
> > > You can, however, expose the output of AML methods this way or another,
> > > for example if they are expected to generate packages of data or similar.
> > > 
> > > The interface for that cannot be "evaluate this random method right now and
> > > give me the result", though.
> > 
> > It is not a random AML method. It is _WDG buffer which wmi.ko already
> > reads + parse (IIRC only once when doing initialization) and purpose is
> > to provide copy of this buffer also to userspace. Similarly like
> > wmi-bmof.ko provides MOF buffer.
> 
> OK, then.
> 

Specifically, _WDG is a method which evaluates to a buffer [1], and it is this
buffer which Pali would like to see exported via sysfs.

This data block provides a description (array of structs) for each data block,
event, and control method provided by the WMI GUID. Each includes a 2 char ID,
and this ID and data type provide the mapping needed to identify the
enable/disable and control ACPI method names.

1. https://msdn.microsoft.com/en-us/library/windows/hardware/Dn614028(v=vs.85).aspx
-- 
Darren Hart
VMware Open Source Technology Center
