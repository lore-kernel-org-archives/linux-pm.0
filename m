From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Tue, 01 Jul 2008 00:02:19 -0700
Message-ID: <4869D67B.4060902__157.456126953726$1214896133$gmane$org@zytor.com>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080701063133.GC16642@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>, kernel-testers@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Ingo Molnar wrote:
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
>> Hi,
>>
>> The appended patch fixes a regression and is considered as 2.6.26 
>> material. Everyone having a box with working suspend to RAM is gently 
>> requested to test it and verify if it doesn't break things.
>>
>> The patch applies to the current -git.
> 
> it's been under testing in tip/out-of-tree for about a week:
> 
> | commit ee901dc1b9ab94a37ba2efc296fe9ba72bc75adf
> | Author:     H. Peter Anvin <hpa@zytor.com>
> | AuthorDate: Tue Jun 24 23:03:48 2008 +0200
> | Commit:     Ingo Molnar <mingo@elte.hu>
> | CommitDate: Wed Jun 25 18:48:13 2008 +0200
> |
> |     x86 ACPI: normalize segment descriptor register on resume
> 
> no problems caused by it so far.
> 

It still seems incredibly risky to push this for 2.6.26, especially 
given the Elan revelation.  I think it needs to be tested on the 2.6.27 
track, and then possibly be pushed back via the 2.6.26-stable route.

	-hpa
