From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Revert "cpupower Makefile change to help run the tool without 'make install'"
Date: Thu, 12 Mar 2015 23:38:14 +0100
Message-ID: <2850879.eZiuZCSV0J@vostro.rjw.lan>
References: <20150311002635.GC8393@hansolo.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50414 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751317AbbCLWO1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 18:14:27 -0400
In-Reply-To: <20150311002635.GC8393@hansolo.redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Thomas Renninger <trenn@suse.de>, "sriram@marirs.net.in" <sriram@marirs.net.in>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Tuesday, March 10, 2015 08:26:36 PM Josh Boyer wrote:
> This reverts commit 5c1de006e8e66b0be05be422416629e344c71652.
> 
> While the original commit makes it easier to run cpupower from the local build
> directory, it also leaves the binary with a rather poor rpath of './' in it
> after it is installed on a system via 'make install'.
> 
> This is considered bad practice and can cause cpupower to fail in rpmbuild
> with the following error:
> 
> ERROR   0004: file '/usr/bin/cpupower' contains an insecure rpath './' in [./]
> error: Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
>     Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
> 
> Developers should be able to use LD_LIBRARY_PATH to achieve the same effect
> and not introduce rpath into the binary.
> 
> Signed-off-by: Josh Boyer <jwboyer@feoraproject.org>

Queued up for 4.0-rc4, thanks!

> ---
>  tools/power/cpupower/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 3ed7c0476d48..2e2ba2efa0d9 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -209,7 +209,7 @@ $(OUTPUT)%.o: %.c
>  
>  $(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
>  	$(ECHO) "  CC      " $@
> -	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower -Wl,-rpath=./ -lrt -lpci -L$(OUTPUT) -o $@
> +	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower -lrt -lpci -L$(OUTPUT) -o $@
>  	$(QUIET) $(STRIPCMD) $@
>  
>  $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
