From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c,
	could fix few machines
Date: Thu, 07 Feb 2008 14:34:26 -0800
Message-ID: <47AB8772.4010709@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz>
	<200802060227.14385.rjw@sisk.pl> <200802070049.00461.rjw@sisk.pl>
	<200802072312.31430.rjw@sisk.pl>
	<20080207222833.GA23004@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080207222833.GA23004@uranus.ravnborg.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Sam Ravnborg wrote:
>> +
>> +	. = 0;
>> +	.text		: { *(.text*) }
>> +
>> +	. = ALIGN(16);
> Why?

It's good practice to have at least paragraph (segment boundary) 
alignment between different types of data.  In the case of the .bss, it 
also allows cleaning with rep;movsl.

It's technically not all that necessary (except for 4-byte alignment for 
the .bss), but it makes things easier to debug on the assembly level.

>> +	/* Adjust this as appropriate */
>> +	/* This allows 4 pages (16K) */
>> +	. = ASSERT(_end <= 0x4000, "Wakeup too big!");
> PAGE_SIZE * 4?

Not really, because it's not at all related to the kernel page size; the 
reference to pages there is informal.  If we go to a larger virtual page 
size we do NOT want this to change.

	-hpa
