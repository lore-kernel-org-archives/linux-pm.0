From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 21:09:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204122103230.10558-100000@netrider.rowland.org>
References: <20120412203042.GI12852@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120412203042.GI12852@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Apr 2012, Andrey Rahmatullin wrote:

> With
> - pci_prepare_to_sleep in pci_pm_suspend_noirq
> - pci_disable_enabled_device instead of pci_disable_device in
>   suspend_common
> - ehci_reset at the end of ehci_pci_suspend
> it still locks up.

I expected that.  Sigh.

Tomorrow I'll look through the code more carefully; with those changes
there really is very little difference between the two cases.  Things
like mmio mappings and IRQs requested; they shouldn't cause a crash.

Alan Stern
