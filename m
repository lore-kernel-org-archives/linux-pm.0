From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
Date: Fri, 12 May 2006 03:11:51 -0700
Message-ID: <20060512031151.76a9d226.akpm@osdl.org>
References: <20060512100544.GA29010@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0087592080051137611=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060512100544.GA29010@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============0087592080051137611==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Pavel Machek <pavel@ucw.cz> wrote:
>
> It is very ugly, and we really should use names instead.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 421bcff..dfcfc47 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -6,6 +6,16 @@ be removed from this file.
>  
>  ---------------------------
>  
> +What:	/sys/device/.../power
> +When:	July 2007
> +Files:	
> +Why:	Because it takes integers, and different userland applications
> +	expect different numbers to mean different things.
> +	(Pcmcia expect 2 for off, some other code expects 3 for off).
> +Who:	Pavel Machek <pavel@suse.cz>
> +
> +---------------------------

What will be impacted by this?

--===============0087592080051137611==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0087592080051137611==--
