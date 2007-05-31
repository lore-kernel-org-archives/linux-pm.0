From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Thu, 31 May 2007 13:01:43 +0200 (CEST)
Message-ID: <tkrat.5b4ba1068f8b64ee__41131.4155710444$1180609379$gmane$org@s5r6.in-berlin.de>
References: <200705181207.45868.marcus@better.se>
	<200705210725.55299.marcus@better.se>
	<tkrat.e22d2cc8f9fe7f8a@s5r6.in-berlin.de>
	<200705311238.25399.marcus@better.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705311238.25399.marcus@better.se>
Content-Disposition: INLINE
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 31 May, Marcus Better wrote:
> I have trouble applying this patch, perhaps due to the encoding. Can you 
> resend it without quoted-printable? (Or am I doing something wrong?)
> 
> $ patch -p1 --dry-run < /home/marcus/fw.diff
> patching file drivers/firewire/fw-card.c
> patch: **** malformed patch at line 11: --- 408,407 ----
> 
> Marcus


If you have linux-2.6.22-rc1...-rc3 (not the latest -git), then you need
the following patch first in order to apply the suspend/resume patch
cleanly.  (I will follow up with a ASCIIfied version of the
suspend/resume patch.)


From: Kristian Hoegsberg <krh@redhat.com>
Subject: firewire: Add missing byteswapping for receive DMA programs.
Date: Tue, 22 May 2007 18:55:48 -0400

Signed-off-by: Kristian Hoegsberg <krh@redhat.com>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/firewire/fw-ohci.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.22-rc3/drivers/firewire/fw-ohci.c
===================================================================
--- linux-2.6.22-rc3.orig/drivers/firewire/fw-ohci.c
+++ linux-2.6.22-rc3/drivers/firewire/fw-ohci.c
@@ -268,7 +268,7 @@ static int ar_context_add_page(struct ar
 
 	dma_sync_single_for_device(dev, ab_bus, PAGE_SIZE, DMA_BIDIRECTIONAL);
 
-	ctx->last_buffer->descriptor.branch_address = ab_bus | 1;
+	ctx->last_buffer->descriptor.branch_address = cpu_to_le32(ab_bus | 1);
 	ctx->last_buffer->next = ab;
 	ctx->last_buffer = ab;
 
@@ -417,7 +417,8 @@ ar_context_init(struct ar_context *ctx, 
 	ctx->current_buffer = ab.next;
 	ctx->pointer = ctx->current_buffer->data;
 
-	reg_write(ctx->ohci, COMMAND_PTR(ctx->regs), ab.descriptor.branch_address);
+	reg_write(ctx->ohci, COMMAND_PTR(ctx->regs),
+		  le32_to_cpu(ab.descriptor.branch_address));
 	reg_write(ctx->ohci, CONTROL_SET(ctx->regs), CONTEXT_RUN);
 	flush_writes(ctx->ohci);
 




-- 
Stefan Richter
-=====-=-=== -=-= =====
http://arcgraph.de/sr/
