From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Wed, 22 Dec 2010 13:29:40 +0100
Message-ID: <201012221329.40251.rjw__48207.7272180051$1293021055$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1012212032590.11252-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1012212032590.11252-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 22, 2010, Alan Stern wrote:
> On Tue, 21 Dec 2010, Rafael J. Wysocki wrote:
> 
> > It basically goes like this.  There's device A that is only resumed when it's
> > needed to carry out an operation and is suspended immediately after that.
> > There's another device B that needs A to do something during its suspend.
> > So, when the suspend of B is started, A is woken up, does its work and is
> > suspended again (using pm_runtime_suspend()).  Then B is suspended.
> > 
> > We currently require that ->suspend() and ->resume() callbacks be defined
> > for A (presumably pointing to the same code as its runtime callbacks) so that
> > things work correctly, but perhaps we can just relax this requirement a bit?
> > I'm not 100% sure that's a good idea, just considering it.
> 
> I still don't know.  It would require a lot of special conditions: no
> child devices, not runtime-PM-disabled, not runtime-PM-forbidden...  
> Also, A's parent would have to be coded carefully; otherwise A's
> runtime resume would prevent the parent from suspending.
> 
> This just doesn't fit very well with the runtime PM model, or at least, 
> not in the form you described.
> 
> Consider this instead:  Since A is required to be functional before B
> can be used, A must be registered before B and hence B gets suspended
> before A.  Therefore during the prepare phase we can runtime-resume A
> and leave it powered up; when B needs to suspend, it won't matter that
> the runtime-PM calls are ineffective.

We don't really need to do that, because the runtime resume _is_ functional
during system suspend.  The only thing missing is a ->suspend() callback for A
(and a corresponding ->resume() callback to make sure A will be available to
B during system resume).

> Then when A's dpm_suspend occurs, it can safely go to a low-power state and
> stay there.

Agreed.

Thanks,
Rafael
