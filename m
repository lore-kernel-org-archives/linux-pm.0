From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 08/13] OMAP2+: powerdomain: control power
 domains next state
Date: Fri, 29 Jul 2011 11:00:47 -0700
Message-ID: <20110729180047.GA14228__23844.2223555923$1311962552$gmane$org@google.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-9-git-send-email-j-pihet@ti.com>
	<20110729075942.GA26959@google.com>
	<CAORVsuV68JhpV5XzXNV3Z9xxRUBbgDen7NDRG+h=in7-ZL=JhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAORVsuV68JhpV5XzXNV3Z9xxRUBbgDen7NDRG+h=in7-ZL=JhQ@mail.gmail.com>
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
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 29, 2011 at 10:47:43AM +0200, Jean Pihet wrote:
> On Fri, Jul 29, 2011 at 9:59 AM, Todd Poynor <toddpoynor@google.com> wrote:
...
> > All min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE paths need
> > free_new_user = 1.
> free_new_user = 1 is only needed if no existing constraint has been
> found, i.e. user stays at NULL. This is implemented in the check for
> an existing constraint (plist_for_each_entry(...)).

Oops, I meant to say it applies in all cases where min_latency ==
PM_QOS_DEV_LAT_DEFAULT_VALUE, since the new node is only used for
adding a constraint (and no existing constraint found).  I'd suggest
something like:

        if (min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE) {
                new_user = kzalloc(sizeof(struct pwrdm_wkup_constraints_entry),
                        GFP_KERNEL);
                <check NULL return>
                free_new_user = 1;
        }

and then set free_new_user = 0 only if no existing constraint is found
for the add case.  Because it's easy to miss cases where the
allocated memory needs to be freed when that's not the default, and you
might as well skip the allocate on a constraint removal.  Pretty minor
point, though.


Todd
