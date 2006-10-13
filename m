From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] Bug in PCI core
Date: Fri, 13 Oct 2006 11:01:03 +1000
Message-ID: <1160701263.4792.179.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751432AbWJMBBX@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2006-10-11 at 16:41 -0400, Alan Stern wrote:
> When a PCI device is suspended, its driver calls pci_save_state() so that
> the config space can be restored when the device is resumed.  Then the
> driver calls pci_set_power_state().
> 
> However pci_set_power_state() calls pci_block_user_cfg_access(), and that 
> routine calls pci_save_state() again.  This overwrites the saved state 
> with data in which memory, I/O, and bus master accesses are disabled.  As 
> a result, when the device is resumed it doesn't work.
> 
> Obviously pci_block_user_cfg_access() needs to be fixed.  I don't know the 
> right way to fix it; hopefully somebody else does.

Well, blocking user cfg access snapshots the config space to be able to
respond to user space while the device is offline. Maybe it should be
done from a separate config space image buffer ? ugh....

Ben.
