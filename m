From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 14:19:13 -0800
Message-ID: <200902171419.14823.jbarnes__12635.1086343222$1234909714$gmane$org@virtuousgeek.org>
References: <200902160010.16955.rjw@sisk.pl>
	<20090217215717.GA25605@linux.intel.com>
	<20090217220439.GA1573@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090217220439.GA1573@srcf.ucam.org>
Content-Disposition: inline
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

On Tuesday, February 17, 2009 2:04 pm Matthew Garrett wrote:
> On Tue, Feb 17, 2009 at 01:57:17PM -0800, mark gross wrote:
> > Putting the wake on key event issue aside, is it possible to have wake
> > up's on the ms time scale?  I ask because I thought the XO did exactly
> > this (but left the screen live).  Why does it take 20 sec to get into
> > or out of S3 on my laptop?
>
> Graphics reinit, dumping graphics contents back into RAM, us resuming
> devices in series, that kind of thing. On some hardware you'll spend a
> noticable amount of time in the BIOS before any of the Linux resume code
> gets touched. I thought the XO had got sub second, but I wasn't sure
> that they were in the low ms range.

IME a good chunk of it is BIOS time.  On my x200s resume is very fast (on the 
order of a second or two though I haven't measured), while on my Eee and T61 
machines it's much slower, even though they're all using Intel gfx.

Of course we should really be shooting for sub-second times or about the time 
it takes you to open your lid (or even much faster in the case of demand 
suspend/resume for servers/desktops).

-- 
Jesse Barnes, Intel Open Source Technology Center
