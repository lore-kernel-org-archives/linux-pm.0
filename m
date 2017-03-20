From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 01/10] linkage: new macros for assembler symbols
Date: Mon, 20 Mar 2017 13:32:13 +0100
Message-ID: <20170320123222.15453-1-jslaby@suse.cz>
References: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9ea5e137-61f9-dccc-bb9d-ac3ff86e5867@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, xen-devel@lists.xenproject.org
List-Id: linux-pm@vger.kernel.org

Introduce new C macros for annotations of functions and data in
assembly. There is a long-term mess in macros like ENTRY, END, ENDPROC
and similar. They are used in different manners and sometimes
incorrectly.

So introduce macros with clear use to annotate assembly as follows:

a) Support macros
   SYM_T_FUNC -- type used by assembler to mark functions
   SYM_T_OBJECT -- type used by assembler to mark data

   They are defined as STT_FUNC and STT_OBJECT respectively. According
   to the gas manual, this is the most portable way. I am not sure about
   other assemblers, so we can switch this back to %function and %object
   if this turns into a problem. Architectures can also override them by
   something like ", @function" if need be.

   SYM_A_ALIGN, SYM_A_NOALIGN -- should we align the symbol?
   SYM_V_GLOBAL, SYM_V_WEAK, SYM_V_LOCAL -- visibility of symbols
b) Mostly internal annotations, used by the ones below
   SYM_START -- use only if you have to
   SYM_END -- use only if you have to
c) Generic annotations
d) Annotations for code
   SYM_FUNC_START_LOCAL_ALIAS -- use where there are two local names for
	one code
   SYM_FUNC_START_ALIAS -- use where there are two global names for one
	code
   SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed code

   SYM_FUNC_START -- use for global functions
   SYM_FUNC_START_LOCAL -- use for local functions
   SYM_FUNC_START_WEAK -- use for weak functions
   SYM_FUNC_END -- the end of SYM_FUNC_START_LOCAL, SYM_FUNC_START,
	SYM_FUNC_START_WEAK, ...

   SYM_FUNC_INNER_LABEL -- only for global labels in the middle of
	functions
d) For data
   SYM_DATA_START -- global data symbol
   SYM_DATA_END -- the end of SYM_DATA_START symbol

==========

Note that SYM_FUNC_START_WEAK aligns symbols now too.

The macros allow to pair starts and ends of functions and mark function
correctly in the output ELF objects. This will also help a lot to
generate DWARF information automatically during build of asm.

Finally, all users of the old macros will be converted to use these
later.

[v2]
* use SYM_ prefix and sane names
* add SYM_START and SYM_END and parametrize all the macros

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: hpa@zytor.com
Cc: Ingo Molnar <mingo@kernel.org>
Cc: jpoimboe@redhat.com
Cc: Juergen Gross <jgross@suse.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: mingo@redhat.com
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: x86@kernel.org
---
 arch/x86/include/asm/linkage.h |   5 +-
 include/linux/linkage.h        | 131 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 0ccb26dda126..a96f6fc36011 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -12,9 +12,8 @@
 
 #ifdef __ASSEMBLY__
 
-#define GLOBAL(name)	\
-	.globl name;	\
-	name:
+/* deprecated, use SYM_DATA_START, SYM_FUNC_START, or SYM_FUNC_INNER_LABEL */
+#define GLOBAL(name)	SYM_DATA_START(name)
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
 #define __ALIGN		.p2align 4, 0x90
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index a6a42dd02466..c1dc824d2bc6 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -74,25 +74,46 @@
 
 #ifdef __ASSEMBLY__
 
+/* SYM_T_FUNC -- type used by assembler to mark functions */
+#ifndef SYM_T_FUNC
+#define SYM_T_FUNC				STT_FUNC
+#endif
+
+/* SYM_T_OBJECT -- type used by assembler to mark data */
+#ifndef SYM_T_OBJECT
+#define SYM_T_OBJECT				STT_OBJECT
+#endif
+
+/* SYM_A_* -- should we align the symbol? */
+#define SYM_A_ALIGN				ALIGN
+#define SYM_A_NOALIGN				/* nothing */
+
+/* SYM_V_* -- visibility of symbols */
+#define SYM_V_GLOBAL(name)			.globl name
+#define SYM_V_WEAK(name)			.weak name
+#define SYM_V_LOCAL(name)			/* nothing */
+
 #ifndef LINKER_SCRIPT
 #define ALIGN __ALIGN
 #define ALIGN_STR __ALIGN_STR
 
+/* === DEPRECATED annotations === */
+
 #ifndef ENTRY
+/* deprecated, use SYM_FUNC_START */
 #define ENTRY(name) \
-	.globl name ASM_NL \
-	ALIGN ASM_NL \
-	name:
+	SYM_FUNC_START(name)
 #endif
 #endif /* LINKER_SCRIPT */
 
 #ifndef WEAK
+/* deprecated, use SYM_FUNC_START_WEAK */
 #define WEAK(name)	   \
-	.weak name ASM_NL   \
-	name:
+	SYM_FUNC_START_WEAK(name)
 #endif
 
 #ifndef END
+/* deprecated, use SYM_FUNC_END, SYM_DATA_END, or SYM_END */
 #define END(name) \
 	.size name, .-name
 #endif
@@ -102,9 +123,105 @@
  * static analysis tools such as stack depth analyzer.
  */
 #ifndef ENDPROC
+/* deprecated, use SYM_FUNC_END */
 #define ENDPROC(name) \
-	.type name, @function ASM_NL \
-	END(name)
+	SYM_FUNC_END(name)
+#endif
+
+/* === generic annotations === */
+
+/* SYM_START -- use only if you have to */
+#ifndef SYM_START
+#define SYM_START(name, align, visibility)		\
+	visibility(name) ASM_NL				\
+	align ASM_NL					\
+	name:
+#endif
+
+/* SYM_END -- use only if you have to */
+#ifndef SYM_END
+#define SYM_END(name, sym_type)				\
+	.type name sym_type ASM_NL			\
+	.size name, .-name
+#endif
+
+/* === code annotations === */
+
+/* SYM_FUNC_START_LOCAL_ALIAS -- use where there are two local names for one code */
+#ifndef SYM_FUNC_START_LOCAL_ALIAS
+#define SYM_FUNC_START_LOCAL_ALIAS(name)		\
+	SYM_START(name, SYM_A_ALIGN, SYM_V_LOCAL)
+#endif
+
+/* SYM_FUNC_START_ALIAS -- use where there are two global names for one code */
+#ifndef SYM_FUNC_START_ALIAS
+#define SYM_FUNC_START_ALIAS(name)			\
+	SYM_START(name, SYM_A_ALIGN, SYM_V_GLOBAL)
+#endif
+
+/* SYM_FUNC_START -- use for global functions */
+#ifndef SYM_FUNC_START
+/*
+ * The same as SYM_FUNC_START_ALIAS, but we will need to distinguish these two
+ * later.
+ */
+#define SYM_FUNC_START(name)				\
+	SYM_START(name, SYM_A_ALIGN, SYM_V_GLOBAL)
+#endif
+
+/* SYM_FUNC_START_LOCAL -- use for local functions */
+#ifndef SYM_FUNC_START_LOCAL
+/* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
+#define SYM_FUNC_START_LOCAL(name)			\
+	SYM_START(name, SYM_A_ALIGN, SYM_V_LOCAL)
+#endif
+
+/* SYM_FUNC_START_WEAK -- use for weak functions */
+#ifndef SYM_FUNC_START_WEAK
+#define SYM_FUNC_START_WEAK(name)			\
+	SYM_START(name, SYM_A_ALIGN, SYM_V_WEAK)
+#endif
+
+/* SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed code */
+#ifndef SYM_FUNC_END_ALIAS
+#define SYM_FUNC_END_ALIAS(name)			\
+	SYM_END(name, SYM_T_FUNC)
+#endif
+
+/*
+ * SYM_FUNC_END -- the end of SYM_FUNC_START_LOCAL, SYM_FUNC_START,
+ * SYM_FUNC_START_WEAK, ...
+ */
+#ifndef SYM_FUNC_END
+/* the same as SYM_FUNC_END_ALIAS, see comment near SYM_FUNC_START */
+#define SYM_FUNC_END(name)				\
+	SYM_END(name, SYM_T_FUNC)
+#endif
+
+/* SYM_FUNC_INNER_LABEL -- only for global labels to the middle of functions */
+#ifndef SYM_FUNC_INNER_LABEL
+#define SYM_FUNC_INNER_LABEL(name)			\
+	SYM_START(name, SYM_A_NOALIGN, SYM_V_GLOBAL)
+#endif
+
+/* === data annotations === */
+
+/* SYM_DATA_START -- global data symbol */
+#ifndef SYM_DATA_START
+#define SYM_DATA_START(name)				\
+	SYM_START(name, SYM_A_NOALIGN, SYM_V_GLOBAL)
+#endif
+
+/* SYM_DATA_START -- local data symbol */
+#ifndef SYM_DATA_START_LOCAL
+#define SYM_DATA_START_LOCAL(name)			\
+	SYM_START(name, SYM_A_NOALIGN, SYM_V_LOCAL)
+#endif
+
+/* SYM_DATA_END -- the end of SYM_DATA_START symbol */
+#ifndef SYM_DATA_END
+#define SYM_DATA_END(name)				\
+	SYM_END(name, SYM_T_OBJECT)
 #endif
 
 #endif
-- 
2.12.0
