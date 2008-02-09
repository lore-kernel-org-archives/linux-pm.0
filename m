From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.25-rc0 (#2)
Date: Sat, 9 Feb 2008 11:42:17 +0000
Message-ID: <200802091142.18596.carlos__14607.2928364903$1202557847$gmane$org@strangeworlds.co.uk>
References: <200802080145.16774.lenb@kernel.org>
	<20080209061718.GA14200@elte.hu> <20080209061936.GA16849@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080209061936.GA16849@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 09 February 2008 06:19:36 Ingo Molnar wrote:
> (Carlos Cc:-ed too)
>
> * Ingo Molnar <mingo@elte.hu> wrote:
> > * Len Brown <lenb@kernel.org> wrote:
> > > Len Brown (6):
> > >       ACPI: add newline to printk
> > >       ACPI: build WMI on X86 only
> > >       acer-wmi, tc1100-wmi: select ACPI_WMI
> >
> > hm, this new WMI code caused a bootup crash in the overnight x86.git
> > tests:

I suspect this is a problem on systems without ACPI-WMI in the DSDT - though I 
can't reproduce this here on my other box that lacks ACPI-WMI.

Ingo, can you try the patch below and see if this cures it?
---
ACPI: WMI: Fix crash on WMI free systems

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

We have two pointers in the find_guid() code that aren't checked before
we use them. On ACPI-WMI free systems, this can sometimes cause a crash if
another driver tries to use any of the methods provided by WMI.

Also throw in an extra early check to see if the GUID list is empty, so we
can try to bail out before reaching this code as well.

Spotted by Ingo Molnar.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Len Brown <lenb@kernel.org>
---

 drivers/acpi/wmi.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)


diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index 36b84ab..b54e734 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -201,12 +201,20 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	struct guid_block *block;
 	struct list_head *p;
 
+	if (list_empty(&wmi_blocks.list))
+		return 0;
+
 	wmi_parse_guid(guid_string, tmp);
 	wmi_swap_bytes(tmp, guid_input);
 
 	list_for_each(p, &wmi_blocks.list) {
 		wblock = list_entry(p, struct wmi_block, list);
+		if (!wblock)
+			return 0;
+
 		block = &wblock->gblock;
+		if (!block)
+			return 0;
 
 		if (memcmp(block->guid, guid_input, 16) == 0) {
 			if (out)
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
