From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower: Install cpupower.h as a public header file
Date: Tue, 17 Oct 2017 10:29:23 +0200
Message-ID: <2594649.cpXK6EFXZg@skinner>
References: <20171016185004.zyq6eugwedc34f7l@mitya57.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38821 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753167AbdJQI30 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Oct 2017 04:29:26 -0400
In-Reply-To: <20171016185004.zyq6eugwedc34f7l@mitya57.me>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Shachnev <mitya57@debian.org>
Cc: linux-pm@vger.kernel.org

On Monday, October 16, 2017 09:50:04 PM Dmitry Shachnev wrote:
> This helps software that uses cpupower_is_cpu_online function, such as
> gnome-applets.

Can you give it a try or confirm that the CPU topology list/functions also 
work as intended if used as an external library, please.
And whether they are written to be easily used and understood or whether
the interface could still be enhanced.

If things work as expected by others, it's certainly a good idea to publish 
these.

Thanks,

     Thomas

> 
> Signed-off-by: Dmitry Shachnev <mitya57@debian.org>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=153161
> ---
>  tools/power/cpupower/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 4c5a481a850c..113e14983c7d 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -278,6 +278,7 @@ install-lib:
>  	$(INSTALL) -d $(DESTDIR)${includedir}
>  	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
>  	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
> +	$(INSTALL_DATA) lib/cpupower.h $(DESTDIR)${includedir}/cpupower.h
>  
>  install-tools:
>  	$(INSTALL) -d $(DESTDIR)${bindir}
> @@ -314,6 +315,7 @@ uninstall:
>  	- rm -f $(DESTDIR)${libdir}/libcpupower.*
>  	- rm -f $(DESTDIR)${includedir}/cpufreq.h
>  	- rm -f $(DESTDIR)${includedir}/cpuidle.h
> +	- rm -f $(DESTDIR)${includedir}/cpupower.h
>  	- rm -f $(DESTDIR)${bindir}/utils/cpupower
>  	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
>  	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
> 
