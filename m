From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] mac80211: make max_network_latency
 notifier atomic safe
Date: Wed, 09 Jun 2010 14:27:05 +0200
Message-ID: <1276086425.14580.14.camel__17402.9164402329$1276086481$gmane$org@jlt3.sipsolutions.net>
References: <1276074915-26879-1-git-send-email-florian@mickler.org>
	<1276076287.3727.15.camel@jlt3.sipsolutions.net>
	<20100609122050.1dd18132@schatten.dmk.lab>
	<1276080128.14580.5.camel@jlt3.sipsolutions.net>
	<20100609141643.14e9aedc@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100609141643.14e9aedc@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Rui Paulo <rpaulo@gmail.com>, Javier@smtp1.linux-foundation.org, markgross@thegnar.org, Jouni Malinen <j@w1.fi>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, Kalle Valo <kalle.valo@nokia.com>, james.bottomley@suse.de, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, Cardona <javier@cozybit.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-06-09 at 14:16 +0200, Florian Mickler wrote:

> That was also my first idea, but then I thought about qos and thought
> atomic notification are necessary.
> Do you see any value in having atomic notification? 
> 
> I have the following situation before my eyes:
> 
> 	Driver A gets an interrupt and needs (to service that
> 	interrupt) the cpu to guarantee a latency of X because the
> 	device is a bit icky.
> 
> Now, in that situation, if we don't immediately (without scheduling in
> between) notify the system to be in that latency-mode the driver won't
> function properly. Is this a realistic scene?
> 
> At the moment we only have process context notification and only 2
> listeners.
> 
> I think providing for atomic as well as "relaxed" notification could be
> useful. 
> 
> If atomic notification is deemed unnecessary, I have no
> problems to just use schedule_work() in update request.
> Anyway, it is probably best to split this. I.e. first make
> update_request callable from atomic contexts with doing the
> schedule_work in update_request and then
> as an add on provide for constraints_objects with atomic notifications.

Well I remember http://thread.gmane.org/gmane.linux.kernel/979935 where
Mark renamed things to "request" which seems to imply to me more of a
"please do this" than "I NEED IT NOW!!!!!".

johannes
