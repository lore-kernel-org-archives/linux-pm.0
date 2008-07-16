From: "Andrew Lutomirski" <luto@myrealbox.com>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Wed, 16 Jul 2008 10:13:54 -0400
Message-ID: <cb0375e10807160713r5aa2bb82md1e0b3b349ca8115__18110.6749842458$1216220012$gmane$org@mail.gmail.com>
References: <200807010148.02135.rjw@sisk.pl> <487A2431.2050103@myrealbox.com>
	<487A4CB7.1080001@firstfloor.org> <200807132115.08230.rjw@sisk.pl>
	<487A617B.80707@firstfloor.org> <487A67C3.50000@zytor.com>
	<487AD37A.2050903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <487AD37A.2050903@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Sorry for the delay in testing.  This appears to work and fix the problem.

--Andy

On Mon, Jul 14, 2008 at 12:18 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> H. Peter Anvin wrote:
>>
>> The most likely explanation for this is that the VESA BIOS expects to be
>> entered in Big Real Mode (*.limit = 0xffffffff) instead of ordinary Real
>> Mode.  Here is a completely untested patch which changes the segment
>> descriptors to Big Real Mode instead.  It would be worth testing out.
>>
>
> ... and here is one that actually has a prayer of actually working.
>
>        -hpa
>
>
> --- AV & Spam Filtering by M+Guardian - Risk Free Email (TM) ---
>
