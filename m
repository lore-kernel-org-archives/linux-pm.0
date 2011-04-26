From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Tue, 26 Apr 2011 22:45:18 +0800
Message-ID: <BANLkTi=VFPZinH+1x0xBTP9o_s6+2gsA7w@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426132224.GC13597@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3869897883668699274=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110426132224.GC13597@suse.de>
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
To: Greg KH <gregkh@suse.de>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============3869897883668699274==
Content-Type: multipart/alternative; boundary=bcaec53f95d19efe2f04a1d36071

--bcaec53f95d19efe2f04a1d36071
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I think DVFS here means =93Dynamic voltage and frequency scaling=94,  refer=
ing
the first google's result:

a dynamic voltage and frequency scaling (DVFS) *technique that minimizes th=
e
total system energy
consumption for performing a task while satisfying a given execution time
constraint. We first show that in order to
guarantee minimum energy for task execution by using DVFS it is essential t=
o
divide the system power into active and
standby power components. Next, we present a new DVFS technique, which
considers not only the active power, but also
the standby component of the system power.

It's widely used in embeded Soc.

Best regards,
Zhang Jiejing


2011/4/26 Greg KH <gregkh@suse.de>

> On Tue, Apr 26, 2011 at 05:43:21PM +0900, MyungJoo Ham wrote:
> > With OPPs, a device may have multiple operable frequency and voltage
> > sets. However, there can be multiple possible operable sets and a syste=
m
> > will need to choose one from them. In order to reduce the power
> > consumption (by reducing frequency and voltage) without affecting the
> > performance too much, a DVFS scheme may be used.
>
> What is "DVFS"?  A new filesystem?
>
> confused,
>
> greg k-h
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>

--bcaec53f95d19efe2f04a1d36071
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Greg,<br><br>I think DVFS here means =93Dynamic voltage and frequency sc=
aling=94,=A0 refering the first google&#39;s result:<br><br>a dynamic volta=
ge and frequency scaling (DVFS) *technique that minimizes the total system =
energy<br>

consumption for performing a task while satisfying a given execution time c=
onstraint. We first show that in order to<br>guarantee minimum energy for t=
ask execution by using DVFS it is essential to divide the system power into=
 active and<br>

standby power components. Next, we present a new DVFS technique, which cons=
iders not only the active power, but also<br>the standby component of the s=
ystem power.<br><br>It&#39;s widely used in embeded Soc.<br clear=3D"all">

<div><br></div>Best regards,<br>Zhang Jiejing<br>
<br><br><div class=3D"gmail_quote">2011/4/26 Greg KH <span dir=3D"ltr">&lt;=
<a href=3D"mailto:gregkh@suse.de">gregkh@suse.de</a>&gt;</span><br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex;">

<div class=3D"im">On Tue, Apr 26, 2011 at 05:43:21PM +0900, MyungJoo Ham wr=
ote:<br>
&gt; With OPPs, a device may have multiple operable frequency and voltage<b=
r>
&gt; sets. However, there can be multiple possible operable sets and a syst=
em<br>
&gt; will need to choose one from them. In order to reduce the power<br>
&gt; consumption (by reducing frequency and voltage) without affecting the<=
br>
&gt; performance too much, a DVFS scheme may be used.<br>
<br>
</div>What is &quot;DVFS&quot;? =A0A new filesystem?<br>
<br>
confused,<br>
<br>
greg k-h<br>
<div><div></div><div class=3D"h5">_________________________________________=
______<br>
linux-pm mailing list<br>
<a href=3D"mailto:linux-pm@lists.linux-foundation.org">linux-pm@lists.linux=
-foundation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/linux-pm" ta=
rget=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/linux-p=
m</a><br>
</div></div></blockquote></div><br>

--bcaec53f95d19efe2f04a1d36071--

--===============3869897883668699274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3869897883668699274==--
