From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: RE: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 17:21:38 -0500
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3283780883713131=="
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
To: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>
Cc: akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============3283780883713131==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8bit

We do have multiple system-level low-power modes. I believe today they
differ in turning whole devices on or off, but there are some of those
devices that could be put in reduced-function/lowered-speed modes if we
were ready to use a finer-grained distinction.

This is, of course, in an embedded framework rather than a desktop
framework - we suspend and wakeup automatically, not via user
intervention. Answering a question asked in another piece of mail, we
have roughly a dozen different devices that cause the system to wakeup -
keypad press, touchscreen touch, flip open/close, etc.

And, PCI is totally alien to us...

scott  

-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz] 

Bring example hardware that needs more than two states, implement driver
support for that, and then we can talk about adding more than two states
into core code.

								Pavel


And from another mail:

Out of curiosity, are there really cases where there is > 1 wakeup
device?

--
Thanks, Sharp!


--===============3283780883713131==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============3283780883713131==--
