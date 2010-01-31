From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [RFC][RFT][PATCH] ACPI: Protection from suspending
	in the middle of EC transaction
Date: Sun, 31 Jan 2010 14:11:21 +0000
Message-ID: <9b2b86521001310611m339862afw73410dc7eb5692c8__42196.3113164113$1264947272$gmane$org@mail.gmail.com>
References: <201001310029.48717.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001310029.48717.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On 1/30/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> While Maxim is testing if the patch below helps with
> http://bugzilla.kernel.org/show_bug.cgi?id=14668
> I think it's necessary anyway.
>
> The problem is that currently there's nothing to prevent us from suspending
> in
> the middle of an EC transaction in progress, at least as far as I can see.
> As a result, we can suspend with the ACPI global lock held or something like
> this, which leads to problems especially for hibernation (if the resume
> kernel
> passes control to the image kernel in the middle of an EC transaction,
> things
> aren't nice).  For this reason I think we should wait until there are no EC
> transactions in progress before we suspend and we should prevent any new
> EC transactions from starting after that point.  The patch below does that.

I also believe this is a problem.  I reported the following -

<http://bugzilla.kernel.org/show_bug.cgi?id=14112> "Pressing acpi
hotkeys duing hibernation may occasionally cause EC transaction
timeout"

and posted a patch, but I couldn't reproduce my specific issue in
order to confirm that the patch helped.

Regards
Alan
