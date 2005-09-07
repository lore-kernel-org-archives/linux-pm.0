From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp doesn't suspend devices
Date: Wed, 7 Sep 2005 22:03:18 +0200
Message-ID: <200509072203.19283.rjw@sisk.pl>
References: <431ECCE3.8080408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <431ECCE3.8080408@drzeus.cx>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@osdl.org, Pavel Machek <pavel@ucw.cz>, Pierre Ossman <drzeus-list@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of September 2005 13:20, Pierre Ossman wrote:
> It would seem that swsusp doesn't properly suspend devices, or more
> precisely it wakes them up again before suspending the machine.

Yes, it does.  By design.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
