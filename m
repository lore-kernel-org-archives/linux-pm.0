From: Brian King <brking@us.ibm.com>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
 [version 3]
Date: Fri, 20 Oct 2006 16:50:52 -0500
Message-ID: <453944BC.7090409@us.ibm.com>
References: <20061017145146.GJ22289@parisc-linux.org> <20061019154128.GD2602@parisc-linux.org>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992859AbWJTVvB@vger.kernel.org>
In-Reply-To: <20061019154128.GD2602@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

Matthew Wilcox wrote:
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Acked-by: Brian King <brking@us.ibm.com>

I tried this out on my machine with an ipr adapter, where
I forced the adapter through BIST using ipr's reset_host
sysfs attribute, all the while continually reading pci
config space through sysfs in a loop. Everything looked
good.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
