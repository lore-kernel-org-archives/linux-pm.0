From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Thu, 24 May 2007 10:12:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Christoph Lameter <clameter@sgi.com>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, =?iso-8859-15?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, Ingo Molnar <mingo@elte.hu>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>David Miller <d>
List-Id: linux-pm@vger.kernel.org



On Thu, 24 May 2007, Christoph Lameter wrote:
>
> On Thu, 24 May 2007, Michal Piotrowski wrote:
> 
> > Memory management
> > 
> > Subject    : kernel BUG at include/linux/slub_def.h:88 kmalloc_index()
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=8476
> > Submitter  : Cherwin R. Nooitmeer <cherwin@gmail.com>
> > Status     : Unknown
> 
> 
> Looks like this is in DRM code:
> 
> BUG: at include/linux/slub_def.h:88 kmalloc_index()

I'm going to change that "BUG:" to "WARNING:". 

I know some people disagreed with it (ie Ingo), but I think that's total 
and utter bullshit.

It's a warning. Right now that "BUG:" message makes people all scared 
about something that is not fatal at all, just a note that something 
hasn't been converted, but is expected to work absolutely fine.

Calling it a bug is idiotic.

			Linus
