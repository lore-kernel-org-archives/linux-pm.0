From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Tue, 01 Jul 2008 22:52:07 +0200
Message-ID: <486A98F7.1080203__26527.8899846182$1214945732$gmane$org@firstfloor.org>
References: <200807010148.02135.rjw@sisk.pl> <200807012239.44105.rjw@sisk.pl>
	<486A96C1.2020106@firstfloor.org> <200807012250.39930.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807012250.39930.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday, 1 of July 2008, Andi Kleen wrote:
>>> I have tested it on the nx6325 (64-bit) on top of the today's linux-next.  It
>>> works fine for me.
>> Could a few more people with different laptops please test too?
> 
> Well, I think we can put it into the 2.6.27 queue in the hope it gets more
> testing in linux-next over time.

I'm just not sure how many people really put linux-next on their laptops.
Better would be some directed testing.

We'll see if that kernel-testers list actually does something or is just a placebo.

-Andi
