From: Chris Newport <crn@netunix.com>
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Fri, 25 May 2007 19:03:51 +0100
Message-ID: <46572507.6010800__48853.0732611709$1180116358$gmane$org@netunix.com>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
	<20070524193740.GA6787@elte.hu>
	<alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
	<20070525101105.GA9268@elte.hu> <4656CE39.8050800@netunix.com>
	<alpine.LFD.0.98.0705250937550.26602@woody.linux-foundation.org>
Reply-To: crn@netunix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.98.0705250937550.26602@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Ingo Molnar <mingo@elte.hu>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>
List-Id: linux-pm@vger.kernel.org


Sorry, I did not make myself clear.

Linus Torvalds wrote:

>On Fri, 25 May 2007, Chris Newport wrote:
>  
>
>>Maybe we should take a hint from Solaris.
>>    
>>
>
>No. Solaris is shit. They make their decisions based on "we control the 
>hardware" kind of setup.
>  
>
Not really a Solaris feature. This is a feature of the  Openboot  PROM
which is also used by several other vendors.
The Openboot PROM knows how to write to disk. The same should
apply on Apple hardware and others which use the openboot
convention.

If dumps are enabled (disabled by default in a file read at boot) the
crash() function need only  set a couple of registers and do a prom
interrupt. At this point the kernel is no longer involved so broken
drivers etc are not an issue.

The cute bit is that the SunOS debug program can be called as
debug $DUMPFILE and it takes you to the failure point just like
a tracefile.

Crashdumps should not be enabled by default, they can chew rather
a lot of disk space making a crashdump.datetime file every time
something breaks <B-).
In most cases only developers will use this but it does resolve the
problem of error messages vanishing before they can be saved.


>  
>
>>If the kernel crashes Solaris dumps core to swap and sets a flag.
>>At the next boot this image is copied to /var/adm/crashdump where
>>it is preserved for future debugging. Obviously swap needs to be
>>larger than core, but this is usually the case.
>>    
>>
>
>(a) it's not necessarily the case at all on many systems
>
>(b) _most_ crashes that are real BUG()'s (rather than WARN_ON()'s) leave 
>    the system in such a fragile state that trying to write to disk is the 
>    _last_ thing you should do.
>
>    Linux does the right thing: it tries to not make bugs fatal. 
>    Generally, you should see an oops, and things continue. Or a 
>    WARN_ON(), and things continue. But you should avoid the "the machine 
>    is now dead" cases.
>
>(c) have you looked at the size of drivers lately? I'd argue that *most* 
>    bugs by far happen in something driver-related, and most of our source 
>    code is likely drivers.
>
>    Writing to disk when the biggest problem is a driver to begin with 
>    is INSANE.
>
>So the fact is, Solaris is crap, and to a large degree Solaris is crap 
>exactly _because_ it assumes that it runs in a "controlled environment".
>
>Yes, in a controlled environment, dumping the whole memory image to disk 
>may be the right thing to do. BUT: in a controlled environment, you'll 
>never get the kind of usage that Linux gets. Why do you think Linux (and 
>Windows, for that matter) took away a lot of the market from traditional 
>UNIX? 
>
>Answer: the traditional UNIX hardware/control model doesn't _work_. People 
>want more flexibility, both on a hardware side and on a usage side. And 
>once you have the flexibility, the "dump everything to disk" is simply not 
>an option any more.
>
>Disk dumps etc are options at things like wall street. But look at the bug 
>reports, and ask yourself how many of them happen at Wall Street, and how 
>many of them would even be _relevant_ to somebody there? 
>
>So forget about it. The whole model is totally broken. We need to make 
>bug-reports short and sweet, enough so that random people can 
>copy-and-paste them into an email or take a digital photo. Anything else 
>IS TOTALLY INSANE AND USELESS!
>
>			Linus
>  
>
