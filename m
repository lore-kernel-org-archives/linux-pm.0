From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 17:28:32 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037726145B__35313.4649027654$1234913545$gmane$org@dlee02.ent.ti.com>
References: <200902160010.16955.rjw@sisk.pl>
	<20090217215717.GA25605@linux.intel.com>
	<20090217220439.GA1573@srcf.ucam.org>
	<200902171419.14823.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902171419.14823.jbarnes@virtuousgeek.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "arjan@infradead.org" <arjan@infradead.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Uli Luckas <u.luckas@road.de>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> From: Jesse Barnes [mailto:jbarnes@virtuousgeek.org]
> Sent: Tuesday, February 17, 2009 4:19 PM

> On Tuesday, February 17, 2009 2:04 pm Matthew Garrett wrote:
> > On Tue, Feb 17, 2009 at 01:57:17PM -0800, mark gross wrote:
> > > Putting the wake on key event issue aside, is it possible to have wake
> > > up's on the ms time scale?  I ask because I thought the XO did exactly
> > > this (but left the screen live).  Why does it take 20 sec to get into
> > > or out of S3 on my laptop?
> >
> > Graphics reinit, dumping graphics contents back into RAM, us resuming
> > devices in series, that kind of thing. On some hardware you'll spend a
> > noticable amount of time in the BIOS before any of the Linux resume code
> > gets touched. I thought the XO had got sub second, but I wasn't sure
> > that they were in the low ms range.
>
> IME a good chunk of it is BIOS time.  On my x200s resume is very fast (on the
> order of a second or two though I haven't measured), while on my Eee and T61
> machines it's much slower, even though they're all using Intel gfx.
>
> Of course we should really be shooting for sub-second times or about the time
> it takes you to open your lid (or even much faster in the case of demand
> suspend/resume for servers/desktops).

This is good example of embedded ARM time scales not matching up with x86 ones.  For OMAP3 our resumption from OFF mode (full SOC context lost) software budget was in the 10s of milliSeconds.  There is no BIOS and we must generate most of the code.

As such very frequent fast OFF mode transitions are useful and possible.  As I said in another part of the thread, the slow part is Voltage ramp time. Also clock setup time of external oscillator can be 5-10mS by itself.

This tight timing was the requirement of some modems which required a response ASAP when data was coming.  Not every modem is so tight but some are.

Regards,
Richard W.
