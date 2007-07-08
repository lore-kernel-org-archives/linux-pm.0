From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sun, 08 Jul 2007 15:19:01 +1000
Message-ID: <1183871941.3388.286.camel__31976.0023769506$1183872007$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<1183871661.3388.282.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183871661.3388.282.camel@localhost.localdomain>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> I think it's a fairly significant change from the current freezer and I
> also think it's a very good idea. The more I think about it, the more I
> like it, in the sense that it's a simple drop-in that you could put in a
> lot of the ioctl path of drivers to just block tasks that are trying to
> call in while suspending, and could be used selectively by things like
> the USB hub threads.

Note that we could have also a per-device "icebox" (just a waitqueue).
Might be nice for a device to resume whatever it froze just after it
resumed itself, might even be necessary in case whatever thread got
frozen is necessary for handling child devices.

Cheers,
Ben.
