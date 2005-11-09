From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.14 suspend fails with "Strange,
	firmware/dell_r not stopped"
Date: Wed, 9 Nov 2005 22:48:07 +0100
Message-ID: <20051109214807.GC12459@elf.ucw.cz>
References: <436F3609.2050907@naurel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25346893096671863=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <436F3609.2050907@naurel.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: =?iso-8859-1?Q?Aur=E9lien?= Francillon <aurel@naurel.org>
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============25346893096671863==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> suspending to ram or disk fails on 2.6.14, with
> CONFIG_DELL_RBU=y
> 
> in logs i have :
> 
> Stopping tasks: ==============================
>  stopping tasks failed (1 tasks remaining)
> Restarting tasks...<6> Strange, firmware/dell_r not stopped
>  done
> 
> with CONFIG_DELL_RBU=n everything is fine

Apparently, DELL_RBU runs some kernel thread. Find a place in that
kernel thread where it is okay to sleep, and add try_to_freeze()
there.

(Or forward this to dell rbu people.)
							Pavel
-- 
Thanks, Sharp!

--===============25346893096671863==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25346893096671863==--
