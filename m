From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 2/8] lib/iomap_copy: add __ioread64_copy()
Date: Fri, 12 Jan 2018 13:24:16 -0800
Message-ID: <20180112212422.148625-3-dbasehore@chromium.org>
References: <20180112212422.148625-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112212422.148625-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

Some drivers will want to read IO memory 64 bits at a time. Add an API
for this.

The 64-bit vs. 32-bit behavior is the same as the existing
__iowrite64_copy(), where we don't expect to need to (or be able to)
write in 64-bit chunks, so we fall back to a 32-bit equivalent.

Change-Id: Ia681f60bb98a0c6107052bccbeb5032861a93a0b
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 include/linux/io.h |  1 +
 lib/iomap_copy.c   | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index 32e30e8fb9db..53c34a0d65f7 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -31,6 +31,7 @@ struct resource;
 __visible void __iowrite32_copy(void __iomem *to, const void *from, size_t count);
 void __ioread32_copy(void *to, const void __iomem *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
+void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
 #ifdef CONFIG_MMU
 int ioremap_page_range(unsigned long addr, unsigned long end,
diff --git a/lib/iomap_copy.c b/lib/iomap_copy.c
index b8f1d6cbb200..71c137ede5fb 100644
--- a/lib/iomap_copy.c
+++ b/lib/iomap_copy.c
@@ -89,3 +89,29 @@ void __attribute__((weak)) __iowrite64_copy(void __iomem *to,
 }
 
 EXPORT_SYMBOL_GPL(__iowrite64_copy);
+
+/**
+ * __ioread64_copy - copy data from MMIO space, in 64-bit units
+ * @to: destination (must be 64-bit aligned)
+ * @from: source, in MMIO space (must be 64-bit aligned)
+ * @count: number of 64-bit quantities to copy
+ *
+ * Copy data from MMIO space to kernel space, in units of 64 bits at a time if
+ * on a 64-bit system.  32-bit systems will fall back to 32 bits at a time.
+ * Order of access is not guaranteed, nor is a memory barrier performed
+ * afterwards.
+ */
+void __ioread64_copy(void *to, const void __iomem *from, size_t count)
+{
+#ifdef CONFIG_64BIT
+	u64 *dst = to;
+	const u64 __iomem *src = from;
+	const u64 __iomem *end = src + count;
+
+	while (src < end)
+		*dst++ = __raw_readq(src++);
+#else
+	__ioread32_copy(to, from, count * 2);
+#endif
+}
+EXPORT_SYMBOL_GPL(__ioread64_copy);
-- 
2.16.0.rc1.238.g530d649a79-goog
