From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: OOPS: 2.6.24-rc5-mm1 -- EIP is at r_show+0x2a/0x70
	-- (triggered by "cat /proc/iomem" AFTER suspend-to-disk/resume)
Date: Fri, 21 Dec 2007 00:58:19 -0500
Message-ID: <a44ae5cd0712202158u31c8b4e1lf5b0df89dde20e7e@mail.gmail.com>
References: <a44ae5cd0712192040k7480682eoa29f33d70a91c618@mail.gmail.com>
	<4769F409.6030300@gmail.com> <4769FF37.5060308@gmail.com>
	<476A703B.50804@gmail.com>
	<20071220093206.22f319b0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0649012617666144444=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071220093206.22f319b0.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@sgi.com>
List-Id: linux-pm@vger.kernel.org

--===============0649012617666144444==
Content-Type: multipart/alternative;
	boundary="----=_Part_24707_23015855.1198216704411"

------=_Part_24707_23015855.1198216704411
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 20, 2007 12:32 PM, Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 20 Dec 2007 08:38:03 -0500 Miles Lane <miles.lane@gmail.com>
> wrote:
>
> > On further investigation, "cat /proc/iomem" does not trigger the stack
> > trace until after a suspend-to-disk/resume cycle has occurred.
>
> I still can't reproduce this.
>
> Could you please try this?
>
> - cat /proc/iomem
> - suspend/resume
> - do
>
> while read i
> do
> echo $i
> sleep 1
> done < /proc/iomem
>
> then, with luck, we'll be able to work out which /proc/iomem record
> immediately precedes the corrupted one.
>

miles@syntropy:~$ cat > test.sh
while read i
do
echo $i
sleep 1
done < /proc/iomem
^C
miles@syntropy:~$ sh test.sh
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-7f68ffff : System RAM
00100000-0039e4b7 : Kernel code
0039e4b8-004f0983 : Kernel data
00553000-007ecdfb : Kernel bss
7f690000-7f698fff : ACPI Tables
7f699000-7f6fffff : ACPI Non-volatile Storage
7f700000-7fffffff : reserved
88000000-8bffffff : PCI CardBus #05
8c000000-8fffffff : PCI CardBus #05
Segmentation fault

How do I determine what comes next?

Thanks,
         Miles

------=_Part_24707_23015855.1198216704411
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Dec 20, 2007 12:32 PM, Andrew Morton &lt;<a href="mailto:akpm@linux-foundation.org">akpm@linux-foundation.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Thu, 20 Dec 2007 08:38:03 -0500 Miles Lane &lt;<a href="mailto:miles.lane@gmail.com">miles.lane@gmail.com</a>&gt; wrote:<br><br>&gt; On further investigation, &quot;cat /proc/iomem&quot; does not trigger the stack
<br>&gt; trace until after a suspend-to-disk/resume cycle has occurred.<br><br></div>I still can&#39;t reproduce this.<br><br>Could you please try this?<br><br>- cat /proc/iomem<br>- suspend/resume<br>- do<br><br>while read i
<br>do<br>echo $i<br>sleep 1<br>done &lt; /proc/iomem<br><br>then, with luck, we&#39;ll be able to work out which /proc/iomem record<br>immediately precedes the corrupted one.<br></blockquote></div><br>miles@syntropy:~$ cat &gt; 
test.sh<br>while read i<br>do<br>echo $i<br>sleep 1<br>done &lt; /proc/iomem<br>^C<br>miles@syntropy:~$ sh test.sh <br>00000000-0009f7ff : System RAM<br>0009f800-0009ffff : reserved<br>000a0000-000bffff : Video RAM area<br>
000c0000-000c7fff : Video ROM<br>000f0000-000fffff : System ROM<br>00100000-7f68ffff : System RAM<br>00100000-0039e4b7 : Kernel code<br>0039e4b8-004f0983 : Kernel data<br>00553000-007ecdfb : Kernel bss<br>7f690000-7f698fff : ACPI Tables
<br>7f699000-7f6fffff : ACPI Non-volatile Storage<br>7f700000-7fffffff : reserved<br>88000000-8bffffff : PCI CardBus #05<br>8c000000-8fffffff : PCI CardBus #05<br>Segmentation fault<br><br>How do I determine what comes next?
<br><br>Thanks,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Miles<br>

------=_Part_24707_23015855.1198216704411--

--===============0649012617666144444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0649012617666144444==--
