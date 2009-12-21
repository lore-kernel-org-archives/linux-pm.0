From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Mon, 21 Dec 2009 21:58:19 +0200
Message-ID: <1261425499.4328.10.camel__32081.0212906965$1261425639$gmane$org@maxim-laptop>
References: <200912210140.19713.rjw@sisk.pl>  <4B2F22EF.6040500@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B2F22EF.6040500@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-12-21 at 18:25 +1100, Nigel Cunningham wrote: 
> Hi.
> 
> Rafael J. Wysocki wrote:
> > I'm not sure what the next step should be at this point.  To me, the picture is
> > quite clear now, but perhaps we ought to run more tests on some other machines
> > or something.  Please let me know what you think.
> 
> Looks great. If you do decide you want other machines tested, I'll
> happily try the machines around here:
> 
> - Dell M1530
> - Omnibook XE3-GF.
> - Via LN10000 based Mythtv Box
> - Desktop machine - Some Intel-based mobo I've forgotten the name of.
> 
> I've been quietly following the thread, but have lost track of what
> iteration of the patch you're on, so if you'd give me a pointer to it,
> I'd be grateful.
> 
> By the way, I haven't forgotten about sending some real patches for
> swsusp (ie more than just cleanups). I'm just busy with other things and
> also thinking carefully about what order to do things in.

I vote for ability to save all ram to the disk.
After several days of testing I managed to make my system do s2disk
really reliable (~300 cycles tested), but suspending when memory is
tight still fails sometimes.

I didn't yet use your tuxonice system  though.

Best regards,
Maxim Levisky
