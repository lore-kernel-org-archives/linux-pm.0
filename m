From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Sat, 12 Jul 2008 14:08:35 +0200
Message-ID: <48789EC3.2070701__37939.7651217461$1215864670$gmane$org@firstfloor.org>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu>
	<4869D4A3.3020000@zytor.com> <200807012239.44105.rjw@sisk.pl>
	<486A96C1.2020106@firstfloor.org> <48784F51.1010407@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48784F51.1010407@myrealbox.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@myrealbox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Andy Lutomirski wrote:
> My Lenovo X61s fails to resume if I suspend it from within X, on both
> 2.6.26-rc9 and recent wireless-testing.  2.6.26-rc8 is fine, as is
> wireless-testing with 4b4f7280 reverted.  My in-progress bisect between
> -rc8 and -rc9 is also consistent with this being the problem.

With "this" do you mean the patch being applied or not applied?

As in does it fail with the patch applied?

You can confirm that by only applying the patch and testing.

-Andi
