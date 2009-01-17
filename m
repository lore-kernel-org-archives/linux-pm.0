From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
 PCI host controllers
Date: Sat, 17 Jan 2009 16:05:29 +1100
Message-ID: <1232168729.23611.30.camel__32027.6392311373$1232168873$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0901161805450.4593-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901161805450.4593-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> Not exactly.  Just try this patch:
> 
> 	http://marc.info/?l=linux-kernel&m=123184641714487&w=2
> 
> with vanilla 2.6.29-rc1 or rc2.

I did a quick test on an old powerbook, and it seems to suspend/resume
fine, either with nothing plugged, with a usb storage device plugged or
a mouse plugged and things look ok (and the mouse suspends fine).

Cheers,
Ben.
