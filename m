From: Adam Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
	[version 3]
Date: Thu, 19 Oct 2006 19:13:56 -0400
Message-ID: <1161299636.16080.17.camel@localhost.localdomain>
References: <20061017145146.GJ22289@parisc-linux.org>
	 <20061019154128.GD2602@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946653AbWJSXKf@vger.kernel.org>
In-Reply-To: <20061019154128.GD2602@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-10-19 at 09:41 -0600, Matthew Wilcox wrote:
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Acked-by: Adam Belay <abelay@novell.com>

It would be nice if we had sysfs expose struct file at some point... :)

Thanks,
Adam
