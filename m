From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Wed, 21 Mar 2007 15:19:39 -0500 (CDT)
Message-ID: <200703212019.l2LKJdbj029831@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: "Amit Kucheria"'s message of Wed, 21 Mar 2007 17:21:47 +0200
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: kucheria.amit@gmail.com
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


| From: "Amit Kucheria"<kucheria.amit@gmail.com>
| =

| On 3/21/07, Shaohua Li <shaohua.li@intel.com> wrote:
| > On Wed, 2007-03-21 at 02:30 +0800, Pavel Machek wrote:
| =

| > > No, that's not how it works; look at hda_audio, it already has
| > > powersave. Just power down audio card 5 seconds after its control file
| > > is closed.
| > It's another case of doing policy in a driver.
| >
| =

| IMHO, this kind of policy is best handled inside the driver because it
| is specific to the hardware. This will ensure that the driver will
| just work on every distro without some userspace policy being present
| and setup _correctly_.
---

On an embedded device, the knowledge of when it makes sense to keep a
disk spinning, to avoid latency when it's needed next, versus when it
makes sense to spin it down to save power, probably fits better in user
space than in the kernel. In such a case there's likely to be a "master"
application (in our case, for instance, "the phone application") that
owns a lot of knowledge about whole-system state and user interactions.
Not, of course, that we have a disk to spin down.

On the other hand, we also have devices that do their own power saving,
largely in cases where they don't have latency issues large enough to
worry about.

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
