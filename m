From: Florian Mickler <florian@mickler.org>
Subject: Re: [RFC PATCH 1/2] mac80211: make max_network_latency
 notifier atomic safe
Date: Wed, 9 Jun 2010 12:20:50 +0200
Message-ID: <20100609122050.1dd18132__11929.6670229689$1276079069$gmane$org@schatten.dmk.lab>
References: <1276074915-26879-1-git-send-email-florian@mickler.org>
	<1276076287.3727.15.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276076287.3727.15.camel@jlt3.sipsolutions.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Rui Paulo <rpaulo@gmail.com>, Javier@smtp1.linux-foundation.org, markgross@thegnar.org, Jouni Malinen <j@w1.fi>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, Kalle Valo <kalle.valo@nokia.com>, james.bottomley@suse.de, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, Cardona <javier@cozybit.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 09 Jun 2010 11:38:07 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2010-06-09 at 11:15 +0200, florian@mickler.org wrote:
> > In order to have the pm_qos framework be callable from interrupt
> > context, all listeners have to also be callable in that context.
> 
> That makes no sense at all. Why add work structs _everywhere_ in the
> callees and make the API harder to use and easy to get wrong completely,
> instead of just adding a single work struct that will be queued from the
> caller and dealing with the locking complexity etc. just once.
> 
> johannes

Just to defend this approach, but I'm certainly not married to it
(hence RFC):

There are only two listeners at the moment. I suspect that most future
uses of the framework need to be atomic, as the driver that
requests a specific quality of service probably doesn't want to get into
races with the provider of that service(listener). So i suspected the
network listener to be the special case.  

The race between service-provider and qos-requester for non-atomic
contextes is already there, isn't it? so, locking complexity shouldn't
be worse than before.

But my first approach to this is seen here:
https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/026902.html

A third possibility would be to make it dependent on the
type of the constraint, if blocking notifiers are allowed or not. 
But that would sacrifice API consistency (update_request for one
constraint is allowed to be called in interrupt context and
update_request for another would be not).

Cheers,
Flo
