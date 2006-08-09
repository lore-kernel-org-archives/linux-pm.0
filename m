From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Re: swsusp and suspend2 like to overheat my
	laptop
Date: Wed, 09 Aug 2006 17:45:19 +0400
Message-ID: <44D9E6EF.9050400@wasp.net.au>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>	<20060808235352.GA4751@elf.ucw.cz>	<Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>	<20060809073958.GK4886@elf.ucw.cz>	<Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>	<20060809115843.GB3747@elf.ucw.cz>
	<Pine.LNX.4.58.0608090932460.3785@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <Pine.LNX.4.58.0608090932460.3785@gandalf.stny.rr.com>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@osdl.org, ncunningham@linuxmail.org, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Suspend2-devel@lists.suspend2.net
List-Id: linux-pm@vger.kernel.org

Steven Rostedt wrote:
> 
> Well it went to sleep fine.  But when I tried to wake it up again, the
> screen didn't come back. I'm not sure if the keyboard was working either.
> But I could eject the CD and when I put it back in, it seemed to mount it.
> 

Different laptop of course.. but good results can often be had with
s2ram -f -s

Running the full array of command line permutations can be somewhat tedious though. A good initramfs 
and separate grub boot entry help there a great deal (no fsck if you lock it up).

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
