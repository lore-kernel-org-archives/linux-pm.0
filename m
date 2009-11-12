From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Wed, 11 Nov 2009 23:20:15 -0800
Message-ID: <4AFBB72F.6070907__38988.5147255429$1258010516$gmane$org@zytor.com>
References: <4AF7D820.5040503@kernel.org> <200911091315.13151.rjw@sisk.pl>	
	<4AFA210B.3020207@kernel.org>	
	<1257930767.31183.113.camel@localhost.localdomain>	
	<4AFB0B02.4050306@kernel.org>	
	<1257988632.31183.134.camel@localhost.localdomain>	
	<4AFB7D21.6050004@kernel.org>	
	<1257997072.3888.4.camel@localhost.localdomain>	
	<4AFB9B60.7010009@kernel.org>
	<1258010067.3802.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1258010067.3802.11.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 11/11/2009 11:14 PM, ykzhao wrote:
> 
> In this patch the find_e820_area is used in the
> acpi_reserve_wakeup_memory, which is called after initializing the
> bootmem allocator.
> Can we still use the find_e820_area after the bootmem allocator is
> initialized? 

Obviously not: the bootmem allocator now thinks it owns memory, and it
wouldn't know not to allocate something that is later claimed by
find_e820_area.  Problem.

> It seems that the bootmem bitmap is also found by using the
> find_e820_area. But we don't update the reserved_early array any more.
> Maybe we will get the overlap address with the bootmem bitmap for the
> wakeup code.

Not just the bitmap, but any bootmem allocation could conflict...

	-hpa
-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
