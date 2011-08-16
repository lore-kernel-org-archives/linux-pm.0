From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 05/15] PM QoS: generalize and export the
 constraints management code
Date: Tue, 16 Aug 2011 10:45:57 -0700
Message-ID: <20110816174557.GA17027__20651.5281498016$1313516995$gmane$org@gvim.org>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
	<201108132234.17377.rjw@sisk.pl>
	<CAORVsuUz9qXFvUTsYOs4Z7rLQFXROKOcWVi=bZWTKJuA2Xu1Og@mail.gmail.com>
	<201108141537.43752.rjw@sisk.pl> <20110816040809.GA11921@gvim.org>
	<CAORVsuXDp4vYGg9BCLkJm6iMPobSCtE9s_1j4zNV5frKjQY1jg@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAORVsuXDp4vYGg9BCLkJm6iMPobSCtE9s_1j4zNV5frKjQY1jg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 16, 2011 at 08:44:19AM +0200, Jean Pihet wrote:
> On Tue, Aug 16, 2011 at 6:08 AM, mark gross <markgross@thegnar.org> wrote:
> > On Sun, Aug 14, 2011 at 03:37:43PM +0200, Rafael J. Wysocki wrote:
> >> On Sunday, August 14, 2011, Jean Pihet wrote:
> >> > Hi Rafael, Mark,
> >> >
> >> > On Sat, Aug 13, 2011 at 10:34 PM, Rafael J. Wysocki <rjw@sisk.pl> wr=
ote:
> >> > > On Saturday, August 13, 2011, mark gross wrote:
> >> > >> On Thu, Aug 11, 2011 at 05:06:42PM +0200, jean.pihet@newoldbits.c=
om wrote:
> >> > >> > From: Jean Pihet <j-pihet@ti.com>
> >> > >> >
> >> > >> > In preparation for the per-device constratins support:
> >> > >> > - rename update_target to pm_qos_update_target
> >> > >> > - generalize and export pm_qos_update_target for usage by the u=
pcoming
> >> > >> > per-device latency constraints framework:
> >> > >> > =A0 =A0. operate on struct pm_qos_constraints for constraints m=
anagement,
> >> > >> > =A0 =A0. introduce an 'action' parameter for constraints add/up=
date/remove,
> >> > >> > =A0 =A0. the return value indicates if the aggregated constrain=
t value has
> >> > >> > =A0 =A0 =A0changed,
> >> > >> > - update the internal code to operate on struct pm_qos_constrai=
nts
> >> > >> > - add a NULL pointer check in the API functions
> >> > >> >
> >> > >> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> >> > ...
> >> > >> > +/* Action requested to pm_qos_update_target */
> >> > >> > +enum pm_qos_req_action {
> >> > >> > + =A0 PM_QOS_ADD_REQ, =A0 =A0 =A0 =A0 /* Add a new request */
> >> > >> > + =A0 PM_QOS_UPDATE_REQ, =A0 =A0 =A0/* Update an existing reque=
st */
> >> > >> > + =A0 PM_QOS_REMOVE_REQ =A0 =A0 =A0 /* Remove an existing reque=
st */
> >> > >> > +};
> >> > >> > +
> >> > >>
> >> > >> What do you need this enum for? =A0The function names *_update_*,=
 *_add_*,
> >> > >> and =A0*_remove_* seem to be pretty redundant if you have to pass=
 an enum
> >> > >> that could possibly conflict with the function name.
> >> > >>
> >> > >> > =A0#ifdef CONFIG_PM
> >> > >> > +int pm_qos_update_target(struct pm_qos_constraints *c, struct =
plist_node *node,
> >> > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum pm_qos_req_action=
 action, int value);
> >> > >> The action for update_target better damn well be "PM_QOS_UPDATE_R=
EQ" or
> >> > >> there is something strange going on.... =A0BTW what shold this fu=
nction do
> >> > >> if the pm_qos_req_action was *not* the UPDATE one?
> >> >
> >> > The meaning of pm_qos_update_target is 'update the PM QoS target
> >> > constraints lists'. As described in the changelog the intention of
> >> > this patch is to implement the constraints lists management logic in
> >> > update_target and simplify the API functions (add/update/remove). It
> >> > is also exported for the upcoming (patch 06/15]) to use it as well.
> >>
> >> The enums are fine by me and they allow us to simplify the code
> >> quite a bit.
> >>
> > Ok, but they look a bit sloppy to me as we now have an API that says
> > "add" we can actually pass in an enum that says "remove".
> We have an API that says 'update target' that we pass in a parameter
> that says 'add request', 'update request' or 'remove request'.
> If it is required I could just rename the internal function
> update_target, in a later patch.

You are right.  I thought I saw the enum added to the other API's for
some reason.  Still, with this update we have an API overloaded through
that enum parameter providing 2 add, 2 delete and 2 update API's  Each
pair doing about the same thing.

To me it feels like a baby step toward an ioctl type of API that I don't
like.  I'm not going to fight about it any more but I don't like such
API's as they tend to get hard to read and get out of control.

please rethink this a little.
--mark
