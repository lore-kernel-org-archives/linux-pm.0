From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Sat, 26 May 2007 14:16:19 +0100
Message-ID: <46583323.40100__7345.82892987436$1180185454$gmane$org@genesi-usa.com>
References: <46558708.2040803@googlemail.com>
	<46559B54.80106@googlemail.com>	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>	<20070524193740.GA6787@elte.hu>	<alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>	<20070525101105.GA9268@elte.hu>
	<4656CE39.8050800@netunix.com>	<alpine.LFD.0.98.0705250937550.26602@woody.linux-foundation.org>
	<46572507.6010800@netunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46572507.6010800@netunix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: crn@netunix.com
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Christoph Lameter <clameter@sgi.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Ingo Molnar <mingo@elte.hu>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>
List-Id: linux-pm@vger.kernel.org


Chris Newport wrote:
> 
> Sorry, I did not make myself clear.
> 
> Linus Torvalds wrote:
> 
>> On Fri, 25 May 2007, Chris Newport wrote:
>>  
>>
>>> Maybe we should take a hint from Solaris.
>>>   
>>
>> No. Solaris is shit. They make their decisions based on "we control
>> the hardware" kind of setup.
>>  
>>
> Not really a Solaris feature. This is a feature of the  Openboot  PROM
> which is also used by several other vendors.
> The Openboot PROM knows how to write to disk. The same should
> apply on Apple hardware and others which use the openboot
> convention.

It doesn't, though. It is not part of any specification of Open Firmware
that you MUST be able to write to any exposed disk. In fact, I know of
one firmware implementation (ours) where we don't allow it. Apart from
being a bitch to implement safely (i.e. for people's data) it is also
quite a security problem to allow the firmware interface to write to
the disk. You can't make the differentiation between "at the firmware
console" and "inside a booted OS" unfortunately.

The 'solution' in Solaris is actually that the filesystem and disk
write handling is done by the OS bootloader and not the PROM. All
the PROM knows how to do is read off the bootloader (in a special
partition in a special filesystem format) and execute it after
probing the hardware and providing the device tree. The first stage
boot loader then knows how to read UFS filesystems so it can grab
the kernel and load kernel modules, and write back a kernel dump
if it needs to.

That, and Linux drops OF support like a lead weight very early in boot.
About all you can rely on is the device tree listing all your disks
present, and even then, Linux will redetect all of these with native
drivers and give them new names anyway. In fact, Solaris does the
same (but it is better about associating the device tree entries
than Linux)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
