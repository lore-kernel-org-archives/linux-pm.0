From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower Makefile change
Date: Fri, 30 Jan 2015 01:27:23 +0100
Message-ID: <1889623.OtveQTWjnB@linux-oxht.site>
References: <1419266857.3837604.205784097.7B0DB495@webmail.messagingengine.com> <2471771.a0lNGTTV6e@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59436 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbbA3A10 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Jan 2015 19:27:26 -0500
In-Reply-To: <2471771.a0lNGTTV6e@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: sriram@marirs.net.in, linux-pm@vger.kernel.org

On Friday, January 30, 2015 01:13:09 AM Rafael J. Wysocki wrote:
> On Monday, December 22, 2014 10:17:37 PM sriram@marirs.net.in wrote:
> > The cpupower tool, when compiled against libcpupower.so fail's to run as
> > the linker file path's are missing during compilation. So added changes
> > in the Makefile to run cpupower tool, which helps us run the tool
> > without doing a 'make install'.
> > 
> > 
> > Signed-off-by: Sriram Raghunathan <sriram@marirs.net.in>
> 
> That requires an ACK from Thomas for me to apply it.

Makes sense.

Acked-by: Thomas Renninger <trenn@suse.de>

Thanks,

         Thomas

> 
> > ---
> > 
> >  tools/power/cpupower/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/power/cpupower/Makefile
> > b/tools/power/cpupower/Makefile
> > index 2e2ba2e..3ed7c04 100644
> > --- a/tools/power/cpupower/Makefile
> > +++ b/tools/power/cpupower/Makefile
> > @@ -209,7 +209,7 @@ $(OUTPUT)%.o: %.c
> > 
> >  $(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
> >  
> >  	$(ECHO) "  CC      " $@
> > 
> > -       $(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower -lrt
> > -lpci -L$(OUTPUT) -o $@
> > +       $(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower
> > -Wl,-rpath=./ -lrt -lpci -L$(OUTPUT) -o $@
> > 
> >  	$(QUIET) $(STRIPCMD) $@
> >  
> >  $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)

