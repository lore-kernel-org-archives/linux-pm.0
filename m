From: Steven Toth <stoth@linuxtv.org>
Subject: Re: [linux-dvb] question on struct dvb_frontend_ops.sleep
Date: Wed, 27 Aug 2008 10:08:14 -0400
Message-ID: <48B55FCE.3020907__45739.2394812361$1219850059$gmane$org@linuxtv.org>
References: <200808271141.55546.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200808271141.55546.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, linux-dvb@linuxtv.org
List-Id: linux-pm@vger.kernel.org

Oliver Neukum wrote:
> Hi,
> 
> could somebody explain to me what the semantics of this call is?
> It seems like dvbcore uses it to tell a device that it may power down.
> But when is it to power up again? Is powering up implied in every
> other method of the API? Can these methods sleep?

Isn't init it's powerup equivalent?

- Steve
