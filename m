From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 22:04:39 +0000
Message-ID: <20090217220439.GA1573__7450.66139284081$1234908470$gmane$org@srcf.ucam.org>
References: <200902160010.16955.rjw@sisk.pl> <20090216225831.GH1370@ucw.cz>
	<20090216231324.GA15435@srcf.ucam.org>
	<20090217215717.GA25605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090217215717.GA25605@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <mgross@linux.intel.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 17, 2009 at 01:57:17PM -0800, mark gross wrote:

> Putting the wake on key event issue aside, is it possible to have wake
> up's on the ms time scale?  I ask because I thought the XO did exactly
> this (but left the screen live).  Why does it take 20 sec to get into
> or out of S3 on my laptop?

Graphics reinit, dumping graphics contents back into RAM, us resuming 
devices in series, that kind of thing. On some hardware you'll spend a 
noticable amount of time in the BIOS before any of the Linux resume code 
gets touched. I thought the XO had got sub second, but I wasn't sure 
that they were in the low ms range.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
