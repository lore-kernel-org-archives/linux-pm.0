From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Thu, 14 Sep 2006 22:05:06 -0500 (CDT)
Message-ID: <200609150305.k8F356IY029193@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: "Vitaly Wool"'s message of Thu, 14 Sep 2006 17:15:04 +0400
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: vitalywool@gmail.com
Cc: linux-pm@lists.osdl.org, matthew.a.locke@comcast.net, scott.preece@motorola.com, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


| From: "Vitaly Wool"<vitalywool@gmail.com>
| =

| Pavel,
| =

| On 9/14/06, Pavel Machek <pavel@ucw.cz> wrote:
| >
| > > Pavel,
| >
| > > > > operating points it is possible to implement the "cpufreq frequen=
cy
| > > > > selection logic" in user space and having such functionality in t=
he kernel
| > > > > just violates the main rule of having everything possible outside=
 of the
| > > > > kernel.
| > > >
| > > > You got the rules wrong. "Keep the code out of kernel" is important
| > > > rule, but probably not the main one.
| > >
| > > from aside, it looks like you're choosing 'rules' and assign then
| > > 'priorities' in a too arbitrary way which is by a strange accident
| > > fits your point of view best of all.
| > > May I remind you that Linux world is not only laptops and Sharp Zauru=
s? ;)
| >
| > Actually, laptops and zauruses seem to be the only "interesting"
| > machines from pm perspective. Then there are Motorola cellphones, but
| > Motorola tried hard not to enable users changing kernel... so they are
| > irrelevant.
| =

| Well, I never said Zaurus was no good :)
| Please don't forget about Nokia 770 and its possible follow-ups.
| Also, please keep in mind that if we come to a joint PM solution that
| is in mainline, Motorola will use it... and will be contributing
| changes back to the community. If there was a PM solution adopted in
| mainline which fit the needs of embedded devices, more vendors would
| turn to using Linux.
| I. e., what prevents Sharp from making a open-code Lnux-based cell
| phone? I do think that the absense of PM framework suitable for
| embedded is one of the main engineering reasons... So let us broaden
| our views and work together :)
| =

| Vitaly
---

Source for the power management in current Motorola products is
available on opensource.motorola.com. However, mainstream power
management did not meet our needs, so what's there is a replacement,
rather than modifications. Because it's product-specific, it's not
particularly generalized and probably wouldn't be suitable for use
in a laptop...

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
