From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Wed, 01 Aug 2007 09:16:13 +0800
Message-ID: <1185930973.1363.1.camel__36296.29989523$1185931048$gmane$org@caritas-dev.intel.com>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070731091004.GA2022@elf.ucw.cz>
	<1185873924.23149.86.camel@caritas-dev.intel.com>
	<m17iogrgjw.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m17iogrgjw.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-07-31 at 04:52 -0600, Eric W. Biederman wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> > On Tue, 2007-07-31 at 11:10 +0200, Pavel Machek wrote:
> >> > Index: kexec-tools-1.101/kexec/arch/i386/crashdump-x86.c
> >> > ===================================================================
> >> > --- kexec-tools-1.101.orig/kexec/arch/i386/crashdump-x86.c 2007-07-08
> > 23:00:25.000000000 +0800
> >> > +++ kexec-tools-1.101/kexec/arch/i386/crashdump-x86.c 2007-07-14
> > 17:06:45.000000000 +0800
> >> > @@ -428,6 +428,29 @@
> >> >  	return 0;
> >> >  }
> >> >  
> >> > +/* Adds the kexec_backup= command line parameter to command line. */
> >> > +static int cmdline_add_backup(char *cmdline, unsigned long addr)
> >> > +{
> >> > +	int cmdlen, len, align = 1024;
> >> > +	char str[30], *ptr;
> >> > +
> >> > +	/* Passing in kexec_backup=xxxK format. Saves space required
> >> > +	 * in cmdline. Ensure 1K alignment*/
> >> > +	if (addr%align)
> >> > +		return -1;
> >> > +	addr = addr/align;
> >> > +	ptr = str;
> >> > +	strcpy(str, " kexec_backup=");
> >> > +	ptr += strlen(str);
> >> > +	ultoa(addr, ptr);
> >> > +	strcat(str, "K");
> >> > +	len = strlen(str);
> >> > +	cmdlen = strlen(cmdline) + len;
> >> > +	if (cmdlen > (COMMAND_LINE_SIZE - 1))
> >> > +		die("Command line overflow\n");
> >> > +	strcat(cmdline, str);
> >> > +	return 0;
> >> > +}
> >> 
> >> This part did not apply for me -- it seems crashdump related and I did
> >> not have that applied. Is it critical?
> >
> > This is needed for kexec_jump to work properly. Which version of
> > kexec-tools do you use? This patch is against 1.101. The kdump patch
> > must be applied before this patch is applied.
> 
> Please work against the kexec-tools-testing tree, if you can.
> All of the outstanding patches should be there.

OK, I will work against the kexec-tools-testing tree in the next
version.

Best Regards,
Huang Ying
