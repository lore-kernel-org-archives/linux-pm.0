From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
 Rearrange core suspend code)
Date: Thu, 18 Jun 2009 19:50:15 -0600
Message-ID: <4A3AEED7.90804__19012.586589861$1245424212$gmane$org@gmail.com>
References: <200906072347.00580.rjw@sisk.pl>
	<20090608065419.GA13568@elte.hu>	<200906081330.50045.rjw@sisk.pl>
	<20090608130509.GA3272@elte.hu>	<20090608131159.GA15100@srcf.ucam.org>	<20090608132235.GC13214@elte.hu>	<20090608133215.GA15482@srcf.ucam.org>	<20090608134647.GA14234@elte.hu>	<20090608135431.GA16052@srcf.ucam.org>	<20090608142450.GE14234@elte.hu>
	<20090608143513.GB16752@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090608143513.GB16752@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ide <linux-ide@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 06/08/2009 08:35 AM, Matthew Garrett wrote:
> On Mon, Jun 08, 2009 at 04:24:50PM +0200, Ingo Molnar wrote:
>> * Matthew Garrett<mjg59@srcf.ucam.org>  wrote:
>>> eSATA is pretty common now.
>> [ And 99% of the CPUs have an IDT still 99.9% of the users dont know
>>    what it is :) ]
>
> Users know that there's a socket on the front of their computer that
> they can plug a hard drive into, and if that doesn't work then they're
> going to be upset.
>
>>> The problem with this kind of default is that you get people who
>>> are confused that their hardware doesn't work.
>> If the hardware 'doesnt work' that is a kernel bug. Hardware that
>> _cannot be suspended_ safely (physically) should not be
>> auto-suspended, of course.
>
> So, like I said, the kernel can't automatically suspend AHCI unless it's
> received some information from elsewhere that tells it it's ok to. The
> kernel can't know if there's an eSATA port or not.
>
>>> If the kernel doesn't have enough information to make a decision
>>> it should err on the side of functionality - we're talking about
>>> fairly low-level power savings, but potentially several years of
>>> aggregate confusion on the part of users.
>> the difference between a 10W and a 1W footprint is a long series of
>> 'low-level power savings'.
>>
>> If users are getting confused and if hardware gets broken then tha's
>> a plain bug and the wrong path is being walked.
>
> Yes. And powersaving is a tradeoff between functionality and power
> consumption. The kernel doesn't know what level of functionality a given
> user requires. It *can't* know that itself.
>
>>> Users are generally ok at realising correlation between a setting
>>> change and something no longer working, so as long as you provide
>>> that they'll be happy. I agree that this sucks. What we actually
>>> want is some means of reliably identifying whether a port is
>>> hotplug or not, but eSATA makes this very difficult.
>> Is it impossible?
>
> To the best of my knowledge, yes.

Well, in some cases we can get an idea - the current AHCI spec has bits 
in the PxCMD register (External SATA Port and Hot Plug Capable Port) 
which can indicate which ports are externally accessible and thus are 
likely to receive hotplug events. Of course, these are supposed to be 
programmed by the BIOS based on the particular motherboard/machine, and 
we all know how accurate BIOS-reported information can be..
