From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Date: Fri, 25 May 2007 09:45:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705250939210.6292__27299.5802727111$1180111552$gmane$org@schroedinger.engr.sgi.com>
References: <46558708.2040803@googlemail.com> <46559B54.80106@googlemail.com>
	<Pine.LNX.4.64.0705241001040.28086@schroedinger.engr.sgi.com>
	<alpine.LFD.0.98.0705241007290.26602@woody.linux-foundation.org>
	<20070524193740.GA6787@elte.hu>
	<alpine.LFD.0.98.0705241247540.26602@woody.linux-foundation.org>
	<20070525101105.GA9268@elte.hu> <4656CE39.8050800@netunix.com>
	<20070525123456.GA17238@elte.hu>
	<20070525093354.5dbe5f43.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070525093354.5dbe5f43.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Kristian H?gsberg <krh@bitplanet.net>, Mikael Pettersson <mikpe@it.uu.se>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, Alan Cox <alan@redhat.com>, linux-pm@lists.linux-foundation.org, Robert de Rooy <robert.de.rooy@gmail.com>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pcmcia@lists.infradead.org, Marcus Better <marcus@better.se>, Ingo Molnar <mingo@elte.hu>, jlan@sgi.com, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Chris Newport <crn@netunix.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux->
List-Id: linux-pm@vger.kernel.org

On Fri, 25 May 2007, Andrew Morton wrote:

> the image".  But we're not - kernel developers don't know how to turn the
> thing on in $RANDOM_DISTRO, testers have no experience with the feature
> and kernel developers don't have experience handling the crash images.

Well, we for instance have problems with huge crash dumps. Its even a 
challenge if the machine has only a few gigabytes of main memory.
 
> And I'm not sure that the (required) "don't dump user memory and pagecache"
> feature has been implemented yet?

A colleague of mine is still working to get it to work just right on IA64.
He does it full time. sigh. Jay what is the status on that?
