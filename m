From: Pavel Machek <pavel@ucw.cz>
Subject: Re: What woke system up?
Date: Thu, 22 Dec 2005 11:58:00 +0100
Message-ID: <20051222105800.GA9838@elf.ucw.cz>
References: <20051221002958.GA15851@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============024626344614204321=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051221002958.GA15851@slurryseal.ddns.mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============024626344614204321==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Next in our series of wakeup patches: a consumer electronics maker asked
> for a userspace interface to inquire what woke the system up, in order
> to present different behaviors depending on the wakeup source.  This is
> to be encouraged, as it places these kinds of policy decisions into the
> power policy application and out of the kernel.
> 
> So here's a quick try at adding a /sys/power/waker attribute and a
> pm_add_waker() kernel function that either drivers or board PM code can
> use to add (so far format-free) strings useful for telling what woke the
> system up.  The idea is that a buffer of these strings is cleared at
> each suspend and added to by the platform's resume path and/or driver
> resume methods.
> 
> I'll send a patch or two for embedded boards showing how
> this could be used for SoC-specific wakeup sources.
> 
> Any interest in this or something like it for Linux in general, or any
> other suggestions?  Thanks -- Todd

Well, idea may be okay but patch is ugly.

> Index: linux-2.6.15-rc4/kernel/power/main.c
> ===================================================================
> --- linux-2.6.15-rc4.orig/kernel/power/main.c
> +++ linux-2.6.15-rc4/kernel/power/main.c
> @@ -103,11 +103,18 @@ static int suspend_prepare(suspend_state
>  }
>  
>  
> +#define WAKERINFO_LEN 1024
> +
> +static char *wakerinfo;

Can you just allocate it statically? And use some reasonable length.

> +void pm_add_waker(char * buf)

char *buf

> +{
> +	if (! wakerinfo) {

Please don't use space between "!" and variable.

								Pavel
-- 
Thanks, Sharp!

--===============024626344614204321==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============024626344614204321==--
