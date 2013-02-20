From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] freezer: configure user space process frozen along with
 kernel threads
Date: Wed, 20 Feb 2013 10:24:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302201021210.1671-100000@iolanthe.rowland.org>
References: <878v6jjdoq.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34639 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935325Ab3BTPYN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 10:24:13 -0500
In-Reply-To: <878v6jjdoq.fsf@xmission.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Li Fei <fei.li@intel.com>, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, gorcunov@openvz.org, rientjes@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, chuansheng.liu@intel.com, biao.wang@intel.com

On Wed, 20 Feb 2013, Eric W. Biederman wrote:

> Why can't the fuse filesystem freeze when there are requests pending?

It _can_ freeze (that is, the fuse daemon can).  The problem is that
tasks _using_ the fuse filsystem can't if the daemon doesn't respond.  
These tasks are stuck in uninterruptible wait states deep in the
filesystem layer, probably holding important locks.  They can't be
frozen until the outstanding requests complete.

Alan Stern

