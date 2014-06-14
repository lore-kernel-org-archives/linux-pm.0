From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Sat, 14 Jun 2014 02:39:18 +0200
Message-ID: <13135927.OjVm86GPrt@vostro.rjw.lan>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org> <1517175.iyVMqh7r2z@vostro.rjw.lan> <CAGXu5jJSqV2MeuofJP4OEiDytQBqKMgC3cj+tguiwTmpRX1wSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJSqV2MeuofJP4OEiDytQBqKMgC3cj+tguiwTmpRX1wSQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 13, 2014 05:08:21 PM Kees Cook wrote:
> On Fri, Jun 13, 2014 at 5:14 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, June 13, 2014 03:59:57 PM Kees Cook wrote:
> >> On Fri, Jun 13, 2014 at 3:54 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Friday, June 13, 2014 03:07:19 PM Kees Cook wrote:
> >
> > [cut]
> >
> >> > I'll have a closer look at that shortly (it's been quite some time since
> >> > I wrote that code).
> >>
> >> Thanks; I'm trying to get a test environment instrumented too so I can
> >> look at this. (At the very least, it sounds like we'll still need my
> >> patch series for other architectures.)
> >
> > How can I obtain a kernel address of the beginning of a given page
> > (as represented by struct page) on x86_64 today?
> 
> I don't know off the top of my head. I've used virt_to_phys, but
> things like PFN_PHYS(page_to_pfn(page)) maybe? I'm not entirely clear
> which you need, but mm.h seems to have the bulk of what I've seen.

OK, I'm not sure how much sense this makes, but at least it should
illustrate the direction. :-)

---
 arch/x86/power/hibernate_64.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-pm/arch/x86/power/hibernate_64.c
===================================================================
--- linux-pm.orig/arch/x86/power/hibernate_64.c
+++ linux-pm/arch/x86/power/hibernate_64.c
@@ -115,7 +115,7 @@ struct restore_data_record {
 	unsigned long magic;
 };
 
-#define RESTORE_MAGIC	0x0123456789ABCDEFUL
+#define RESTORE_MAGIC	0x0123456789ABCDF0UL
 
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
@@ -128,7 +128,8 @@ int arch_hibernation_header_save(void *a
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
-	rdr->jump_address = restore_jump_address;
+
+	rdr->jump_address = virt_to_phys((void *)restore_jump_address);
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
 	return 0;
@@ -143,7 +144,7 @@ int arch_hibernation_header_restore(void
 {
 	struct restore_data_record *rdr = addr;
 
-	restore_jump_address = rdr->jump_address;
+	restore_jump_address = (unsigned long)phys_to_virt(rdr->jump_address);
 	restore_cr3 = rdr->cr3;
 	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
 }

