From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Tue, 01 Jul 2008 10:28:48 -0700
Message-ID: <486A6950.6050507__6817.51883025772$1214933497$gmane$org@zytor.com>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu>
	<4869D67B.4060902@zytor.com> <486A2AC3.2060107@firstfloor.org>
	<486A5378.7020601@zytor.com> <486A5977.8020905@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <486A5977.8020905@firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Andi Kleen wrote:
> H. Peter Anvin wrote:
>> Andi Kleen wrote:
>>>> It still seems incredibly risky to push this for 2.6.26, especially
>>>> given the Elan revelation.
>>> Do Elans even support S3?
>> I don't know if they do, but I don't know offhand the extent of machines
>> that may have that problem, especially since Intel now document it as
>> "failures are readily seen".
> 
> What document is that exactly?
> 

Per Jeremy's recent email, volume 3a, section 8.9.1:

>    Random failures can occur if other instructions exist between steps
>    3 and 4 above.  Failures will be readily seen in some situations,
>    such as when instructions that reference memory are inserted between
>    steps 3 and 4 while in system management mode. 

	-hpa
