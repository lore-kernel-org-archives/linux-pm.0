From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH][v5] PM / hibernate: Print the possible panic reason when
 resuming with inconsistent e820 map
Date: Thu, 15 Oct 2015 05:04:50 +0800
Message-ID: <201510150524.FNlN97gI%fengguang.wu@intel.com>
References: <1444849196-7048-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444849196-7048-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, pavel@ucw.cz, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, len.brown@intel.com, rui.zhang@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chen,

[auto build test ERROR on tip/x86/core -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu/PM-hibernate-Print-the-possible-panic-reason-when-resuming-with-inconsistent-e820-map/20151015-030054
config: um-x86_64_defconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All error/warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/suspend_64.h:9:0,
                    from arch/x86/include/asm/suspend.h:4,
                    from include/linux/suspend.h:11,
                    from drivers/base/syscore.c:12:
>> arch/x86/um/asm/desc.h:6:0: warning: "LDT_empty" redefined
    #define LDT_empty(info) (\
    ^
   In file included from arch/um/include/asm/mmu.h:10:0,
                    from include/linux/mm_types.h:16,
                    from include/linux/sched.h:27,
                    from include/linux/cgroup.h:11,
                    from include/linux/memcontrol.h:22,
                    from include/linux/swap.h:8,
                    from include/linux/suspend.h:4,
                    from drivers/base/syscore.c:12:
   arch/x86/um/asm/mm_context.h:63:0: note: this is the location of the previous definition
    #define LDT_empty(info) (_LDT_empty(info) && ((info)->lm == 0))
    ^
   In file included from arch/x86/include/asm/suspend.h:4:0,
                    from include/linux/suspend.h:11,
                    from drivers/base/syscore.c:12:
>> arch/x86/include/asm/suspend_64.h:29:18: error: field 'gdt_desc' has incomplete type
     struct desc_ptr gdt_desc;
                     ^
>> arch/x86/include/asm/suspend_64.h:46:13: error: 'restore_registers' redeclared as different kind of symbol
    extern char restore_registers;
                ^
   In file included from arch/um/include/asm/processor-generic.h:14:0,
                    from arch/x86/um/asm/processor.h:33,
                    from arch/x86/include/asm/atomic.h:6,
                    from include/linux/atomic.h:4,
                    from include/linux/mutex.h:18,
                    from drivers/base/syscore.c:10:
   arch/um/include/shared/registers.h:17:12: note: previous declaration of 'restore_registers' was here
    extern int restore_registers(int pid, struct uml_pt_regs *regs);
               ^
   In file included from drivers/base/syscore.c:12:0:
   include/linux/suspend.h:366:20: error: static declaration of 'arch_image_info_check' follows non-static declaration
    static inline bool arch_image_info_check(const char *new,
                       ^
   In file included from include/linux/suspend.h:11:0,
                    from drivers/base/syscore.c:12:
   arch/x86/include/asm/suspend.h:8:13: note: previous declaration of 'arch_image_info_check' was here
    extern bool arch_image_info_check(const char *new, const char *old);
                ^
   In file included from drivers/base/syscore.c:12:0:
   include/linux/suspend.h:372:19: error: static declaration of 'arch_image_info_save' follows non-static declaration
    static inline int arch_image_info_save(char *dst,
                      ^
   In file included from include/linux/suspend.h:11:0,
                    from drivers/base/syscore.c:12:
   arch/x86/include/asm/suspend.h:7:12: note: previous declaration of 'arch_image_info_save' was here
    extern int arch_image_info_save(char *dst, char *src, unsigned int limit_len);
               ^

vim +/gdt_desc +29 arch/x86/include/asm/suspend_64.h

^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  23  	unsigned long gs_base, gs_kernel_base, fs_base;
8d783b3e include/asm-x86_64/suspend.h      Pavel Machek          2005-06-25  24  	unsigned long cr0, cr2, cr3, cr4, cr8;
85a0e753 arch/x86/include/asm/suspend_64.h Ondrej Zary           2010-06-08  25  	u64 misc_enable;
85a0e753 arch/x86/include/asm/suspend_64.h Ondrej Zary           2010-06-08  26  	bool misc_enable_saved;
3c321bce include/asm-x86_64/suspend.h      Vivek Goyal           2007-05-02  27  	unsigned long efer;
cc456c4e arch/x86/include/asm/suspend_64.h Konrad Rzeszutek Wilk 2013-05-01  28  	u16 gdt_pad; /* Unused */
cc456c4e arch/x86/include/asm/suspend_64.h Konrad Rzeszutek Wilk 2013-05-01 @29  	struct desc_ptr gdt_desc;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  30  	u16 idt_pad;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  31  	u16 idt_limit;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  32  	unsigned long idt_base;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  33  	u16 ldt;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  34  	u16 tss;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  35  	unsigned long tr;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  36  	unsigned long safety;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  37  	unsigned long return_address;
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  38  } __attribute__((packed));
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  39  
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  40  #define loaddebug(thread,register) \
2b514e74 include/asm-x86_64/suspend.h      Jan Beulich           2006-03-25  41  	set_debugreg((thread)->debugreg##register, register)
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  42  
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  43  /* routines for saving/restoring kernel state */
^1da177e include/asm-x86_64/suspend.h      Linus Torvalds        2005-04-16  44  extern int acpi_save_state_mem(void);
d158cbdf include/asm-x86/suspend_64.h      Rafael J. Wysocki     2007-10-18  45  extern char core_restore_code;
d158cbdf include/asm-x86/suspend_64.h      Rafael J. Wysocki     2007-10-18 @46  extern char restore_registers;
0de80bcc include/asm-x86/suspend_64.h      Rafael J. Wysocki     2007-10-23  47  
1965aae3 arch/x86/include/asm/suspend_64.h H. Peter Anvin        2008-10-22  48  #endif /* _ASM_X86_SUSPEND_64_H */

:::::: The code at line 29 was first introduced by commit
:::::: cc456c4e7cac3837a86aaa7ca3cb9f488d44d196 x86, gdt, hibernate: Store/load GDT for hibernate path.

:::::: TO: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
:::::: CC: H. Peter Anvin <hpa@linux.intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--zhXaljGHf11kAtnf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ZAAA

--zhXaljGHf11kAtnf--
