From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: RE: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 17:55:33 -0500
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD85@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36762961375639253=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============36762961375639253==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k05MteDZ007456

I shouldn't oversimplify the power management in a cell phone. When I sai=
d we turned whole devices on/off, I was referring only to what the system=
-level PM (which uses suspend/resume) does. There's a fair amount of subs=
ystem-specific power management outside the Linux suspend/resume framewor=
k. Some of it might be handled in the framework, if the framework were mo=
re capable.

scott

-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz]=20
Sent: Thursday, January 05, 2006 4:46 PM
To: Preece Scott-PREECE
Cc: Alan Stern; akpm@osdl.org; linux-pm@lists.osdl.org; linux-kernel@vger=
.kernel.org
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys in=
terface

On =C8t 05-01-06 17:21:38, Preece Scott-PREECE wrote:
> We do have multiple system-level low-power modes. I believe today they=20
> differ in turning whole devices on or off, but there are some of those=20
> devices that could be put in reduced-function/lowered-speed modes if=20
> we were ready to use a finer-grained distinction.

I think we were talking multiple off modes for _single device_. It is goo=
d to know that even cellphones can get away with whole devices on/off tod=
ay.
								Pavel

--
Thanks, Sharp!


--===============36762961375639253==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============36762961375639253==--
