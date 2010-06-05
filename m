From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [RFC] pm_qos: reimplement using plists
Date: Sat, 05 Jun 2010 13:19:29 -0500
Message-ID: <1275761969.7227.19.camel@mulgrave.site>
References: <1275760688.7227.10.camel@mulgrave.site>
	<201006052017.22856.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006052017.22856.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-06-05 at 20:17 +0200, Rafael J. Wysocki wrote:
> On Saturday 05 June 2010, James Bottomley wrote:
> > A lot of the pm_qos extremal value handling is really duplicating what a
> > priority ordered list does, just in a less efficient fashion.  Simply
> > redoing the implementation in terms of a plist gets rid of a lot of this
> > junk (although there are several other strange things that could do with
> > tidying up, like pm_qos_request_list has to carry the pm_qos_class with
> > every node, simply because it doesn't get passed in to
> > pm_qos_update_request even though every caller knows full well what
> > parameter it's updating).
> > 
> > I think this redo is a win independent of android, so we should do
> > something like this now.
> 
> I like it.
> 
> > There is one nasty that should probably be fixed in plists not open
> > coded here: plist_first gives the highest priority value, but there's no
> > corresponding API to give the lowest (even though you can get it from
> > the head.nodes_list.prev) ... if the sched people are OK, I'll correct
> > this with the final patch set.
> 
> I assume you'll send a signed-off version at one point.

Yes ... probably as a two parter with the plist changes.

James
