From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Wed, 24 Sep 2008 12:38:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809241229070.5963-100000__49605.315787676$1222275067$gmane$org@iolanthe.rowland.org>
References: <48DA64FC.4020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48DA64FC.4020706@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Sep 2008, Jiri Slaby wrote:

> > In fact neither of those logs includes USB debugging messages.  Maybe
> > you omitted a mkinitrd step.
> 
> I don't think so. I don't use neither vanilla nor initrd so this must be the
> kernel. Anyway I recompiled with .config linked in and did
> # dmesg >dmesg_config.hcd
> # zcat /proc/config.gz >>dmesg_config.hcd
> in the built kernel. The file is here:
> http://decibel.fi.muni.cz/~xslaby/dmesg_config.hcd

Still no debugging messages.  It's because you have 
CONFIG_DYNAMIC_PRINTK_DEBUG enabled.

Alan Stern
