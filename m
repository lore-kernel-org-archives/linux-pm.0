From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6 patch] simplify SOFTWARE_SUSPEND dependencies
Date: Sat, 20 Aug 2005 10:28:55 +0200
Message-ID: <20050820082855.GA1829@elf.ucw.cz>
References: <20050820040723.GN3615@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16388485207241166=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050820040723.GN3615@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============16388485207241166==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch expresses the same dependencies in a more simple way.

I have this currently in my tree:

        depends on PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))

(I really want to remove experimental), but it is not urgent enough to
push heavily.
								Pavel

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.13-rc6-mm1-full/kernel/power/Kconfig.old	2005-08-20 06:02:49.000000000 +0200
> +++ linux-2.6.13-rc6-mm1-full/kernel/power/Kconfig	2005-08-20 06:03:13.000000000 +0200
> @@ -28,7 +28,7 @@
>  
>  config SOFTWARE_SUSPEND
>  	bool "Software Suspend"
> -	depends on EXPERIMENTAL && PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
> +	depends on EXPERIMENTAL && PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))
>  	---help---
>  	  Enable the possibility of suspending the machine.
>  	  It doesn't need APM.
> 

-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============16388485207241166==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16388485207241166==--
