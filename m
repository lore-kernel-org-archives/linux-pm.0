From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [ACPI] Preserve ACPI NVS region over S3
Date: Fri, 28 May 2010 23:19:31 +0300
Message-ID: <1275077971.20606.20.camel__14374.4242181585$1275078333$gmane$org@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59-kernel@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

Hi,

I finally managed, to make S3 work.
The short story is that BIOS contains a bug, but it doesn't trip over it
due to windows non-conformance to ACPI.

The long story is that ACPI spec allows BIOS to declare a memory region
as a NVS (non volatile storage), and spec expects us to preserve it over
S4.

Linux does that, but now we know that windows does restore this region
over S3 too.

On my system BIOS changes this region slightly after a resume from S3,
and if S3 is attempted again, it hangs early before passing control to
linux.

The first patch (written by Matthew Garrett) makes this change.

I also add a patch that needs quite a lot of massage to apply after this
one, and somehow fell through the cracks. This patch fixes rare hang of
resume from disk. I rebased it on top of first patch.

Now, finally, after 2 years, both suspend & hibernate work reliably on
my laptop.

And thanks again for Matthew Garrett for verifying that indeed Windows
saves/restores the NVS region over S3.

Please let me know what you think.

Best regards,
Maxim Levitsky
