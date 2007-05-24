From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Thu, 24 May 2007 10:18:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705241013590.5935-100000__22127.698074519$1180016369$gmane$org@netrider.rowland.org>
References: <46559B54.80106@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46559B54.80106@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 24 May 2007, Michal Piotrowski wrote:

> Suspend
> 
> Subject    : STD fails with pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x160 [usbcore]() returns -16
> References : http://lkml.org/lkml/2007/5/19/66
> Submitter  : Andrey Borzenkov <arvidjaar@mail.ru>
> Status     : Unknown

This has been fixed and the patches are in the current -git.

Alan Stern
