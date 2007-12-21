From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: OOPS: 2.6.24-rc5-mm1 -- EIP is at r_show+0x2a/0x70
	-- (triggered by "cat /proc/iomem" AFTER suspend-to-disk/resume)
Date: Fri, 21 Dec 2007 01:18:53 -0500
Message-ID: <a44ae5cd0712202218p4ce66ff4r7b74c53ee2c23138__47239.2282485545$1198218024$gmane$org@mail.gmail.com>
References: <a44ae5cd0712192040k7480682eoa29f33d70a91c618@mail.gmail.com>
	<4769F409.6030300@gmail.com> <4769FF37.5060308@gmail.com>
	<476A703B.50804@gmail.com>
	<20071220093206.22f319b0.akpm@linux-foundation.org>
	<a44ae5cd0712202158u31c8b4e1lf5b0df89dde20e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <a44ae5cd0712202158u31c8b4e1lf5b0df89dde20e7e@mail.gmail.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@sgi.com>
List-Id: linux-pm@vger.kernel.org

Resending...  Curse GMail's HTML messages!

On Dec 21, 2007 12:58 AM, Miles Lane <miles.lane@gmail.com> wrote:
>
> On Dec 20, 2007 12:32 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > On Thu, 20 Dec 2007 08:38:03 -0500 Miles Lane <miles.lane@gmail.com> wrote:
> >
> > > On further investigation, "cat /proc/iomem" does not trigger the stack
> > > trace until after a suspend-to-disk/resume cycle has occurred.
> >
> > I still can't reproduce this.
> >
> > Could you please try this?
> >
> > - cat /proc/iomem
> > - suspend/resume
> > - do
> >
> > while read i
> > do
> > echo $i
> > sleep 1
> > done < /proc/iomem
> >
> > then, with luck, we'll be able to work out which /proc/iomem record
> > immediately precedes the corrupted one.
> >
>
> miles@syntropy:~$ cat > test.sh
>
> while read i
> do
> echo $i
> sleep 1
> done < /proc/iomem
> ^C
> miles@syntropy:~$ sh test.sh
> 00000000-0009f7ff : System RAM
> 0009f800-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-7f68ffff : System RAM
> 00100000-0039e4b7 : Kernel code
> 0039e4b8-004f0983 : Kernel data
> 00553000-007ecdfb : Kernel bss
> 7f690000-7f698fff : ACPI Tables
> 7f699000-7f6fffff : ACPI Non-volatile Storage
> 7f700000-7fffffff : reserved
> 88000000-8bffffff : PCI CardBus #05
> 8c000000-8fffffff : PCI CardBus #05
> Segmentation fault
>
> How do I determine what comes next?
>
> Thanks,
>          Miles
>
