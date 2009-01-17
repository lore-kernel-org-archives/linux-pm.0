From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
 PCI host controllers
Date: Sat, 17 Jan 2009 11:46:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901171145550.22014-100000__30984.7400327728$1232211074$gmane$org@netrider.rowland.org>
References: <1232168729.23611.30.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1232168729.23611.30.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 17 Jan 2009, Benjamin Herrenschmidt wrote:

> > Not exactly.  Just try this patch:
> > 
> > 	http://marc.info/?l=linux-kernel&m=123184641714487&w=2
> > 
> > with vanilla 2.6.29-rc1 or rc2.
> 
> I did a quick test on an old powerbook, and it seems to suspend/resume
> fine, either with nothing plugged, with a usb storage device plugged or
> a mouse plugged and things look ok (and the mouse suspends fine).

Good; thanks for testing.

Alan Stern
