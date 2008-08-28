From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: resume from ram hangs on 2.6.26+ kernels on thinkpad
	z60m
Date: Thu, 28 Aug 2008 21:22:16 +0200
Message-ID: <200808282122.17019.rjw@sisk.pl>
References: <200808201602.26848.arekm@maven.pl>
	<200808241631.14746.arekm@maven.pl>
	<200808282045.55281.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808282045.55281.arekm@maven.pl>
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
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 28 of August 2008, Arkadiusz Miskiewicz wrote:
> On Sunday 24 August 2008, Arkadiusz Miskiewicz wrote:
> 
> > Ok, will get back to the problem when I get/notice something that can get
> > us a clue.
> 
> So here I am. Not directly resume hang but may be related. git kernel from ~2 
> days ago.
> 
> resume succeeded but dmesg indicated tons of:
> 
> [51055.352019] Freezing of tasks failed after 20.00 seconds (1 tasks refusing 
> to freeze):
> [51055.352025]   task                PC stack   pid father
> [51055.352031] init          D 97af68e4     0     1      0
> [51055.352038]        f7851e9c 00000086 f7848000 97af68e4 00002e6a c8559005 
> f7851e80 f7848274
> [51055.352050]        97c8187b 00002e6a f7851e8c f72a6000 00000000 00000000 
> 00000000 00000000
> [51055.352061]        f7851f10 f7851ea8 c0138788 0000000b f7851ed4 c0125912 
> c8559000 00000000
> [51055.352073] Call Trace:
> [51055.352079]  [<c0138788>] refrigerator+0x5e/0x66
> [51055.352092]  [<c0125912>] get_signal_to_deliver+0x3e/0x2ac
> [51055.352102]  [<c0102b04>] do_notify_resume+0x69/0x6bc
> [51055.352111]  [<c01c6c88>] ? copy_to_user+0x2c/0xfc
> [51055.352122]  [<c0172a5a>] ? sys_select+0x124/0x147
> [51055.352131]  [<c010380a>] work_notifysig+0x13/0x19
> [51055.352161]  =======================
> [51055.352165] kthreadd      S 3ae87c78     0     2      0
> [51055.352172]        f7853fc4 00000046 f7848c60 3ae87c78 00000998 00000000 
> 00000003 f7848ed4
> [51055.352183]        3ae888d4 00000998 00001f47 e8a65540 f7853fc4 c011588a 
> e83efd70 00001f47
> [51055.352194]        c034b1a8 f7853fe0 c012a543 00000000 00000001 c012a4e6 
> 00000000 00000000
> [51055.352205] Call Trace:
> [51055.352209]  [<c011588a>] ? complete+0x1f/0x28
> [51055.352219]  [<c012a543>] kthreadd+0x5d/0xee
> [51055.352226]  [<c012a4e6>] ? kthreadd+0x0/0xee
> [51055.352233]  [<c010425f>] kernel_thread_helper+0x7/0x10
> [51055.352241]  =======================
> [51055.352244] ksoftirqd/0   S 978f04aa     0     3      2
> [51055.352251]        f7859fc4 00000046 f78498c0 978f04aa 00002e6a f2fe4a40 
> 0000000a f7849b34
> [51055.352262]        97a1861e 00002e6a c0120150 e78cca80 c012017f 00000000 
> 00000000 c012017f
> [51055.352273]        00000000 f7859fd0 c01201a0 00000000 f7859fe0 c012a60d 
> c012a5d4 00000000
> 
> 
> config: http://carme.pld-linux.org/~arekm/suspend-config-20080828
> full dmesg: http://carme.pld-linux.org/~arekm/dmesg-suspend-20080828

Hm, cifsd.  It is kind of known to have problems.

How reproducible is this?

Rafael
