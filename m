From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 15 Aug 2006 20:27:49 -0500 (CDT)
Message-ID: <200608160127.k7G1Rndl027916@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Dave Jones's message of Tue, 15 Aug 2006 15:04:40 -0400
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



| From: Dave Jones<davej@redhat.com>
| =

| On Tue, Aug 15, 2006 at 01:35:15PM +0300, Amit Kucheria wrote:
| =

|  > d. In the end, all this is leading to an interface for a user-space
|  > policy manager that will control _system_ power state based on
|  > constraints imposed by HW peripherals or on policies implemented by
|  > device manufacturer/distro maintainer.
| =

| How does that interface look from a userspace point of view ?
| Hopefully not anything like the tuple described above.
| Why would userspace ever care about "interconnect freq" ?
| =

| Userspace cares about "save power" or "go fast".
| Historically, I wish we had never exposed frequencies, but instead
| a performance percentage, so that the various userspace tools
| didn't have to care about things like 'what frequencies are available'.
| Adding the same mistake for voltages doesn't strike me as a fantastic ide=
a.
---

For us, "userspace" means a power policy manager that potentially has a
lot of awareness about the power needs of specific applications and the
overall use cases driving the device. There is no interface available or
visible to a "user".  The policy manager does want to know about
specific frequencies and voltages and their interaction, because they
determine the circumstances under which it makes sense to make
particular transitions.

As I think I mentioned at the PM Summit in April, it's important to
recognize that the power and performance implications of operating
points are not simply based on frequency. Sometimes you want so shift
"sideways", because changing one parameter may be preferable to changing
another. =


Note that we also want to be able to run the same code on a range of
devices that may have significantly different hardware performance, so
an abstract set of names (fastest to slowest, for instance) is also a
problem.  =


scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
