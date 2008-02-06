From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: suspend to ram problem
Date: Thu, 07 Feb 2008 00:17:20 +0100
Message-ID: <47AA4000.6010701__33210.8262963176$1202339970$gmane$org@free.fr>
References: <47A5C399.7010405@free.fr> <47A6B758.7070405@free.fr>
	<47A8EB02.90502@free.fr> <200802060020.12289.rjw@sisk.pl>
	<47AA3763.7000106@free.fr> <20080206224328.GB1630@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080206224328.GB1630@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Wed 2008-02-06 23:40:35, matthieu castet wrote:
>>>> If I remove stack access (remove clearing flag stuff, not call to video 
>>>> stuff) the resume works.
>>> Hm, can you place a "pushl %eax; popl %eax;" in place of the removed code and
>>> see if that breaks?
>> Yes that also break.
> 
> Hmm, and what kind of machine is that?
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1800+
stepping        : 2
cpu MHz         : 1533.490
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 3070.84
clflush size    : 32
