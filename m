From: Priya Sehgal <priya.sehgal@gmail.com>
Subject: how can we modify voltage on DVFS through Linux
Date: Fri, 16 Oct 2009 15:27:59 -0400
Message-ID: <9c3f89cc0910161227l599965c9me23d563642592cfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3045458791587545050=="
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
List-Id: linux-pm@vger.kernel.org

--===============3045458791587545050==
Content-Type: multipart/alternative; boundary=000325557516c89edd04761264f7

--000325557516c89edd04761264f7
Content-Type: text/plain; charset=ISO-8859-1

Hello,
I am working on DVFS capable CPU - Nehalem quad core and I need to modify
the
CPU speed and voltage. I disabled cpuspeed service on my machine and
modified
some piece of cpuspeed code, to change the frequency of all the CPUs the way
I want.

I am curious whether the voltage gets increased and decreased in proportion
to the
frequency, or can we control the voltage separately. I could not locate any
/sys entries for voltage
only for frequency.

-- 
Regards,
Priya

--000325557516c89edd04761264f7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br>I am working on DVFS capable CPU - Nehalem quad core and I need t=
o modify the<br>CPU speed and voltage. I disabled cpuspeed service on my ma=
chine and modified <br>some piece of cpuspeed code, to change the frequency=
 of all the CPUs the way I want.<br>
<br>I am curious whether the voltage gets increased and decreased in propor=
tion to the <br>frequency, or can we control the voltage separately. I coul=
d not locate any /sys entries for voltage<br>only for frequency.<br clear=
=3D"all">
<br>-- <br>Regards,<br>Priya<br>

--000325557516c89edd04761264f7--

--===============3045458791587545050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3045458791587545050==--
