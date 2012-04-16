From: "Satendra..." <satendra.pratap@gmail.com>
Subject: Devfreq Simple On Demand Governor
Date: Mon, 16 Apr 2012 15:37:33 +0530
Message-ID: <CAChS5kNS6DUq9W-R0XkQ8ksojUAbsLy5opz1eKb5iaa0D895cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5964943774179144594=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: myungjoo.ham@samsung.com
List-Id: linux-pm@vger.kernel.org

--===============5964943774179144594==
Content-Type: multipart/alternative; boundary=e89a8ff1c90e9fedcd04bdc8fd9e

--e89a8ff1c90e9fedcd04bdc8fd9e
Content-Type: text/plain; charset=ISO-8859-1

Hi Ham,

I was looking at the simple on demand governor's code and have got few
queries:
- In the code below to check for overflow, why 24 and 7  has been taken?
        /* Prevent overflow */
        if (stat.busy_time >= (1 << 24) || stat.total_time >= (1 << 24)) {
                stat.busy_time >>= 7;
                stat.total_time >>= 7;
        }

- Also for maximum frequency UINT_MAX is returned which may not be suited
for some devices.

- One more query, whats the unit (usecs, nsecs etc) used for busy and load
time. Has it got nothing to do with units
and its mere the percentage of busy time?

- If we want to use simple on demand governor then do we need to modify
yours to suit our needs? I mean you have
just provided a framework?

Thanks,
Satendra

--e89a8ff1c90e9fedcd04bdc8fd9e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ham,<div><br></div><div>I was looking at the simple on demand governor&#=
39;s code and have got few queries:</div><div>- In the code below to check =
for overflow, why 24 and 7 =A0has been taken?=A0</div><div><div>=A0 =A0 =A0=
 =A0 /* Prevent overflow */</div>
<div>=A0 =A0 =A0 =A0 if (stat.busy_time &gt;=3D (1 &lt;&lt; 24) || stat.tot=
al_time &gt;=3D (1 &lt;&lt; 24)) {</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 stat.busy_time &gt;&gt;=3D 7;</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 stat.total_time &gt;&gt;=3D 7;</div><div>=A0 =A0 =A0 =A0 }</div>
</div><div><br></div><div>- Also for maximum frequency UINT_MAX is returned=
 which may not be suited for some devices.</div><div><br></div><div>- One m=
ore query, whats the unit (usecs, nsecs etc) used for busy and load time. H=
as it got nothing to do with units</div>
<div>and its mere the percentage of busy time?</div><div><br></div><div>- I=
f we want to use simple on demand governor then do we need to modify yours =
to suit our needs? I mean you have</div><div>just provided a framework?</di=
v>
<div><br></div><div>Thanks,</div><div>Satendra</div>

--e89a8ff1c90e9fedcd04bdc8fd9e--

--===============5964943774179144594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5964943774179144594==--
