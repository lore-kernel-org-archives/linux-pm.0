From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 10:14:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106171010580.2143-100000__2905.05441739715$1308320134$gmane$org@iolanthe.rowland.org>
References: <20110616213605.GI7253@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110616213605.GI7253@belkar.wrar.name>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Jun 2011, Andrey Rahmatullin wrote:

> > Okay, the next step is to try and find out exactly where the ehci 
> > suspend procedure is hanging.  The patch below adds a bunch of 
> > printouts at various spots throughout the procedure.  Let's see what 
> > shows up.
> I don't see any of these new messages.

Are you sure the new ehci-hcd.ko module was loaded when you ran the 
test?

Another thing you should do when testing:

	echo 9 >/proc/sys/kernel/printk

(Or equivalently, Alt-SysRq-9 on the keyboard.)  I should have
mentioned that before sending the test patch.  Oh well....

Alan Stern
