From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] mac80211: make max_network_latency
 notifier atomic safe
Date: Wed, 09 Jun 2010 11:38:07 +0200
Message-ID: <1276076287.3727.15.camel__17954.1143625558$1276076343$gmane$org@jlt3.sipsolutions.net>
References: <1276074915-26879-1-git-send-email-florian@mickler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276074915-26879-1-git-send-email-florian@mickler.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: florian@mickler.org
Cc: Rui Paulo <rpaulo@gmail.com>, Javier@smtp1.linux-foundation.org, markgross@thegnar.org, Jouni Malinen <j@w1.fi>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, Kalle Valo <kalle.valo@nokia.com>, james.bottomley@suse.de, pm list <linux-pm@lists.linux-foundation.org>, Cardona <javier@cozybit.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-06-09 at 11:15 +0200, florian@mickler.org wrote:
> In order to have the pm_qos framework be callable from interrupt
> context, all listeners have to also be callable in that context.

That makes no sense at all. Why add work structs _everywhere_ in the
callees and make the API harder to use and easy to get wrong completely,
instead of just adding a single work struct that will be queued from the
caller and dealing with the locking complexity etc. just once.

johannes
