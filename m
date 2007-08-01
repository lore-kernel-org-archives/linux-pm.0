From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Re: Possible problem with device_move()
Date: Wed, 1 Aug 2007 19:04:06 +0200
Message-ID: <20070801190406.6c53ccc4@gondolin.boeblingen.de.ibm.com>
References: <20070801150332.41f447c8@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0708011119380.3764-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0708011119380.3764-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007 11:22:12 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> As it stands right now, every place device_move() gets called is 
> already special!

The "special cases" I was thinking about are those where the order to
suspend/resume is not covered by a parent/child relationship, but by
(possibly random) order of registration. I'd have thought the rule "the
child must be suspended before the parent" was pretty straightforward,
but...
> 
> I'm afraid of reordering devices automatically; there's too much 
> potential for creating new problems.  When a driver calls device_move() 
> or does something similar, it should know what sort of list 
> rearrangement is safe.  But the PM core can't be expected to know.

...you have a point here. Automatic reordering may destroy other
ordering, so we shouldn't do it.

(The whole list based on registration order thing seems a bit fragile
to me, but I don't know enough of the PM core and suspend/resume in
general to make a better suggestion :/)
