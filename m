From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [ath5k-devel]  PCI hotplug v.s. suspend
Date: Thu, 18 Jun 2009 14:45:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906181437090.3129-100000__13180.2282449373$1245350800$gmane$org@netrider.rowland.org>
References: <4A3A2A3E.7090300@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3A2A3E.7090300@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Bob Copeland <me@bobcopeland.com>, ath5k-devel@venema.h4ckr.net, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 18 Jun 2009, Alan Jenkins wrote:

> Unfortunately this makes it worse.  My eeepc-laptop hacks are now in
> wireless-testing.  If I apply the above patch to wireless-testing and
> "remove" the device while suspended, I get a soft hang on resume. 

Is this different from the behavior without the patch?  (I don't see 
how it could be.)

> Suspending without removal works fine.
> 
> I can see a BUG if I boot with no_console_suspend
> 
> Unable to handle kernel NULL pointer dereference
> IP: klist_put
> Tainted: G W
> Process s2disk
> 
> Call trace:
> ? klist_del
> ? device_del
> ? device_unregister
> ? pci_stop_dev
> ? pci_stop_bus
> ? pci_remove_device
> ? eeepc_rfkill_hotplug [eeepc_laptop]
> ? eeepc_hotk_resume [eeepc_laptop]
> ? acpi_device_resume
> ? device_resume
> ? hibernation_snapshot

This should be doing more or less the same thing as if you removed the 
device while the system was running.  Or is it not hot-unpluggable?

Alan Stern
