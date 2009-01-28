From: Pavel Machek <pavel@suse.cz>
Subject: Re: ACPI problems
Date: Wed, 28 Jan 2009 10:31:26 +0100
Message-ID: <20090128093126.GB27210@elf.ucw.cz>
References: <OF4D703E0A.5965F4D6-ON6525754C.0031E37A-6525754C.0031E39D@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <OF4D703E0A.5965F4D6-ON6525754C.0031E37A-6525754C.0031E39D@tcs.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mohd.adil@tcs.com
Cc: majordomo@vger.kernel.org, linux-pm@lists.osdl.org, acpi-bugzilla-request@lists.sourceforge.net, linux-pm-devel-request@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wed 2009-01-28 14:34:55, mohd.adil@tcs.com wrote:
>    Hi Pavel,
> 
>                   Thanks for the response.
> 
>                    Yes, for the solution we are trying to develop, we do
>    not care about the resume. We just put system to S3 and rest is taken
>    care by BIOS.
> 
>                     The bug was actually on 2.6.24.
>    [1]http://bugzilla.kernel.org/show_bug.cgi?id=9528

You really want to try that on recent kernel.

>                      I am also attaching the code I have written to
>    extract some ACPI variable information. Please have a look.
> 
>    Mohd. Adil
>    Tata Consultancy Services
>    Mailto: mohd.adil@tcs.com
>    Website: [2]http://www.tcs.com
>    ____________________________________________
>    Experience certainty. IT Services
>    Business Solutions
>    Outsourcing
>    ____________________________________________
> 
>                         Pavel Machek <pavel@suse.cz>
> 
>                             01/27/2009 23:53 CET
> 
>                                                                         To
> 
>    mohd.adil@tcs.com
> 
>                                                                         cc
> 
>    majordomo@vger.kernel.org, acpi-bugzilla-request@lists.sourceforge.net,
>    linux-pm-devel-request@lists.sourceforge.net, linux-pm@lists.osdl.org
> 
>                                                                        bcc
> 
>                                                                    Subject
> 
>    Re: [linux-pm] ACPI problems
> 
>    On Wed 2009-01-21 15:22:20, mohd.adil@tcs.com wrote:
>    >    Hi
>    >
>    >                This is my first post to the list. Hope I will find a
>    >    solution.
>    Please avoid using html on the lists.
>    >                I am trying to develop a new functionality using a Sun
>    >    alonso Quad Core blade (x86_64) architecture.
>    >
>    >                 The linux distribution which I am using contains a
>    very
>    >    old acpi driver (02/09/2005 probably acpi version 1 compliant)
>    >
>    >                Further, the BIOS I am using is an AMI BIOS.  I am
>    fairly
>    >    certain that it is acpi version 3 compliant.
>    Famous last words.
>    >                 Now, I am facing two problems here.
>    >
>    >                1)  I am trying to evaluate some namespace control
>    methods
>    >    which are setup in sytem DSDT.
>    >
>    >                     Functions are :
>    >
>    >                      [1]\\_SB.PERB (should contain memory location
>    >    address) and
>    >
>    >                      [2]\\_SB.PERL   (should contain length)
>    >
>    >                     This some information passed to us from BIOS
>    which is
>    >    required for my development.
>    >
>    >                     I am using acpi_evaluate_object to evaluate these
>    >    functions. I dont see any error in executing the evaluate
>    >
>    >                    function call. But they evaluate to zero.
>    Hmm, this is hard to debug without seeing the source.
>    >                 2)   The second task I have is to put the system into
>    S3
>    >    (suspend to ram) state.
>    >
>    >                       While doing that I am experiencing a problem.
>    Every
>    >    time I write
>    >
>    >                        echo mem > /sys/power/state
>    >
>    >                       System hangs at METHOD_NAME__PTS method. There
>    is a
>    >    related bug in
>    >
>    >                      new acpi driver related to this function. But
>    since I
>    >    am using a very old driver this should not have
>    >                      happened.
>    Which kernel version?
>    >                      Just for added information : I dont really care
>    about
>    >    resume from the S3 state. I dont have video card.
>    You want to suspend but don't care about resume...?!
>    Pavel
>    --
>    (english) [3]http://www.livejournal.com/~pavelmachek
>    (cesky, pictures)
>    [4]http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>    ForwardSourceID:NT000197CA
> =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain
> confidential or privileged information. If you are
> not the intended recipient, any dissemination, use,
> review, distribution, printing or copying of the
> information contained in this e-mail message
> and/or attachments to it are strictly prohibited. If
> you have received this communication in error,
> please notify us by reply e-mail or telephone and
> immediately and permanently delete the message
> and any attachments. Thank you
> 
> References
> 
>    1. http://bugzilla.kernel.org/show_bug.cgi?id=9528
>    2. http://www.tcs.com/
>    3. http://www.livejournal.com/~pavelmachek
>    4. http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

> /* A simple linux kernel module */
> 
> /* Include the required headers */
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/acpi.h>
> #include <linux/slab.h>
> #include <asm/uaccess.h>
> #include <asm/rtc.h>
> 
> void do_acpi_stuff( void );
> void print_acpi_buffer (acpi_string);
> void print_acpi_int (acpi_string);
> void print_acpi_string  (acpi_string);
> void print_acpi_int2 (acpi_string);
> void print_acpi_integer (acpi_string);
> void print_acpi_string2  (acpi_string);
> void setup_pmem_reboot (void);
> void unsetup_pmem_reboot (void);
> void show_cmos (void);
> void cmos_setsize(void);
> 
> MODULE_PARM_DESC(choice, "A short integer");
> MODULE_PARM_DESC(data, "Unsigned Long");
> 
> static short choice = 0;
> static long data = 0;
> 
> module_param(choice , short, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
> module_param(data , long, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
> 
> /* The module initialisation function */
> int init_module(void)
> {
> 
>         printk(KERN_EMERG "Simple module inserted. Choice = %d, Data = %X \n", choice, data);
> 
>         /* extracting acpi namespace information */
>         switch ( choice ) {
>         case 1 : show_cmos();
>                  break ;
> 
>         case 2 : setup_pmem_reboot();
>                  break ;
> 
>         case 3 : unsetup_pmem_reboot();
>                  break ;
> 
>         case 4 : cmos_setsize();
>                  break ;
> 
>         case 5 : do_acpi_stuff();
>                  break ;
> 
>         default :  printk(KERN_EMERG "Invalid choice" );
>                  break;
>         }
> 
>         return 0;
> }
> 
> /* The module cleanup function */
> void cleanup_module()
> {
>         printk(KERN_EMERG "Removing simple module.\n");
> }
> 
> void setup_pmem_reboot (void)
> {
>         int temp = 0;
>         outb ( 0xDD, 0x72);
>         temp = inb ( 0x73 );
>         printk(KERN_EMERG "Pmem_reboot = %d ", temp );
>         temp = temp | 0x10 ;
>         printk(KERN_EMERG "Pmem_reboot = %d ", temp );
>         outb (0xDD, 0x72);
>         outb (temp , 0x73 );
> }
> void show_cmos (void)
> {
>         unsigned int temp = 0;
>         outb ( 0xDD, 0x72);
>         temp = inb ( 0x73 );
>         printk(KERN_EMERG "Pmem_reboot = %d ", temp );
>         outb ( 0xCB, 0x72);
>         temp = inb ( 0x73 );
>         printk(KERN_EMERG "Size = %d ", temp );
> }
> void unsetup_pmem_reboot (void)
> {
>         unsigned int temp = 0;
>         outb ( 0xDD, 0x72);
>         temp = inb ( 0x73 );
>         printk(KERN_EMERG "Pmem_reboot = %d ", temp );
>         temp = temp & 0xEF ;
>         outb (0xDD, 0x72);
>         outb (temp , 0x73 );
>         printk(KERN_EMERG "Pmem_reboot = %d ", temp );
> }
> void cmos_setsize(void)
> {
>         unsigned int temp = 0;
>         outb ( 0xCB, 0x72);
>         temp = inb ( 0x73 );
>         printk(KERN_EMERG "Size = %d ", temp );
>         outb ( 0xCB, 0x72);
>         outb ( data,  0x73);
>         printk(KERN_EMERG "Size = %d ", temp );
> }
> void do_acpi_stuff( void )
> {
> 
>         print_acpi_buffer ("\\_SB.PERB");
>         print_acpi_integer ("\\_SB.PERL");
> }
> void print_acpi_integer (acpi_string astr) {
> 
>         acpi_handle s_b = (acpi_handle)0 ;
>         acpi_status status ;
>         unsigned long dat = 0;
> 
>         status = acpi_get_handle ( 0, astr, &s_b );
>         if (status == AE_OK)
>         {
>                 printk(KERN_EMERG " get_handle success %d, %x : ", status, s_b);
>                 status = acpi_evaluate_integer ( s_b, astr, NULL, &dat);
>                 if (status == AE_OK)
>                         printk(KERN_EMERG " Integer Value = %d " , dat ) ;
>                 else
>                         printk(KERN_EMERG " Error  evaluation %d " , status);
>         }
>         else
>                 printk(KERN_EMERG " get_handle error %d : ", status );
> }
> 
> void print_acpi_buffer (acpi_string astr)
> {
> 
>         acpi_handle s_b = (acpi_handle)0 ;
>         acpi_status status ;
>         struct acpi_buffer rels = { 0, NULL };
>         union acpi_object *out_objs;
>         u8 *cp ;
>         int i;
> 
>         out_objs =  kmalloc (sizeof(union acpi_object), GFP_KERNEL);
>         if ( !out_objs)
>         {
>                 printk(KERN_EMERG " Could Not allocate memory rels pointer , buffer ");
>                 return;
>         }
>         status = acpi_get_handle ( 0, astr, &s_b );
>         if (status == AE_OK)
>         {
>                 printk(KERN_EMERG " get_handle success %d, %x : ", status, s_b);
> 
>                 memset(out_objs, 0, sizeof(union acpi_object));
>                 rels.length = 2 * (sizeof(union acpi_object));
>                 rels.pointer = out_objs;
>                 status = acpi_evaluate_object(s_b, NULL , NULL, &rels);
>                 if (status == AE_OK)
>                 {
>                         printk(KERN_EMERG " eval_object buffer success.result: %d, %d ", out_objs->type,  rels.length );
>                         cp  = (u8 *)(out_objs->buffer.pointer) ;
>                         for (i = 0; i< out_objs->buffer.length ;  i++) {
> 
>                                 printk(KERN_EMERG " %X", cp[i]);
>                         }
> 
>                 }
>                 else
>                 {
>                         printk(KERN_EMERG " error %d : ", status);
>                         printk(KERN_EMERG " result buffer : %d " , (int)rels.length);
>                 }
>         }
>         else
>                 printk(KERN_EMERG " get_handle error %d : ", status );
> 
> kfree (out_objs);
> }
> 
> void print_acpi_int (acpi_string astr)
> {
>         acpi_handle *s_b;
>         acpi_status status ;
>         struct acpi_buffer *rels;
>         union acpi_object *out_objs;
> 
>         s_b = kmalloc ( sizeof (acpi_handle),  GFP_KERNEL);
>         if (!s_b)
>         {
>                 printk(KERN_EMERG " Could Not allocate memory s_b , int ");
>                 return;
>         }
>         rels = kmalloc ( sizeof (struct acpi_buffer) , GFP_KERNEL);
>         if ( !rels)
>         {
>                 printk(KERN_EMERG " Could Not allocate memory rels , int");
>                 return;
>         }
>         rels->pointer =  kmalloc ( sizeof(union acpi_object), GFP_KERNEL);
>         if ( !rels->pointer)
>         {
>                 printk(KERN_EMERG " Could Not allocate memory rels pointer , int");
>                 return;
>         }
> 
>         status = acpi_get_handle ( 0, astr, &s_b );
>         if (status == AE_OK)
>         {
>                 printk(KERN_EMERG "get_handle success %d, %d : ", status, *s_b);
>                 rels->length = sizeof(union acpi_object);
>                 status = acpi_evaluate_object(*s_b, 0, 0, rels);
>                 out_objs = (union acpi_object *) rels->pointer;
>                 if (status == AE_OK)
>                 {
>                         printk(KERN_EMERG " eval_object int success. result  : %d, %d, ", out_objs->type, rels->length );
>                         printk(KERN_EMERG "Int value = %d", out_objs->integer.value  );
>                 }
>                 else
>                 {
>                         printk(KERN_EMERG " error %d : ", status);
>                 }
>         }
>         else
>                 printk(KERN_EMERG " get_handle error %d : ", status);
> 
> 
> kfree (rels->pointer);
> kfree (rels);
> kfree (s_b);
> }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
