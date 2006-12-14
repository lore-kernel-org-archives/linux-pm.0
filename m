From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: nokia 770 [was Re: community PM
	requirements/issues	and PowerOP]
Date: Thu, 14 Dec 2006 08:16:56 -0600 (CST)
Message-ID: <200612141416.kBEEGue8002350@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Dave Jones's message of Thu, 14 Dec 2006 08:17:12 -0500
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: davej@redhat.com
Cc: pavel@ucw.cz, amit.kucheria@nokia.com, scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


Well, if you're using a CPU that supports the same CPU frequency at
multiple voltages, then it's useful to be able to determine the voltage
as well as the frequency. You can't assume you want to use the lowest
voltage, because voltage changes may take significantly longer than
frequency changes.

In some situations you may want to contrain your frequency shifting to
stay at the current voltage, in other cases not, depending on what you
know about the current task load.

scott

| From linux-pm-bounces@lists.osdl.org Thu Dec 14 07:36:57 2006
| Date: Thu, 14 Dec 2006 08:17:12 -0500
| From: Dave Jones<davej@redhat.com>
| User-Agent: Mutt/1.4.2.2i
| X-Spam-Status: No, hits=3D-1.885 required=3D5 tests=3DAWL,OSDL_HEADER_LIS=
TID_KNOWN,OSDL_HEADER_SUBJECT_BRACKETED
| Cc: Pavel Machek<pavel@ucw.cz>, Amit Kucheria<amit.kucheria@nokia.com>,
| Precedence: list
| =

| On Thu, Dec 14, 2006 at 04:01:58PM +0300, Vitaly Wool wrote:
|  > On 12/14/06, Dave Jones <davej@redhat.com> wrote:
|  > >
|  > >
|  > > But what sense does it make for a user,sysadmin or application
|  > > to change voltage?  If any of these want to save power, they do so
|  > > by a) doing less work, and then b) lowering the clock speed as this
|  > > is inherently tied to voltage.
|  > >
|  > =

|  > It makes sense to perform changing an operating point dynamically in
|  > userland.
| =

| An operating point does not have to revolve around the voltage, nor shoul=
d it.
| Fill out the following.
| =

| * A sysadmin wants to set the CPU voltage to 1.5V because _______________=
__
| =

| * A user wants to set the CPU voltage to 1.5V because _________________
| =

| * An application wants to dynamically set the voltage rather than the
|   frequency because ______________________
| =

| =

|  > That said, voltage should be accessible from userland.
| =

| Try again.   It's completely the wrong knob to be turning.
| =

| 		Dave
| =

| -- =

| http://www.codemonkey.org.uk
| _______________________________________________
| linux-pm mailing list
| linux-pm@lists.osdl.org
| https://lists.osdl.org/mailman/listinfo/linux-pm
| =


-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
