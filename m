From: Tejun Heo <teheo@suse.de>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression (xfs on raid6)
Date: Fri, 15 Jun 2007 00:10:30 +0900
Message-ID: <46715A66.8030806@suse.de>
References: <200706020122.49989.rjw@sisk.pl> <46706968.7000703@dgreaves.com> <alpine.LFD.0.98.0706131507360.14121@woody.linux-foundation.org> <200706140115.58733.rjw@sisk.pl> <46714ECF.8080203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753336AbXFNPLB@vger.kernel.org>
In-Reply-To: <46714ECF.8080203@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, David Greaves <david@dgreaves.com>, David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Neil Brown <neilb@suse.de>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

Tejun Heo wrote:
> David, do you store the hibernation image on the RAID-6 array?  Can you
> post the captured kernel log when it locks up?

Never mind.  Just succeeded to reproduce it here.  It definitely has
something to do with the raid code.  ext3 on raid6 is showing the same
problem.  I'll report back as soon as I find out more.

-- 
tejun
