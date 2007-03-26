From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Mon, 26 Mar 2007 16:53:16 +0300
Message-ID: <52d486620703260653l73ffde92we68b413cc61a9144@mail.gmail.com>
References: <200703212019.l2LKJdbj029831@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703212019.l2LKJdbj029831@olwen.urbana.css.mot.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On 3/21/07, Scott E. Preece <preece@motorola.com> wrote:
>
> | From: "Amit Kucheria"<kucheria.amit@gmail.com>
> |
> | On 3/21/07, Shaohua Li <shaohua.li@intel.com> wrote:
> | > On Wed, 2007-03-21 at 02:30 +0800, Pavel Machek wrote:
> |
> | > > No, that's not how it works; look at hda_audio, it already has
> | > > powersave. Just power down audio card 5 seconds after its control f=
ile
> | > > is closed.
> | > It's another case of doing policy in a driver.
> | >
> |
> | IMHO, this kind of policy is best handled inside the driver because it
> | is specific to the hardware. This will ensure that the driver will
> | just work on every distro without some userspace policy being present
> | and setup _correctly_.
> ---

I was playing devil's advocate here. Considering who I work for, we
definitely have cases where having all these settings configurable
from userspace sounds like a very good idea. But after thinking some
more, I am worried about having too many things exported to userspace
and increasing the complexity of the policy manager. Combined with
poorly chosen default values, it would mean that one could never
compile and flash a kernel that would give good battery life without
also running the vendor-shipped user-space policy manager that might
be binary only.

> On an embedded device, the knowledge of when it makes sense to keep a
> disk spinning, to avoid latency when it's needed next, versus when it
> makes sense to spin it down to save power, probably fits better in user
> space than in the kernel. In such a case there's likely to be a "master"
> application (in our case, for instance, "the phone application") that
> owns a lot of knowledge about whole-system state and user interactions.
> Not, of course, that we have a disk to spin down.
>
> On the other hand, we also have devices that do their own power saving,
> largely in cases where they don't have latency issues large enough to
> worry about.

I believe we do need something along the lines of what USB has as
pointed out by Alan - an 'idle time' value and a 'allowed target
state' entry.

Regards,
Amit
--
Amit Kucheria, NOKIA
