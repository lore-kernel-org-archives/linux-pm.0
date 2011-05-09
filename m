From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 1/5] PM / Runtime: Support for generic I/O
 power domains (v3)
Date: Mon, 9 May 2011 09:08:12 -0700
Message-ID: <BANLkTinPGQNUrFnyFVazqA72iyMbB-K_OA@mail.gmail.com>
References: <201104290154.12966.rjw@sisk.pl> <201105082320.57185.rjw@sisk.pl>
	<201105082322.44268.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5663064636366456209=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105082322.44268.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-pm@vger.kernel.org

--===============5663064636366456209==
Content-Type: multipart/alternative; boundary=00151748dd7ce1f6b604a2da0ba6

--00151748dd7ce1f6b604a2da0ba6
Content-Type: text/plain; charset=ISO-8859-1

On Sun, May 8, 2011 at 2:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
...

> power management (i.e. ->stop_device() may disable a device's
> clocks, while ->start_device() may enable them, ->power_on() is
> supposed to remove power from the entire power domain
> and ->power_off() is supposed to restore it).
>

power_off removes power, power_on restores?


Todd

--00151748dd7ce1f6b604a2da0ba6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, May 8, 2011 at 2:22 PM, Rafael J. Wysock=
i <span dir=3D"ltr">&lt;<a href=3D"mailto:rjw@sisk.pl">rjw@sisk.pl</a>&gt;<=
/span> wrote:</div><div class=3D"gmail_quote">...<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex;">

power management (i.e. -&gt;stop_device() may disable a device&#39;s<br>
clocks, while -&gt;start_device() may enable them, -&gt;power_on() is<br>
supposed to remove power from the entire power domain<br>
and -&gt;power_off() is supposed to restore it).<br></blockquote><div><br><=
/div><div>power_off removes power, power_on restores?=A0</div><div><br></di=
v><div><br></div><div>Todd</div><div><br></div></div>

--00151748dd7ce1f6b604a2da0ba6--

--===============5663064636366456209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5663064636366456209==--
