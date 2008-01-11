From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC v4] apm-emulation: notify about all suspend
	events, not just apm invoked ones
Date: Sat, 12 Jan 2008 08:55:19 +1100
Message-ID: <1200088519.6896.52.camel@pasglop>
References: <1199970729.3861.64.camel@johannes.berg>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1199970729.3861.64.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


On Thu, 2008-01-10 at 14:12 +0100, Johannes Berg wrote:
> This revamps the apm-emulation code (adding comments while at it) to
> get suspend notifications regardless of what way pm_suspend()
> was invoked, whether via the apm ioctl or via /sys/power/state.
> 
> This patch still contains the pm_chain_head export so that you can
> test it on 2.6.24-rc5 rather than only the suspend tree. If using
> the suspend tree just delete that hunk of the patch.
> 
> Not-yet-signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> Somehow I forgot about this. What do we want to do with it? I think it
> should be fine this way w/o the symbol export.

I haven't had time to test or review in details yet, sorry, I'm pretty
over-commited at the moment, but I agree with the approach.

Cheers,
Ben.
