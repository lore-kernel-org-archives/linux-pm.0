From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 08/13] OMAP2+: powerdomain: control power
	domains next state
Date: Thu, 11 Aug 2011 17:09:59 +0200
Message-ID: <CAORVsuWHc=ybjTAXe7=Dqj4Pnme6q29eqN0t3AHVkZE5CL+RpA__8182.59321754358$1313077290$gmane$org@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-9-git-send-email-j-pihet@ti.com>
	<20110729075942.GA26959@google.com>
	<CAORVsuV68JhpV5XzXNV3Z9xxRUBbgDen7NDRG+h=in7-ZL=JhQ@mail.gmail.com>
	<20110729180047.GA14228@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110729180047.GA14228@google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Todd Poynor <toddpoynor@google.com>
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Todd,

On Fri, Jul 29, 2011 at 8:00 PM, Todd Poynor <toddpoynor@google.com> wrote:
> On Fri, Jul 29, 2011 at 10:47:43AM +0200, Jean Pihet wrote:
>> On Fri, Jul 29, 2011 at 9:59 AM, Todd Poynor <toddpoynor@google.com> wro=
te:
> ...
>> > All min_latency !=3D PM_QOS_DEV_LAT_DEFAULT_VALUE paths need
>> > free_new_user =3D 1.
>> free_new_user =3D 1 is only needed if no existing constraint has been
>> found, i.e. user stays at NULL. This is implemented in the check for
>> an existing constraint (plist_for_each_entry(...)).
>
> Oops, I meant to say it applies in all cases where min_latency =3D=3D
> PM_QOS_DEV_LAT_DEFAULT_VALUE, since the new node is only used for
> adding a constraint (and no existing constraint found). =A0I'd suggest
> something like:
>
> =A0 =A0 =A0 =A0if (min_latency !=3D PM_QOS_DEV_LAT_DEFAULT_VALUE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_user =3D kzalloc(sizeof(struct pwrdm_w=
kup_constraints_entry),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<check NULL return>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_new_user =3D 1;
> =A0 =A0 =A0 =A0}
>
> and then set free_new_user =3D 0 only if no existing constraint is found
> for the add case. =A0Because it's easy to miss cases where the
> allocated memory needs to be freed when that's not the default, and you
> might as well skip the allocate on a constraint removal. =A0Pretty minor
> point, though.

This has been addressed in the latest patch set (v4).

Regards,
Jean

>
>
> Todd
>
