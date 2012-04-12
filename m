From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 16:09:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204121607520.1496-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1204121554320.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121554320.1496-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, USB list <linux-usb@vger.kernel.org>, Andrey Rahmatullin <wrar@wrar.name>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Apr 2012, Alan Stern wrote:

> Do this with the ehci_reset added and all the other changes present as 
> well.

More precisely, keep the ehci_reset call (in both places), the dev_info
call, and the pci_prepare_to_sleep call.  You don't need to set the 
configflag register to 0; the reset will do that anyway.

Alan Stern
