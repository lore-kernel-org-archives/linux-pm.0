From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [linux-pm] [PATCH] Block on access to temporarily unavailable pci device
Date: Wed, 18 Oct 2006 10:09:26 -0600
Message-ID: <20061018160926.GS22289@parisc-linux.org>
References: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org> <1161187503.9363.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161225AbWJRQJ3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1161187503.9363.75.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 18, 2006 at 05:05:02PM +0100, Alan Cox wrote:
> If the user specified O_NDELAY then -EWOULDBLOCK not wait

sysfs doesn't give us the struct file, so we can't tell.
