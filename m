From: Pavel Machek <pavel@ucw.cz>
Subject: Re: SOFTWARE_SUSPEND: dependency on non-existing FVR
	symbol
Date: Fri, 6 Jan 2006 20:29:48 +0000
Message-ID: <20060106202948.GB2736@ucw.cz>
References: <20060110043627.GD3911@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89943194215500899=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060110043627.GD3911@stusta.de>
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
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
List-Id: linux-pm@vger.kernel.org

--===============89943194215500899==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 10-01-06 05:36:27, Adrian Bunk wrote:
> The following issue in kernel/power/Kconfig was noted by
> Jean-Luc Leger <reiga@dspnet.fr.eu.org>:
> 
> config SOFTWARE_SUSPEND
>         bool "Software Suspend"
>         depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
> 
> 
> The problem is that there is no FVR symbol in the kernel.
> 
> Is this a misspelling of FRV or something different?

FRV, IIRC, but apparently noone ever tested that.
								Pavel
-- 
Thanks, Sharp!

--===============89943194215500899==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89943194215500899==--
