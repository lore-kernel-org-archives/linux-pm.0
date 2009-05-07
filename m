From: Sunil Kumar <devsku@gmail.com>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 7 May 2009 09:54:51 -0700
Message-ID: <ce9ef0d90905070954l9cbbe7aj9147aacb04fcb88c__43554.8586574898$1241718271$gmane$org@mail.gmail.com>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6760886485538511001=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507120948.GA1531@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============6760886485538511001==
Content-Type: multipart/alternative; boundary=0016e644dd26e1573c0469555e3a

--0016e644dd26e1573c0469555e3a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Thu, May 7, 2009 at 5:09 AM, Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>
> > I'd like to submit TuxOnIce for review, with a view to seeking to get it
> > merged, perhaps in 2.6.31 or .32 (depending upon what needs work before
> > it can be merged) and the willingness of those who matter.
> >
> > To briefly summarise the advantages to merging TuxOnIce:
> >
> > - Support for multiple swap devices
> > - Support for non-swap (an ordinary file can be used)
> > - Uses cryptoapi (LZO support, more than 2x speed of uncompressed data!)
> > - Asynchronous I/O, readahead, multithreaded. Get the maximum throughput
> >   possible with your hardware.
> > - Userspace user interface that lets you abort hibernating and abort
> >   resuming, get nice progress display etc.
>
> All these are either done by uswsusp already, or could be done w/o
> modifying kernel code.


Really? Last time I used it, it was dog slow to suspend and dog slow to
resume. And threw away most of my useful stuff, making my system slow after
resume. I could as well have restarted and be fully functional in much less
time.

We need a competitor to swsusp in kernel so that you can get you off your
a$$ and make the swsusp better.



> > - 8 years of testing and improvement.
>
> Yeah, 8 years of out of tree testing; while current code is used by
> basically every distro out there.


What is out of tree? People just install the patch and use it instead of
in-kernel version. Isn't that shameful enough for you to keep quiet?


> > - Full image of memory (LRU pages that don't need to be atomically
> >   copied are saved prior to the atomic copy, then used as the
> >   destination of the atomic copy).
>
> Yeah, that was the patch that did not go in
>
> > - Support for resuming a different image after writing an image - makes
> >   powering down a UPS after writing an image doable.
>
>
> This can  be done w/o kernel code. Someone had a patch...


which went where?


> > - Simple to set up (works without any userspace binaries, uses existing
> >   resume= and noresume commandline parameters).
>
> Given that distros ship uswsusp already... is that really an advantage.
>
> To summarise disadvantages:
>
> - only core has 8000 LoC
> - it does stuff that can be easily done in userspace
>     (and that todays distros _do_ in userspace).
> - it duplicates uswsusp functionality.
> - compared to [u]swsusp, it received little testing


Do you have data to support which one is used more?


>
>
>
>  Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek<http://www.livejournal.com/%7Epavelmachek>
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html<http://atrey.karlin.mff.cuni.cz/%7Epavel/picture/horses/blog.html>
> _______________________________________________
> TuxOnIce-devel mailing list
> TuxOnIce-devel@lists.tuxonice.net
> http://lists.tuxonice.net/mailman/listinfo/tuxonice-devel
>

--0016e644dd26e1573c0469555e3a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Thu, May 7, 2009 at 5:09 AM, Pavel Machek=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:pavel@ucw.cz">pavel@ucw.cz</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>
Hi!<br>
<br>
&gt; I&#39;d like to submit TuxOnIce for review, with a view to seeking to =
get it<br>
&gt; merged, perhaps in 2.6.31 or .32 (depending upon what needs work befor=
e<br>
&gt; it can be merged) and the willingness of those who matter.<br>
&gt;<br>
&gt; To briefly summarise the advantages to merging TuxOnIce:<br>
&gt;<br>
&gt; - Support for multiple swap devices<br>
&gt; - Support for non-swap (an ordinary file can be used)<br>
&gt; - Uses cryptoapi (LZO support, more than 2x speed of uncompressed data=
!)<br>
&gt; - Asynchronous I/O, readahead, multithreaded. Get the maximum throughp=
ut<br>
&gt; =A0 possible with your hardware.<br>
&gt; - Userspace user interface that lets you abort hibernating and abort<b=
r>
&gt; =A0 resuming, get nice progress display etc.<br>
<br>
All these are either done by uswsusp already, or could be done w/o<br>
modifying kernel code.</blockquote><div><br>Really? Last time I used it, it=
 was dog slow to suspend and dog slow to resume. And threw away most of my =
useful stuff, making my system slow after resume. I could as well have rest=
arted and be fully functional in much less time.<br>
<br>We need a competitor to swsusp in kernel so that you can get you off yo=
ur a$$ and make the swsusp better.<br><br>=A0<br></div><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">

&gt; - 8 years of testing and improvement.<br>
<br>
Yeah, 8 years of out of tree testing; while current code is used by<br>
basically every distro out there.</blockquote><div><br>What is out of tree?=
 People just install the patch and use it instead of in-kernel version. Isn=
&#39;t that shameful enough for you to keep quiet?<br>=A0<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

&gt; - Full image of memory (LRU pages that don&#39;t need to be atomically=
<br>
&gt; =A0 copied are saved prior to the atomic copy, then used as the<br>
&gt; =A0 destination of the atomic copy).<br>
<br>
Yeah, that was the patch that did not go in<br>
<br>
&gt; - Support for resuming a different image after writing an image - make=
s<br>
&gt; =A0 powering down a UPS after writing an image doable.<br>
<br>
<br>
This can =A0be done w/o kernel code. Someone had a patch...</blockquote><di=
v><br>which went where?<br>=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">

&gt; - Simple to set up (works without any userspace binaries, uses existin=
g<br>
&gt; =A0 resume=3D and noresume commandline parameters).<br>
<br>
Given that distros ship uswsusp already... is that really an advantage.<br>
<br>
To summarise disadvantages:<br>
<br>
- only core has 8000 LoC<br>
- it does stuff that can be easily done in userspace<br>
 =A0 =A0 (and that todays distros _do_ in userspace).<br>
- it duplicates uswsusp functionality.<br>
- compared to [u]swsusp, it received little testing</blockquote><div><br>Do=
 you have data to support which one is used more?<br>=A0<br></div><blockquo=
te class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204)=
; margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pave=
l<br>
<font color=3D"#888888"><br>
--<br>
(english) <a href=3D"http://www.livejournal.com/%7Epavelmachek" target=3D"_=
blank">http://www.livejournal.com/~pavelmachek</a><br>
(cesky, pictures) <a href=3D"http://atrey.karlin.mff.cuni.cz/%7Epavel/pictu=
re/horses/blog.html" target=3D"_blank">http://atrey.karlin.mff.cuni.cz/~pav=
el/picture/horses/blog.html</a><br>
_______________________________________________<br>
TuxOnIce-devel mailing list<br>
<a href=3D"mailto:TuxOnIce-devel@lists.tuxonice.net">TuxOnIce-devel@lists.t=
uxonice.net</a><br>
<a href=3D"http://lists.tuxonice.net/mailman/listinfo/tuxonice-devel" targe=
t=3D"_blank">http://lists.tuxonice.net/mailman/listinfo/tuxonice-devel</a><=
br>
</font></blockquote></div><br>

--0016e644dd26e1573c0469555e3a--

--===============6760886485538511001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6760886485538511001==--
