From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 1/2] Input: enable i8042-level wakeup
 control
Date: Thu, 28 Jul 2011 11:08:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107281103180.1990-100000__28154.1468030357$1311865894$gmane$org@iolanthe.rowland.org>
References: <CAGq3pz6vr2gOq91Cz6KByhF4vdWEZqOOWECZhOCVD38kcyuEFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6715959970123041974=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGq3pz6vr2gOq91Cz6KByhF4vdWEZqOOWECZhOCVD38kcyuEFQ@mail.gmail.com>
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
To: Daniel Drake <dsd@laptop.org>
Cc: dtor@mail.ru, linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dilinger@queued.net
List-Id: linux-pm@vger.kernel.org

--===============6715959970123041974==
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id p6SF9dKm032634

On Thu, 28 Jul 2011, Daniel Drake wrote:

> On 28 July 2011 15:53, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Shouldn't this also check device_may_wakeup(dev)? =A0The user might
> > disable wakeup for the input device while leaving it enabled for the
> > i8042 device.
>=20
> As far as I'm aware, there aren't any instances where input devices
> are marked as wakeup-capable. So, we're speaking theoretically.

Aren't there?  I have no idea.  But if input devices are never=20
wakeup-capable, why do you name your function "input_may_wakeup()"?

> But, what would this mean? On OLPC for example, we can only control
> i8042 wakeups. This means we don't get to choose that we want keyboard
> wakeups and not mouse. If you enable i8042 wakeups you get both, and
> we can't change that, as the wakeup mechanism revolves around the
> i8042 controller.

I'm using a normal PC with PS/2 mouse and keyboard.  It is set up with
the keyboard as a wakeup source but not the mouse.  Of course, this=20
uses ACPI, which I assume isn't present on OLPC.

Alan Stern


--===============6715959970123041974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--===============6715959970123041974==--
