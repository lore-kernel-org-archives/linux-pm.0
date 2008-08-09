From: "Jonathan Brossard" <jonathan@iviztechnosolutions.com>
Subject: Re: Vulnerability in Software Suspend 2 (all versions)
Date: Sun, 10 Aug 2008 05:23:06 +0530
Message-ID: <d8c48a710808091653p5c40b03cub70b3ff49e0ffb6d@mail.gmail.com>
References: <488D821D.5060603@iviztechnosolutions.com>
	<488D8449.2010006@iviztechnosolutions.com>
	<1217234901.8430.115.camel@nigel-laptop>
	<488D8853.7080907@iviztechnosolutions.com>
	<1217235481.8430.124.camel@nigel-laptop>
	<488D8A8C.7090101@iviztechnosolutions.com>
	<tkrat.cd3adb290ff8b8ed@m4x.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0117498878565108525=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <tkrat.cd3adb290ff8b8ed@m4x.org>
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
To: florent.chabaud@m4x.org, ncunningham@crca.org.au
Cc: ncunningham@users.sourceforge.net, chabaud@users.sourceforge.net, bernardb@users.sourceforge.net, seasons@users.sourceforge.net, techteam@ivizindia.com, "CERT(R) Coordination Center" <cert@cert.org>, mhfl@users.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, Jonathan Brossard <jonathan@ivizindia.com>
List-Id: linux-pm@vger.kernel.org

--===============0117498878565108525==
Content-Type: multipart/alternative;
	boundary="----=_Part_53486_19259367.1218325986191"

------=_Part_53486_19259367.1218325986191
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear Florent and Nigel,

I agree the problem lies in the dmcrypt module, but I couldn't replicate th=
e
bug on the latest kernels (I know 2.6.16 was vulnerable, so something must
have been patched in the meantime). I am in Defcon right now and will try t=
o
verify those assumptions sometime next week.

The problem might be known or whatever, but most disk encryption software
are affected. I had lunch with the Bitlocker team from Microsoft today
itself, and they find the bug amazing... so maybe you'd like to have a look
at my paper sometime (I can leak it to you if you want, or just ask Nigel).

Regarding the addresses, you might want to update the sourceforge page, thi=
s
is the first place where ppl look for project mainteners...

Thanks for your reply,
Best regards,

Jonathan-


On Sat, Aug 9, 2008 at 7:19 PM, <florent.chabaud@m4x.org> wrote:

> Dear Jonathan,
>
> Sorry for intervening so lately, but Nigel is right : those adresses are
> really out of date ;-)
>
> Le 28 jui, Jonathan Brossard a =E9crit :
> > Dear Nigel,
> >
> > Feel free to put me in my place if I am wrong here :
> >
> > When you try to boot a tuxonice capable computer and
> > restore the state of the computer using a hibernation file...
> >
> > you are asked for a password, which is not the standard userland
> > login prompt (for a imple reason : there is no kernel in memory at that
> > time).
> > That password is part of tux on ice, right ?
>
> AFAIK this is not part of swsusp nor tuxonice. I'm still using swsusp,
> although not contributing any more, and I don't have any password to
> type in my configuration.
>
> xxd -l 32 -s 0x041e  /dev/mem
> 000041e: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 000042e: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>
> >
> > Well, that password can be retreived from RAM !
>
> Password retrieved from RAM is a well known issue :) From your
> description, you seem to say that the kernel is not running at the time
> you seize the password. This indicates for sure that tuxonice is not
> involved, since it is part of kernel. The way tuxonice works is
> launching the kernel as usual and interrupt normal boot as soon as
> possible if a frozen image is detected.
>
> What you may have in your case is either a hardware password, managed by
> the BIOS, or a password used to encrypt swap (and swsusp image) as
> described in swsusp-dmcrypt.txt. Now, I agree with Nigel that this is
> not part of swsusp, but it may be a bug in the configuration of dmcrypt.
>
> You should also note that from a security point of view, the security
> model is not at all circumvented. You need to have a root access to
> /dev/mem from a resumed session, to obtain the password, and even if the
> password was erased (which should be done anyway, it's a good practice)
> you still have the ciphering key of the swap somewhere in memory.
>
> Anyway, thank you for the report. Please feel free to exchange more
> information in order to identify more precisely the problem, and
> specially the configuration you use.
>
> Sincerely yours,
>
> Florent Chabaud
>
> >
> > Best regards,
> >
> > Jonathan-
> >
> > Nigel Cunningham wrote:
> >> Hi again.
> >>
> >> On Mon, 2008-07-28 at 14:20 +0530, Jonathan Brossard wrote:
> >>
> >>> Dear Nigel,
> >>>
> >>>
> >>>> This is not a bug in TuxOnIce (or for that matter other Linux
> >>>> hibernation implementations, which would have the same issue).
> >>>>
> >>> Yes it is.
> >>>
> >>>
> >>>> TuxOnIce has no way to know what running applications have passwords
> >>>> stored in memory or whether they are storing them in an encrypted
> format
> >>>> or not. Bugs should be filed against applications that are storing
> >>>> passwords in plain text.
> >>>>
> >>> We are talking about the password of tuxonice itself here...
> >>>
> >>
> >> TuxOnIce itself doesn't have any password support. Do you mean a
> >> password for encrypted swap or such like?
> >>
> >>
> >>> Please boot a computer using tuxonice, go for hibernation,
> >>> reboot, and then type this (as root) :
> >>>
> >>> xxd -l 32 -s 0x041e  /dev/mem
> >>>
> >>>
> >>>
> >>>> By the way, these contact email addresses are grossly out of date. F=
or
> >>>> TuxOnIce, the contact is nigel@tuxonice.net. For swsusp and uswsusp
> >>>> (which would have the same problem), refer to linux-pm@lists.osdl.or=
g
> .
> >>>>
> >>> I did my best to find one on the site's website and ended up
> >>> taking those of sourceforge.
> >>>
> >>
> >> Hmm, you're right there. I'll address that shortly.
> >>
> >> Regards,
> >>
> >> Nigel
> >>
> >>
> >>
> >
> >
> > --
> >     Jonathan Brossard
> >     Security Research Engineer
> >     iViZ Techno Solutions Pvt. Ltd.
> >     Mobile: +91-9748772994
> >
> >     Kolkata:
> >     iViZ Technolgy Solutions(P) Ltd
> >     c/o Erevmax Technologies (P) Ltd
> >     DLF IT Park,
> >     Tower-1, 12th Floor
> >     08 Major Arterial Road
> >     New Town, Rajarhat
> >     Kolkata- 700 156
> >
> >     Kharagpur:
> >     iViZ Techno Solutions Pvt Ltd,
> >     School of Information Technology,
> >     Indian Institute of Technology,
> >     2nd Floor, Takshashila,
> >     Kharagpur 721302 West Bengal, India.
> >     Phone: +91-3222-282300 ext 4324
> >
> >     Web page: http://www.ivizindia.com
> >
>
>
> Florent Chabaud
> gpg: 28C9 9E1A 5507 5574 EDE6  2E8F 2B37 D83F 95C8 1C3C
> http://www.carva.org/florent.chabaud | florent.chabaud@m4x.org
>



--=20
Jonathan Brossard
Security Research Engineer
iViZ Techno Solutions Pvt. Ltd.
Mobile: +91-9748772994

Kolkata:
iViZ Technolgy Solutions(P) Ltd
c/o Erevmax Technologies (P) Ltd
DLF IT Park,
Tower-1, 12th Floor
08 Major Arterial Road
New Town, Rajarhat
Kolkata- 700 156

Kharagpur:
iViZ Techno Solutions Pvt Ltd,
School of Information Technology,
Indian Institute of Technology,
2nd Floor, Takshashila,
Kharagpur 721302 West Bengal, India.
Phone: +91-3222-282300 ext 4324

Web page: http://www.ivizindia.com

------=_Part_53486_19259367.1218325986191
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">Dear Florent and Nigel,<br><br>I agree the problem lies in=
 the dmcrypt module, but I couldn&#39;t replicate the bug on the latest ker=
nels (I know 2.6.16 was vulnerable, so something must have been patched in =
the meantime). I am in Defcon right now and will try to verify those assump=
tions sometime next week.<br>
<br>The problem might be known or whatever, but most disk encryption softwa=
re are affected. I had lunch with the Bitlocker team from Microsoft today i=
tself, and they find the bug amazing... so maybe you&#39;d like to have a l=
ook at my paper sometime (I can leak it to you if you want, or just ask Nig=
el).<br>
<br>Regarding the addresses, you might want to update the sourceforge page,=
 this is the first place where ppl look for project mainteners...<br><br>Th=
anks for your reply,<br>Best regards,<br><br>Jonathan-<br><br><br><div clas=
s=3D"gmail_quote">
On Sat, Aug 9, 2008 at 7:19 PM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:fl=
orent.chabaud@m4x.org">florent.chabaud@m4x.org</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204=
, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dear Jonathan,<br>
<br>
Sorry for intervening so lately, but Nigel is right : those adresses are<br=
>
really out of date ;-)<br>
<br>
Le 28 jui, Jonathan Brossard a =E9crit :<br>
<div class=3D"Ih2E3d">&gt; Dear Nigel,<br>
&gt;<br>
&gt; Feel free to put me in my place if I am wrong here :<br>
&gt;<br>
&gt; When you try to boot a tuxonice capable computer and<br>
&gt; restore the state of the computer using a hibernation file...<br>
&gt;<br>
&gt; you are asked for a password, which is not the standard userland<br>
&gt; login prompt (for a imple reason : there is no kernel in memory at tha=
t<br>
&gt; time).<br>
&gt; That password is part of tux on ice, right ?<br>
<br>
</div>AFAIK this is not part of swsusp nor tuxonice. I&#39;m still using sw=
susp,<br>
although not contributing any more, and I don&#39;t have any password to<br=
>
type in my configuration.<br>
<div class=3D"Ih2E3d"><br>
xxd -l 32 -s 0x041e &nbsp;/dev/mem<br>
</div>000041e: 0000 0000 0000 0000 0000 0000 0000 0000 &nbsp;..............=
..<br>
000042e: 0000 0000 0000 0000 0000 0000 0000 0000 &nbsp;................<br>
<div class=3D"Ih2E3d"><br>
&gt;<br>
&gt; Well, that password can be retreived from RAM !<br>
<br>
</div>Password retrieved from RAM is a well known issue :) From your<br>
description, you seem to say that the kernel is not running at the time<br>
you seize the password. This indicates for sure that tuxonice is not<br>
involved, since it is part of kernel. The way tuxonice works is<br>
launching the kernel as usual and interrupt normal boot as soon as<br>
possible if a frozen image is detected.<br>
<br>
What you may have in your case is either a hardware password, managed by<br=
>
the BIOS, or a password used to encrypt swap (and swsusp image) as<br>
described in swsusp-dmcrypt.txt. Now, I agree with Nigel that this is<br>
not part of swsusp, but it may be a bug in the configuration of dmcrypt.<br=
>
<br>
You should also note that from a security point of view, the security<br>
model is not at all circumvented. You need to have a root access to<br>
/dev/mem from a resumed session, to obtain the password, and even if the<br=
>
password was erased (which should be done anyway, it&#39;s a good practice)=
<br>
you still have the ciphering key of the swap somewhere in memory.<br>
<br>
Anyway, thank you for the report. Please feel free to exchange more<br>
information in order to identify more precisely the problem, and<br>
specially the configuration you use.<br>
<br>
Sincerely yours,<br>
<br>
Florent Chabaud<br>
<div><div></div><div class=3D"Wj3C7c"><br>
&gt;<br>
&gt; Best regards,<br>
&gt;<br>
&gt; Jonathan-<br>
&gt;<br>
&gt; Nigel Cunningham wrote:<br>
&gt;&gt; Hi again.<br>
&gt;&gt;<br>
&gt;&gt; On Mon, 2008-07-28 at 14:20 +0530, Jonathan Brossard wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Dear Nigel,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This is not a bug in TuxOnIce (or for that matter other Li=
nux<br>
&gt;&gt;&gt;&gt; hibernation implementations, which would have the same iss=
ue).<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; Yes it is.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; TuxOnIce has no way to know what running applications have=
 passwords<br>
&gt;&gt;&gt;&gt; stored in memory or whether they are storing them in an en=
crypted format<br>
&gt;&gt;&gt;&gt; or not. Bugs should be filed against applications that are=
 storing<br>
&gt;&gt;&gt;&gt; passwords in plain text.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; We are talking about the password of tuxonice itself here...<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; TuxOnIce itself doesn&#39;t have any password support. Do you mean=
 a<br>
&gt;&gt; password for encrypted swap or such like?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; Please boot a computer using tuxonice, go for hibernation,<br>
&gt;&gt;&gt; reboot, and then type this (as root) :<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; xxd -l 32 -s 0x041e &nbsp;/dev/mem<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; By the way, these contact email addresses are grossly out =
of date. For<br>
&gt;&gt;&gt;&gt; TuxOnIce, the contact is <a href=3D"mailto:nigel@tuxonice.=
net">nigel@tuxonice.net</a>. For swsusp and uswsusp<br>
&gt;&gt;&gt;&gt; (which would have the same problem), refer to <a href=3D"m=
ailto:linux-pm@lists.osdl.org">linux-pm@lists.osdl.org</a>.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; I did my best to find one on the site&#39;s website and ended =
up<br>
&gt;&gt;&gt; taking those of sourceforge.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hmm, you&#39;re right there. I&#39;ll address that shortly.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt;<br>
&gt;&gt; Nigel<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; &nbsp; &nbsp; Jonathan Brossard<br>
&gt; &nbsp; &nbsp; Security Research Engineer<br>
&gt; &nbsp; &nbsp; iViZ Techno Solutions Pvt. Ltd.<br>
&gt; &nbsp; &nbsp; Mobile: +91-9748772994<br>
&gt;<br>
&gt; &nbsp; &nbsp; Kolkata:<br>
&gt; &nbsp; &nbsp; iViZ Technolgy Solutions(P) Ltd<br>
&gt; &nbsp; &nbsp; c/o Erevmax Technologies (P) Ltd<br>
&gt; &nbsp; &nbsp; DLF IT Park,<br>
&gt; &nbsp; &nbsp; Tower-1, 12th Floor<br>
&gt; &nbsp; &nbsp; 08 Major Arterial Road<br>
&gt; &nbsp; &nbsp; New Town, Rajarhat<br>
&gt; &nbsp; &nbsp; Kolkata- 700 156<br>
&gt;<br>
&gt; &nbsp; &nbsp; Kharagpur:<br>
&gt; &nbsp; &nbsp; iViZ Techno Solutions Pvt Ltd,<br>
&gt; &nbsp; &nbsp; School of Information Technology,<br>
&gt; &nbsp; &nbsp; Indian Institute of Technology,<br>
&gt; &nbsp; &nbsp; 2nd Floor, Takshashila,<br>
&gt; &nbsp; &nbsp; Kharagpur 721302 West Bengal, India.<br>
&gt; &nbsp; &nbsp; Phone: +91-3222-282300 ext 4324<br>
&gt;<br>
&gt; &nbsp; &nbsp; Web page: <a href=3D"http://www.ivizindia.com" target=3D=
"_blank">http://www.ivizindia.com</a><br>
&gt;<br>
<br>
<br>
</div></div>Florent Chabaud<br>
gpg: 28C9 9E1A 5507 5574 EDE6 &nbsp;2E8F 2B37 D83F 95C8 1C3C<br>
<a href=3D"http://www.carva.org/florent.chabaud" target=3D"_blank">http://w=
ww.carva.org/florent.chabaud</a> | <a href=3D"mailto:florent.chabaud@m4x.or=
g">florent.chabaud@m4x.org</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br> Jonathan Brossard<br> =
Security Research Engineer<br> iViZ Techno Solutions Pvt. Ltd.<br> Mobile: =
+91-9748772994<br><br> Kolkata:<br> iViZ Technolgy Solutions(P) Ltd<br> c/o=
 Erevmax Technologies (P) Ltd<br>
 DLF IT Park,<br> Tower-1, 12th Floor<br> 08 Major Arterial Road<br> New To=
wn, Rajarhat<br> Kolkata- 700 156<br><br> Kharagpur:<br> iViZ Techno Soluti=
ons Pvt Ltd,<br> School of Information Technology,<br> Indian Institute of =
Technology,<br>
 2nd Floor, Takshashila,<br> Kharagpur 721302 West Bengal, India.<br> Phone=
: +91-3222-282300 ext 4324<br><br> Web page: <a href=3D"http://www.ivizindi=
a.com">http://www.ivizindia.com</a><br>
</div>

------=_Part_53486_19259367.1218325986191--

--===============0117498878565108525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0117498878565108525==--
