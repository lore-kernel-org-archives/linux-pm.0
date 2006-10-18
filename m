From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
Date: Thu, 19 Oct 2006 01:12:42 +1000
Message-ID: <4536446A.6000405@yahoo.com.au>
References: <20061017145146.GJ22289@parisc-linux.org> <45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161161AbWJRPMs@vger.kernel.org>
In-Reply-To: <20061018145104.GN22289@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

Matthew Wilcox wrote:

> I also addressed the potential issue with nested attempts to block.
> Now pci_block_user_cfg_access() can return -EBUSY if it's already blocked,
> and pci_unblock_user_cfg_access() will WARN if you try to unblock an
> already unblocked device.

Why not just WARN if it is already blocked as well? Presumably if the
driver needs nested blocking, it is going to have to carry some state
to know when to do the final unblock anyway, so it may as well just
not do these redundant blocks either.

** or ** just do a counting block/unblock to properly support nesting
them. That is, go one way or the other, and do it properly.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
