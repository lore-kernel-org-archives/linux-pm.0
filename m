From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] suspend-to-both (less ugly version)
Date: Wed, 15 Mar 2006 22:22:56 +0100
Message-ID: <200603152222.56685.rjw@sisk.pl>
References: <20060315090627.GA2201@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060315090627.GA2201@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: suspend-devel@lists.sourceforge.net
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 15 March 2006 10:06, Pavel Machek wrote:
> Here's less ugly version of suspend-to-both patch. Code needs to
> become optional on some command-line option, and then it may even be
> ready for merge suspend.sf.net.
> 
> Ahha, and will have something to do with that chroot-safety-net.
> 
> Any testers?
> 								Pavel
> 
> Index: Makefile
> ===================================================================
> RCS file: /cvsroot/suspend/suspend/Makefile,v
> retrieving revision 1.21
> diff -u -u -r1.21 Makefile
> --- Makefile	12 Mar 2006 16:17:19 -0000	1.21
> +++ Makefile	15 Mar 2006 09:04:17 -0000
> @@ -69,8 +69,8 @@
>  vt.o:	vt.c vt.h
>  	gcc -Wall -c vt.c
>  
> -suspend:	md5.o encrypt.o config.o suspend.c swsusp.h config.h encrypt.h md5.h
> -	gcc -Wall $(CC_FLAGS) md5.o encrypt.o config.o suspend.c -o suspend $(LD_FLAGS)
> +suspend:	md5.o encrypt.o config.o suspend.c swsusp.h config.h encrypt.h md5.h s2ram.c dmidecode.c whitelist.c radeontool.c $(S2RAMOBJ)
> +	gcc -g -O2 -DCONFIG_BOTH -Wall $(CC_FLAGS) md5.o encrypt.o config.o suspend.c s2ram.c -o suspend $(S2RAMOBJ) $(LD_FLAGS) -lpci 
>  
>  resume:	md5.o encrypt.o config.o resume.c swsusp.h config.h encrypt.h md5.h
>  	gcc -Wall $(CC_FLAGS) md5.o encrypt.o config.o resume.c -static -o resume $(LD_FLAGS)
> Index: s2ram.c
> ===================================================================
> RCS file: /cvsroot/suspend/suspend/s2ram.c,v
> retrieving revision 1.29
> diff -u -u -r1.29 s2ram.c
> --- s2ram.c	7 Mar 2006 23:54:21 -0000	1.29
> +++ s2ram.c	15 Mar 2006 09:04:23 -0000
> @@ -237,6 +239,7 @@
>  	exit(1);
>  }
>  
> +#ifndef CONFIG_BOTH
>  int main(int argc, char *argv[])
>  {
>  	int i;
> @@ -299,3 +302,4 @@
>  	s2ram_resume();
>  	return i;
>  }
> +#endif
> Index: suspend.c
> ===================================================================
> RCS file: /cvsroot/suspend/suspend/suspend.c,v
> retrieving revision 1.22
> diff -u -u -r1.22 suspend.c
> --- suspend.c	12 Mar 2006 16:17:19 -0000	1.22
> +++ suspend.c	15 Mar 2006 09:04:41 -0000
> @@ -53,6 +53,7 @@
>  #define encrypt 0
>  #define key_name NULL
>  #endif
> +static int s2ram = 1;

I assume this will be an option in the final version? ;-)

Rafael
