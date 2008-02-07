From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: suspend to ram problem
Date: Thu, 07 Feb 2008 20:49:24 +0100
Message-ID: <47AB60C4.50602__49727.7438793846$1202413881$gmane$org@free.fr>
References: <47A5C399.7010405@free.fr> <47A6B758.7070405@free.fr>
	<47A8EB02.90502@free.fr> <200802060020.12289.rjw@sisk.pl>
	<47AA3763.7000106@free.fr> <20080206224328.GB1630@elf.ucw.cz>
	<47AA4000.6010701@free.fr> <20080207092035.GB1816@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080207092035.GB1816@elf.ucw.cz>
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

Hi,


Pavel Machek wrote:
> Hi!
> So I assume it is some kind of desktop?
Yes.

>>
>> ...if someone calls start as 0x1234:0, we are okay. But if some broken
>> bios calls us as 0x1:0x234, we've got a problem.
>
> Well, in that case the signature/end_signature tests below would 
 >trigger, no?

Yes, and for example the beep flag won't work.

>
> Not sure what is going on... but if you remove all the stack
> references, does it go up to 32-bit mode?
Yes, but I end up with a kernel panic after console resume and some 
resume stuff.

 > Looks like ss goes bonkers or the 32-bit opcodes are invalid in real 
mode.
 > Matthieu, can you try "pushw %ax; popw %ax;", please?
I still crash.
I also try to set ss to 0, and hardcode the stack (knowing we are loaded 
at 0x1000). And it crash.


I wonder if there a way to check that we are realy in real mode ?


Matthieu
