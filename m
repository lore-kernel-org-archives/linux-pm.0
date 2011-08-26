From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Fri, 26 Aug 2011 09:54:27 -0700
Message-ID: <20110826165427.GC9437__19306.6981657923$1314377729$gmane$org@gvim.org>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-3-git-send-email-j-pihet@ti.com>
	<CAJ0PZbRCvoh8-rJAR92Ak_JPk4FyR0dp_OeKOUkWtD5AdFsPCw@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJ0PZbRCvoh8-rJAR92Ak_JPk4FyR0dp_OeKOUkWtD5AdFsPCw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 26, 2011 at 11:25:13AM +0900, MyungJoo Ham wrote:
> On Fri, Jul 1, 2011 at 12:11 AM,  <jean.pihet@newoldbits.com> wrote:
> > @@ -129,19 +146,19 @@ static const struct file_operations pm_qos_power_=
fops =3D {
> > =A0/* unlocked internal variant */
> > =A0static inline int pm_qos_get_value(struct pm_qos_object *o)
> > =A0{
> > - =A0 =A0 =A0 if (plist_head_empty(&o->requests))
> > + =A0 =A0 =A0 if (plist_head_empty(o->requests))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return o->default_value;
> >
> > =A0 =A0 =A0 =A0switch (o->type) {
> > - =A0 =A0 =A0 case PM_QOS_MIN:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_first(&o->requests)->prio;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case PM_QOS_MIN:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_first(o->req=
uests)->prio;
> >
> > - =A0 =A0 =A0 case PM_QOS_MAX:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_last(&o->requests)->prio;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case PM_QOS_MAX:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_last(o->requ=
ests)->prio;
> >
> > - =A0 =A0 =A0 default:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* runtime check for not using enum */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* runtime check for not =
using enum */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> > =A0 =A0 =A0 =A0}
> > =A0}
> =

> Hello,
> =

> =

> Sorry to jump in this late, but, I've got a question in choosing QoS
> value from the list with pm_qos_get_value function and pm_qos_type.
> =

> For QoS objects such as network throughput, wouldn't "PM_QOS_ADD" be
> more appropriate than PM_QOS_MAX?
> If A is requesting 10MB/s on NIC-X and B is requesting 5MB/s on NIC-X,
> I guess PM QOS should say NIC-X that it needs to provide 15MB/s, not
> 10MB/s. Or, are we assuming that A and B will never put streams at the
> same time?

This was brought up a few years back as well.  The reason we kept the
aggregate QoS for network Throughput as a max instead of a sum was that
there where already a number of interfaces for network shaping and we
didn't have a good answer to the problem of what to do when the
throughput qos requested exceeds hardware capabilities.  =


Now that I have more experience with handsets I'm not sure it makes any
practical difference to sum or max the throughput qos requests.  So if
someone would like it to aggregate throughputs by summation of requests
that could be done.  =


It turns out its the latency requests that are really used.

The network qos parameters also have a problem with discriminating
between what physical interface the QoS is for.  This limitation in the
ABI is partially addressed with some of the work that Jean Pihet's
patches are doing.

--mark
