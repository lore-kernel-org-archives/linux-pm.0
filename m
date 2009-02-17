From: mark gross <mgross@linux.intel.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 13:57:17 -0800
Message-ID: <20090217215717.GA25605__17438.5221711875$1234907937$gmane$org@linux.intel.com>
References: <200902160010.16955.rjw@sisk.pl> <20090216225831.GH1370@ucw.cz>
	<20090216231324.GA15435@srcf.ucam.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090216231324.GA15435@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 16, 2009 at 11:13:24PM +0000, Matthew Garrett wrote:
> On Mon, Feb 16, 2009 at 11:58:31PM +0100, Pavel Machek wrote:
> 
> > If no devices are being used, and next wakeup is far enough in the
> > future, just put system to sleep. Long enough == so far away that
> > suspend/wakeup is short compared to that... like 20 seconds on PC.
> 
> This is intrinsically difficult with PCs, since we have such a poorly 
> defined set of wakeup events. We can't wakeup on generic network 
> traffic, just WoL. Many machines won't wake up on keyboard events. 
> Meanwhile, on embedded it's becoming a less interesting problem because 
> idle and suspended are often now equivalent states. Concentrating on 
> runtime PM of as much hardware as possible is arguably more interesting 
> for the majority of use cases.

Putting the wake on key event issue aside, is it possible to have wake
up's on the ms time scale?  I ask because I thought the XO did exactly
this (but left the screen live).  Why does it take 20 sec to get into
or out of S3 on my laptop?

--mgross

> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
