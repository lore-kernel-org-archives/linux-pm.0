From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH] PM: Add convenience macro to make switching
	to dev_pm_ops less error-prone
Date: Wed, 5 Aug 2009 22:17:47 +0200
Message-ID: <74d0deb30908051317o61b31117t35aaf8b9f02710d7__13328.529315959$1249507290$gmane$org@mail.gmail.com>
References: <20090803163304.GF5002@laptop> <20090805093758.GE5854@laptop>
	<200908052047.26293.rjw@sisk.pl> <200908052205.14222.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908052205.14222.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Frans Pop <elendil@planet.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Linux PM List <linux-pm@lists.linux-foundation.org>, Albin Tonnerre <albin.tonnerre@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 5, 2009 at 10:05 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Wednesday 05 August 2009, Rafael J. Wysocki wrote:
>> On Wednesday 05 August 2009, Albin Tonnerre wrote:
>> > On Tue, Aug 04, 2009 at 09:55:33PM -0700, Dmitry Torokhov wrote :
>> > > On Tue, Aug 04, 2009 at 11:36:12AM +0200, Albin Tonnerre wrote:
>> > > > In a number of cases, the .suspend, .freeze, .poweroff and .resume,
>> > > > .thaw, .restore functions are identical. However, they all need to=
 be
>> > > > assigned to avoid regressionsm as the previous code called .suspend
>> > > > resp. .resume in all those cases. SIMPLE_PM_OPS allows to deal with
>> > > > this case.
>> >
>> >
>> > > I'd much rather have conversions done with a bit more analysis now t=
hat
>> > > our framework is more flexible and we can have specialized routines =
for
>> > > hibernation and suspend.
>> >
>> > I still think that even though they can, quite a number of drivers won=
't
>> > /need/ to have different functions for this, but maybe I'm mistaken.
>> >
>> > > Maybe we should try changing from run-time to build time warning so =
that
>> > > users are not overly concerned with it?
>> >
>> > I'm not sure that solves the problem. The fact is that even for develo=
pers, it's
>> > easy to overlook that assiging only the .suspend and .resume fields is=
 probably
>> > a mistake.
>>
>> I agree, so I'm going to take the patch.
>>
>> I'll add a comment describing what the macro is for, though.
>
> Strictly speaking, I'm going to add the appended patch to the linux-next
> branch of the suspend-2.6 tree.
>
> Thanks,
> Rafael
>
> ---
> From: Albin Tonnerre <albin.tonnerre@free-electrons.com>
> Subject: PM: Add convenience macro to make switching to dev_pm_ops less e=
rror-prone
>
> In a number of cases, the .suspend, .freeze, .poweroff and .resume,
> .thaw, .restore functions are identical. However, they all need to be
> assigned to avoid regressionsm as the previous code called .suspend
> resp. .resume in all those cases. SIMPLE_DEV_PM_OPS helps to deal
> with this case.
>
> [rjw: Changed the name of the macro and added the comment explaining its
> =A0purpose.]
>
> Signed-off-by: Albin Tonnerre <albin.tonnerre@free-electrons.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =A0include/linux/pm.h | =A0 14 ++++++++++++++
> =A01 file changed, 14 insertions(+)
>
> Index: linux-2.6/include/linux/pm.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/pm.h
> +++ linux-2.6/include/linux/pm.h
> @@ -184,6 +184,20 @@ struct dev_pm_ops {
> =A0 =A0 =A0 =A0int (*restore_noirq)(struct device *dev);
> =A0};
>
> +/*
> + * Use this if you want to use the same suspend and resume callbacks for=
 suspend
> + * to RAM and hibernation.
> + */
> +#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> +struct dev_pm_ops name =3D { \
> + =A0 =A0 =A0 .suspend =3D suspend_fn, \
> + =A0 =A0 =A0 .resume =3D resume_fn, \
> + =A0 =A0 =A0 .freeze =3D suspend_fn, \
> + =A0 =A0 =A0 .thaw =3D resume_fn, \
> + =A0 =A0 =A0 .poweroff =3D suspend_fn, \
> + =A0 =A0 =A0 .resume =3D resume_fn, \

I think that second .resume was intended to be .restore instead.

regards
Philipp
