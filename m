From: Deepak Sikri <deepak.sikri79@gmail.com>
Subject: Power Domain Framework
Date: Mon, 10 May 2010 19:16:06 +0530
Message-ID: <AANLkTinZU1D1rMOBQDi47tRhXrOXwduQIdni7bCXdce0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0134264022903217613=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: viresh.kumar@st.com, rajeev-dlh.kumar@st.com, armando.visconti@st.com, linux-kernel@vger.kernel.org, vipin.kumar@st.com, shiraz.hashim@st.com
List-Id: linux-pm@vger.kernel.org

--===============0134264022903217613==
Content-Type: multipart/alternative; boundary=00c09f9c98017cb1d104863da10b

--00c09f9c98017cb1d104863da10b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

In our System on chip we have several power domains. As such there is no
generic framework for the Power Domains in linux , and I find huge potential
in the software to control the domains and exploit the power management
capabilities.

There is one very small model that I could think of, something on the lines
of clock framework.

1. Essentially the model would be based on defining the attributes of a
power domain ( name, current state: on/off, usage count, wake up sources,
list head etc) and the operations to be performed on a typical power domain
( Current State Check, Target State to be moved into etc) maintained in
software data structures, that would be mapped onto hardware registers in
the architecture specific code.
2. Maintain a list of the different power domains present.
3. The devices in a specific power domain, as per the requirements would get
the power domain handler ( which would increment the usage count of the
power domain) and would release it when not in need.
4. Typically a usage count of zero for any power domain -> switch off the
power domain removing static power dissipation.
5. The same could be mapped on to the PM framework, where the devices would
release their power handlers at the time of suspend and reaquire at time of
resume operations.
6. The model could further be build upon to check any dependency in the
power domains, eg DDR in on power domain should have the power domain on, if
any of the devices in other power domain is trying to access DDR. This could
be more architecture specific.
7. The advantages of the framework could be leveraged in the CPU idle time,
by switching off the Power domains with zero usage counts.

The model could be build upon, but seek lot more inputs if there exists any
provision on which we can build upon OR develop a generic power domain
framework.

Regards
Deepak

--00c09f9c98017cb1d104863da10b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>In our System on chip we have several power domains. As such there is =
no generic framework for the Power Domains in linux=A0, and I find huge pot=
ential in the software to control the domains and exploit the power managem=
ent capabilities.</div>

<div>=A0</div>
<div>There is one very small model that I could think of, something on the =
lines of clock framework.</div>
<div>=A0</div>
<div>1. Essentially the model would be based on defining the attributes of =
a power domain ( name, current state: on/off, usage count, wake up=A0source=
s, list head=A0etc) and the operations to be performed on a typical power d=
omain ( Current State Check, Target State to be moved into etc) maintained =
in software data structures, that would be mapped onto hardware registers i=
n the architecture specific code.</div>

<div>2. Maintain a list of the different power domains present.</div>
<div>3. The devices in a specific power domain, as per the requirements wou=
ld=A0get the power domain handler ( which would increment the usage count o=
f the power domain) and would release it when not in need.</div>
<div>4. Typically a usage count of zero for any power domain -&gt; switch o=
ff the power domain removing static power dissipation.</div>
<div>5. The same could be mapped on to the PM framework, where the devices =
would release their power handlers at the time of suspend and reaquire at t=
ime of resume operations.</div>
<div>6. The model could further be build upon to check any dependency in th=
e power domains, eg DDR in on power domain should have the power domain on,=
 if any of the devices in other power domain is trying to access DDR. This =
could be more architecture specific.</div>

<div>7. The advantages of the framework could be leveraged in the CPU idle =
time, by switching off the Power domains with zero usage counts.</div>
<div>=A0</div>
<div>The model could be build upon, but seek lot more inputs if there exist=
s any provision on which we can build upon OR develop a generic power domai=
n framework.</div>
<div>=A0</div>
<div>Regards</div>
<div>Deepak</div>

--00c09f9c98017cb1d104863da10b--

--===============0134264022903217613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0134264022903217613==--
