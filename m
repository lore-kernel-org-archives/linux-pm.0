From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: Weird suspend/resume problem on HP nx6325 w/
 openSUSE 11.2 w/ -rc8
Date: Sat, 21 Nov 2009 15:21:32 -0800
Message-ID: <4B0875FC.80705@gmail.com>
References: <200911220015.30912.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7039876176008940593=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911220015.30912.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, DRI <dri-devel@lists.sourceforge.net>, Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--===============7039876176008940593==
Content-Type: multipart/alternative;
 boundary="------------050505040100020106000207"

This is a multi-part message in MIME format.
--------------050505040100020106000207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/09 15:15, Rafael J. Wysocki wrote:
> Hi,
>
> I'm not really sure where this should be reported, but here it goes.
>
> After installing openSUSE 11.2 on my testbed nx6325 I noticed that resume
> (from suspend to RAM) stopped working on it.  Apparently, it hanged while
> switching from the console back to X and the box remained completely
> unresponsive after that (it didn't even react to the magic sysrq).  However,
> it used to work just fine with -rc7 and openSUSE 11.1, so I figured the problem
> was related to the new X driver, which is radeon module version 6.12.4 (xorg
> server 1.6.5).
>
> So, I started to investigate and found that after a suspend from a framebuffer
> console, the resume had always worked.  However, when I switched from X to the
> framebuffer console, suspended, resumed and switched back to X, the box hanged
> immediately just like during resume after a suspend from under X.  [There also
> were some problems when switching from X to the framebuffer console and back
> which seemd to be independent of suspend/resume (in short, the screen stays
> black after a switch from the framebuffer console to X and you need to kill X
> to fix this).]
>
> Later, however, I discovered that if the box was booted into runlevel 3, then
> suspended to RAM and resumed, and then switched to runlevel 5, I could log
> into X and suspend/resume without any problems for many times.  OTOH, after
> booting directly into X, the first attempt to resume always resulted in a black
> screen and a hard hang.
>
> I wonder what's up in there.
>
> [Hibernation/resume works 100% of the time AFAICS.]
>
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>    
I just noticed today that on my macbook(radeon) using
s2ram works, but I get a long pause(black screen) before
the screen shows up.(latest stable release works fine).

Justin P. Mattock

--------------050505040100020106000207
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 11/21/09 15:15, Rafael J. Wysocki wrote:
<blockquote cite="mid:200911220015.30912.rjw@sisk.pl" type="cite">
  <pre wrap="">Hi,

I'm not really sure where this should be reported, but here it goes.

After installing openSUSE 11.2 on my testbed nx6325 I noticed that resume
(from suspend to RAM) stopped working on it.  Apparently, it hanged while
switching from the console back to X and the box remained completely
unresponsive after that (it didn't even react to the magic sysrq).  However,
it used to work just fine with -rc7 and openSUSE 11.1, so I figured the problem
was related to the new X driver, which is radeon module version 6.12.4 (xorg
server 1.6.5).

So, I started to investigate and found that after a suspend from a framebuffer
console, the resume had always worked.  However, when I switched from X to the
framebuffer console, suspended, resumed and switched back to X, the box hanged
immediately just like during resume after a suspend from under X.  [There also
were some problems when switching from X to the framebuffer console and back
which seemd to be independent of suspend/resume (in short, the screen stays
black after a switch from the framebuffer console to X and you need to kill X
to fix this).]

Later, however, I discovered that if the box was booted into runlevel 3, then
suspended to RAM and resumed, and then switched to runlevel 5, I could log
into X and suspend/resume without any problems for many times.  OTOH, after
booting directly into X, the first attempt to resume always resulted in a black
screen and a hard hang.

I wonder what's up in there.

[Hibernation/resume works 100% of the time AFAICS.]

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a>
More majordomo info at  <a class="moz-txt-link-freetext" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>
Please read the FAQ at  <a class="moz-txt-link-freetext" href="http://www.tux.org/lkml/">http://www.tux.org/lkml/</a>

  </pre>
</blockquote>
<small>I just noticed today that on my macbook(radeon) using<br>
s2ram works, but I get a long pause(black screen) before<br>
the screen shows up.(latest stable release works fine).<br>
<br>
Justin P. Mattock</small><br>
</body>
</html>

--------------050505040100020106000207--

--===============7039876176008940593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7039876176008940593==--
