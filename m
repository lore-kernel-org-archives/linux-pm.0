From: Nithish Mahalingam <nithish.m@gmail.com>
Subject: Re: power/level and power/control
Date: Fri, 12 Mar 2010 02:57:08 -0800
Message-ID: <e6a3c75f1003120257i4adc05f0h83f48e76af1abaa5@mail.gmail.com>
References: <Pine.LNX.4.44L0.1003111139170.1367-100000@iolanthe.rowland.org>
	<201003120943.09520.oliver@neukum.org>
	<ac3eb2511003120047l510fd464w31280f28c48f163a@mail.gmail.com>
	<201003121008.49246.oliver@neukum.org>
	<ac3eb2511003120122n33130d22k61ca18ecf0d14e80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4727487014348461139=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <ac3eb2511003120122n33130d22k61ca18ecf0d14e80@mail.gmail.com>
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
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============4727487014348461139==
Content-Type: multipart/alternative; boundary=0016e6d99f6f86f93b0481986467

--0016e6d99f6f86f93b0481986467
Content-Type: text/plain; charset=ISO-8859-1

>
> >>> > Has support in user space hardware abstraction layers for runtime
> >>> > power management been added? It seems to me that we need this.
> >>>
> >>> There is no major project I know of, which uses these things, and
> >>> nothing I know of people would work on at the moment.
> >>
> >> If this were to be added, which project should it be added to?
> >
> > I don't think there is an existing project that would really fit here.
> >
> >> I don't think handling this with udev scripts is a good idea, because
> >> you want to be able to revisit such decisions when you go to
> >> battery power or power is low, for example whether you want to
> >> charge your cell phone.
> >
> > Right, that needs policy to apply, depending on the current state. But
> > unfortunately there is no existing infrastructure we could easily
> > extend, it would be something new to come up with.
>

Shouldn't it suffice to extend usb_device namespace values in HAL
specification for runtime PM and once added let distribution
specific user space PM framework handle this.
http://people.redhat.com/davidz/hal-spec/hal-spec.html#device-properties-usb

I guess the industry is moving towards DeviceKit, anyway that is just
implementation specific.

regards,
/N

--0016e6d99f6f86f93b0481986467
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;"><div class=3D"im">&gt;&gt;&gt; &gt; Has support in user space har=
dware abstraction layers for runtime<br>

&gt;&gt;&gt; &gt; power management been added? It seems to me that we need =
this.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; There is no major project I know of, which uses these things, =
and<br>
&gt;&gt;&gt; nothing I know of people would work on at the moment.<br>
&gt;&gt;<br>
&gt;&gt; If this were to be added, which project should it be added to?<br>
&gt; <br>
</div>&gt; I don&#39;t think there is an existing project that would really=
 fit here.<br>
<div class=3D"im">&gt; <br>
&gt;&gt; I don&#39;t think handling this with udev scripts is a good idea, =
because<br>
&gt;&gt; you want to be able to revisit such decisions when you go to<br>
&gt;&gt; battery power or power is low, for example whether you want to<br>
&gt;&gt; charge your cell phone.<br>
&gt; <br>
</div>&gt; Right, that needs policy to apply, depending on the current stat=
e. But<br>
&gt; unfortunately there is no existing infrastructure we could easily<br>
&gt; extend, it would be something new to come up with.<br></blockquote><di=
v><br>Shouldn&#39;t it suffice to extend usb_device namespace values in HAL=
 <br>specification for runtime PM and once added let distribution <br>
specific user space PM framework handle this.<br> <a href=3D"http://people.=
redhat.com/davidz/hal-spec/hal-spec.html#device-properties-usb">http://peop=
le.redhat.com/davidz/hal-spec/hal-spec.html#device-properties-usb</a><br>
<br>I guess the industry is moving towards DeviceKit, anyway that is just <=
br>implementation specific.<br><br>regards,<br>/N<br></div></div>

--0016e6d99f6f86f93b0481986467--

--===============4727487014348461139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4727487014348461139==--
