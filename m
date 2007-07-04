From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Wed, 4 Jul 2007 10:44:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707041042590.25704-100000__3417.08762939579$1183560307$gmane$org@netrider.rowland.org>
References: <18058.55215.185633.434117@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18058.55215.185633.434117@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Jul 2007, Paul Mackerras wrote:

> Oliver Neukum writes:
> 
> > USB devices certainly have suspend methods.
> 
> Indeed, and the USB framework has code to know when the host
> controller is suspended and avoid trying to send out urbs in that
> case.  Or at least it did last time I looked at it in any detail; it's
> been "just working" - including suspending and resuming, without the
> freezer - for quite a while now.

Evidently you haven't been stressing it.  You might try suspending
while printing to a USB printer.

Alan Stern
