From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] pm_qos: reimplement using plists
Date: Fri, 2 Jul 2010 00:22:02 +0200
Message-ID: <201007020022.02711.rjw@sisk.pl>
References: <1277746434.10879.191.camel@mulgrave.site>
	<1277746942.10879.198.camel@mulgrave.site>
	<20100629043903.GA6250@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100629043903.GA6250@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-pm@lists.linux-foundation.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 29, 2010, mark gross wrote:
> On Mon, Jun 28, 2010 at 12:42:22PM -0500, James Bottomley wrote:
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
> Thank you for doing this!, I'll integrate it into some testing targets
> in the morning!
> 
> Signed-off-by: mark gross <markgross@thegnar.org>
> 
> --mgross
>  
> > Signed-off-by: James Bottomley <James.Bottomley@suse.de>

Applied to suspend-2.6/linux-next.

Rafael
