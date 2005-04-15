From: Daniel Petrini <d.pensator@gmail.com>
Subject: Re: [RFC] A New Power Management API
Date: Fri, 15 Apr 2005 09:16:11 -0400
Message-ID: <9268368b0504150616652c268b@mail.gmail.com>
References: <1113533193.3451.40.camel@localhost.localdomain>
Reply-To: Daniel Petrini <d.pensator@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65543397883856125=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1113533193.3451.40.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--===============65543397883856125==
Content-Type: multipart/alternative;
    boundary="----------=_1113570994-1467-123"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1113570994-1467-123
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Suggestion: as discussed in early weeks, why don't adopt names taking into=
=20
consideration that Linux can run in systems other than desktops and servers?

#define PM_SYSTEM_STATE_SUSPEND_RAM 0x00000010
#define PM_SYSTEM_STATE_SUSPEND_DISK 0x00000020

PM_SYSTEM_STATE_SUSPEND_DISK an be something like=20
PM_SYSTEM_STATE_DEEP_SUSPEND and so on...

So you can have better acceptance of people working in other areas.

My two cents.
Regards,

Daniel Petrini

--=20
10LE - Linux
Nokia Institute of Tecnology - INdT
Manaus - Brazil

------------=_1113570994-1467-123
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
Suggestion: as discussed in early weeks, why don't adopt names taking
into consideration that Linux can run in systems other than desktops
and servers?<br>
<br>
#define PM_SYSTEM_STATE_SUSPEND_RAM &nbsp; &nbsp; 0x00000010<br>
#define PM_SYSTEM_STATE_SUSPEND_DISK &nbsp; &nbsp;0x00000020<br><br>
PM_SYSTEM_STATE_SUSPEND_DISK an be something like PM_SYSTEM_STATE_DEEP_SUSP=
END and so on...<br>
<br>
So you can have better acceptance of people working in other areas.<br>
<br>
My two cents.<br>
Regards,<br>
<br>
Daniel Petrini<br>
<br>-- <br>10LE - Linux<br>Nokia Institute of Tecnology - INdT<br>Manaus - =
Brazil

------------=_1113570994-1467-123--

--===============65543397883856125==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65543397883856125==--
